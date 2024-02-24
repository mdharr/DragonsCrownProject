import { PlayerClassService } from './../../services/player-class.service';
import { AuthService } from './../../services/auth.service';
import { AfterViewInit, Component, ElementRef, inject, OnDestroy, OnInit, QueryList, ViewChildren } from '@angular/core';
import { PlayerClass } from 'src/app/models/player-class';
import { Subscription } from 'rxjs';
import { Skill } from 'src/app/models/skill';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit, OnDestroy, AfterViewInit {

  // properties
  playerClasses: PlayerClass[] = [];
  currentStats: any;
  currentSpriteUrl: string = '';
  totalExp: number = 0;

  // observed elements
  @ViewChildren('observedElement') observedElements!: QueryList<ElementRef>;

  // booleans
  classSelected: boolean = false;
  currentClassData: any = null;
  selectedClassIndex: number | null = null;
  selected: boolean = false;
  artworkLoaded: boolean = false;
  commonSkills: Skill[] = [];
  uniqueSkills: Skill[] =[];

  // tooltip
  tooltipVisible: boolean = false;
  tooltipUrl: string = '';
  tooltipIndex: number | null = null;
  tooltipTop: number = 0;
  tooltipLeft: number = 0;
  tooltipPosition = { top: 0, left: 0 };

  // typewriter
  currentTimeoutId: number | null = null;

  // subscriptions
  private playerClassSubscription: Subscription | undefined;

  // dependencies
  auth = inject(AuthService);
  playerClassService = inject(PlayerClassService);

  ngOnInit() {
    this.resetWindowPosition();
    this.subscribeToPlayerClassData();
  }

  ngOnDestroy() {
    if(this.playerClassSubscription) {
      this.playerClassSubscription.unsubscribe();
    }
  }

  ngAfterViewInit(): void {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('fadeIn');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.1 });

    this.observedElements.forEach(element => {
      observer.observe(element.nativeElement);
    });
  }

  subscribeToPlayerClassData() {
    this.playerClassSubscription = this.playerClassService.indexAll().subscribe({
      next: (data) => {
        this.playerClasses = data;
        // console.log(this.playerClasses);
      },
      error: (fail) => {
        console.error('Error retrieving player classes data');
        console.error(fail);
      }
    });
  }

  resetWindowPosition() {
    history.scrollRestoration = 'manual';
    window.scrollTo(0, 0);
  }

  resetPortraits() {
    const ul = document.querySelector('#portraits-ul');
    if(ul) {
      Array.from(ul.childNodes).forEach(child => {
        const element = child as HTMLElement;
        element.style.opacity = '0.5';
        element.style.filter = 'drop-shadow(2px 4px 4px rgba(0, 0, 0, 0.5))';
      })
    }
  }

  selectPortrait(elementId: string) {
    const element = document.querySelector(`#${elementId}`) as HTMLElement;
    element.style.opacity = '1';
    element.style.filter = 'filter: drop-shadow(2px 4px 10px rgba(0, 0, 0, 0.5)) brightness(1.1)';
  }

  loadClassData(classIndex: number): void {
    this.classSelected = true;
    if(this.classSelected) {
      this.selected = true;
      const descriptionElement = document.querySelector('.class-description') as HTMLElement;
      console.log(descriptionElement);
      this.selectedClassIndex = classIndex;
      this.currentClassData = this.playerClasses[classIndex];
      this.currentSpriteUrl = this.currentClassData?.spriteStartUrl;
      // Reset currentStats to the initial state for the newly selected class
      this.currentStats = { ...this.currentClassData.classStats[0] };
      console.log(this.currentClassData);
      console.log(this.currentStats);
      this.typeOutText(this.currentClassData.description, 'description-text');
    }
  }

  onArtworkLoad() {
    console.log('High-quality image loaded');
    this.artworkLoaded = true;
  }

  // Modify level change methods to ensure they are updating the view based on the model correctly
  levelUp(): void {
    if (!this.currentStats) {
      console.error('Current stats not defined');
      return;
    }
    // Ensure newLevel calculation uses a number from currentStats
    const newLevel = Number(this.currentStats.level) + 1;
    this.updateLevel(newLevel);
  }

  levelDown(): void {
    if (!this.currentStats || this.currentStats.level <= 1) {
      console.error('Current stats not defined or already at minimum level');
      return;
    }
    const newLevel = Number(this.currentStats.level) - 1;
    this.updateLevel(newLevel);
  }

  resetLevel() {
    this.updateLevel(1);
  }

  updateLevel(newLevel: number): void {
    const validLevel = Math.max(1, Math.min(newLevel, 99)); // Ensure level is within bounds
    const stats = this.currentClassData.classStats.find((stat: { level: number; }) => stat.level === validLevel);
    if (stats) {
      this.currentStats = { ...stats };
    } else {
      console.error('Stats for level', validLevel, 'not found');
    }
    this.calculateTotalExperience();
  }

  onLevelChange(): void {
    const enteredLevel = Number(this.currentStats.level);
    // Call updateLevel with the sanitized, numeric level value
    this.updateLevel(enteredLevel);
  }

  async typeOutText(input: string, elementId: string): Promise<void> {
    const element = document.getElementById(elementId) as HTMLParagraphElement;
    if (!element) {
        console.error('Element not found');
        return;
    }

    // Clear existing text content
    element.textContent = '';

    // If there's an ongoing typing animation, clear the timeout
    if (this.currentTimeoutId !== null) {
        clearTimeout(this.currentTimeoutId);
        this.currentTimeoutId = null;
    }

    for (let i = 0; i < input.length; i++) {
        // Check if we should stop the typing animation
        if (this.currentTimeoutId === null && i !== 0) {
            return;
        }

        // Wait for a bit before typing the next character
        await new Promise<void>((resolve) => {
            this.currentTimeoutId = window.setTimeout(() => {
                element.textContent += input[i];
                resolve();
            }, 10);
        });
    }

    // Reset the timeout ID to allow for new typing animations
    this.currentTimeoutId = null;
  }

  showTooltip(event: MouseEvent, gifUrl: string, index: number): void {
    const element = event.currentTarget as HTMLElement;
    const rect = element.getBoundingClientRect();

    this.tooltipVisible = true;
    this.tooltipUrl = gifUrl;
    this.tooltipIndex = index;
    this.tooltipTop = rect.top + window.scrollY - element.offsetHeight; // This should be a number
    this.tooltipLeft = rect.left + window.scrollX; // This should be a number
  }

  hideTooltip(): void {
    this.tooltipVisible = false;
    this.tooltipUrl = '';
    this.tooltipIndex = null;
  }

  changeSpriteTo(type: 'start' | 'end') {
    if (type === 'start') {
      this.currentSpriteUrl = this.currentClassData?.spriteStartUrl;
    } else {
      this.currentSpriteUrl = this.currentClassData?.spriteEndUrl;
    }
  }

  calculateTotalExperience() {
    const level = this.currentStats.level - 1;
    let total = 0;
    // console.log("CURRENT LEVEL:" + level);
    // console.log(this.currentClassData.classStats[level].requiredExp);
    for(let i = level; i >= 1; i--) {
      total += this.currentClassData.classStats[level].requiredExp
    }
    this.totalExp = total;
  }

}
