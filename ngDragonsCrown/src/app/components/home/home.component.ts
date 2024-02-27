import { SkillDetails } from './../../models/skill-details';
import { PlayerClassService } from './../../services/player-class.service';
import { AuthService } from './../../services/auth.service';
import { AfterViewInit, Component, ElementRef, inject, OnDestroy, OnInit, QueryList, Renderer2, ViewChild, ViewChildren } from '@angular/core';
import { PlayerClass } from 'src/app/models/player-class';
import { Subscription } from 'rxjs';
import { Skill } from 'src/app/models/skill';
import { Quest } from 'src/app/models/quest';

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
  commonSkills: Skill[] = [];
  uniqueSkills: Skill[] =[];
  currentLevel: number = 1;
  currentSkill: Skill = new Skill();
  selectedSkillIndex: number | null = null;
  selectedSkill: { index: number | null, type: 'common' | 'unique' | null } = { index: null, type: null };
  quests: Quest[] = [];
  selectedQuests: Quest[] = [];
  // currentSkillPoints: number = 0;
  currentQuestSP: number = 0;
  currentLevelSP: number = 0;
  totalAvailableSP: number = 0;

  // observed elements
  @ViewChildren('observedElement') observedElements!: QueryList<ElementRef>;
  @ViewChild('sheenBox', { static: false }) sheenBoxRef: ElementRef | undefined;

  // booleans
  classSelected: boolean = false;
  currentClassData: any = null;
  selectedClassIndex: number | null = null;
  selected: boolean = false;
  artworkLoaded: boolean = false;
  showCommonSkills: boolean = true;
  skillSelected: boolean = false;
  currentSkillEffects: string[] = [];
  skillCardLoaded: boolean = false;
  isModalVisible = false;
  viewQuests: boolean = false;

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
  renderer = inject(Renderer2);

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
    this.skillSelected = false;
    this.currentSkill = new Skill();
    this.selectedSkill = { index: null, type: null };
    this.viewQuests = false;
    this.currentLevelSP = 1;

    if(this.classSelected) {
      this.selected = true;
      const descriptionElement = document.querySelector('.class-description') as HTMLElement;
      console.log(descriptionElement);
      this.selectedClassIndex = classIndex;
      this.currentClassData = this.playerClasses[classIndex];
      this.commonSkills = this.currentClassData.skills
        .filter((skillObj: { skill: { common: boolean; }; }) => skillObj.skill.common === true)
        .map((skillObj: { skill: any; }) => skillObj.skill);

      this.uniqueSkills = this.currentClassData.skills
        .filter((skillObj: { skill: { common: boolean; }; }) => skillObj.skill.common === false)
        .map((skillObj: { skill: any }) => skillObj.skill);

      this.quests = this.currentClassData.quests.map((questObj: { quest: any }) => questObj.quest);

      this.showCommonSkills = true;

      this.currentSpriteUrl = this.currentClassData?.spriteStartUrl;

      this.currentStats = { ...this.currentClassData.classStats[0] };
      this.updateSkillPoints();

      console.log(this.currentClassData);
      console.log(this.currentStats);

      this.typeOutText(this.currentClassData.description, 'description-text');
    }
  }

  onArtworkLoad() {
    console.log('High-quality image loaded');
    this.artworkLoaded = true;
  }

  levelUp(): void {
    if (!this.currentStats) {
      console.error('Current stats not defined');
      return;
    }
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
    this.updateSkillPoints();
    this.calculateTotalExperience();
  }

  onLevelChange(): void {
    const enteredLevel = Number(this.currentStats.level);
    this.updateLevel(enteredLevel);
  }

  async typeOutText(input: string, elementId: string): Promise<void> {
    const element = document.getElementById(elementId) as HTMLParagraphElement;
    if (!element) {
        console.error('Element not found');
        return;
    }

    element.textContent = '';

    if (this.currentTimeoutId !== null) {
        clearTimeout(this.currentTimeoutId);
        this.currentTimeoutId = null;
    }

    for (let i = 0; i < input.length; i++) {
        if (this.currentTimeoutId === null && i !== 0) {
            return;
        }

        await new Promise<void>((resolve) => {
            this.currentTimeoutId = window.setTimeout(() => {
                element.textContent += input[i];
                resolve();
            }, 10);
        });
    }

    this.currentTimeoutId = null;
  }

  showTooltip(event: MouseEvent, gifUrl: string, index: number): void {
    const element = event.currentTarget as HTMLElement;
    const rect = element.getBoundingClientRect();

    this.tooltipVisible = true;
    this.tooltipUrl = gifUrl;
    this.tooltipIndex = index;
    this.tooltipTop = rect.top + window.scrollY - element.offsetHeight;
    this.tooltipLeft = rect.left + window.scrollX;
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
    for(let i = level; i >= 1; i--) {
      total += this.currentClassData.classStats[level].requiredExp
    }
    this.totalExp = total;
  }

  viewCommonSkills() {
    if(this.showCommonSkills === false || this.showCommonSkills === true) {
      this.viewQuests = false;
      this.showCommonSkills = true;
      const commonBtn = document.querySelector('#common-btn');
      const uniqueBtn = document.querySelector('#unique-btn');
      uniqueBtn?.classList.remove('selected-skills');
      commonBtn?.classList.add('selected-skills');
    }
  }

  viewUniqueSkills() {
    if(this.showCommonSkills === true || this.showCommonSkills === false) {
      this.viewQuests = false;
      this.showCommonSkills = false;
      const commonBtn = document.querySelector('#common-btn');
      const uniqueBtn = document.querySelector('#unique-btn');
      commonBtn?.classList.remove('selected-skills');
      uniqueBtn?.classList.add('selected-skills');
    }
  }

  viewQuestList() {
    this.viewQuests = true;
  }

  async selectSkill(skillIndex: number, skillType: 'common' | 'unique'): Promise<void> {
    this.selectedSkill = { index: skillIndex, type: skillType };
    this.skillSelected = true;
    this.skillCardLoaded = false;
    this.toggleGlassEffect();

    const skill = skillType === 'common' ? this.commonSkills[skillIndex] : this.uniqueSkills[skillIndex];
    this.currentSkill = skill;

    try {
      await this.preloadImage(skill.cardImageUrl);
      this.skillCardLoaded = true;

    } catch (error) {
      console.error('Image loading failed', error);

    }
  }

  toggleGlassEffect(): void {
    if (this.sheenBoxRef && this.sheenBoxRef.nativeElement) {
      const sheenBox = this.sheenBoxRef.nativeElement;
      if (sheenBox.classList.contains('glass')) {
        this.renderer.removeClass(sheenBox, 'glass');
        setTimeout(() => this.renderer.addClass(sheenBox, 'glass'), 10);
      } else {
        this.renderer.addClass(sheenBox, 'glass');
      }
    }
  }

  preloadImage(url: string): Promise<HTMLImageElement> {
    return new Promise((resolve, reject) => {
      const img = new Image();
      img.onload = () => resolve(img);
      img.onerror = reject;
      img.src = url;
    });
  }

  isQuestSelected(quest: Quest): boolean {
    return false;
  }

  calculateTotalSkillPoints(): number {
    return this.quests
      .filter(quest => quest.selected)
      .reduce((acc, quest) => acc + quest.skillPoints, 0);
  }

  toggleQuest(quest: Quest): void {
    quest.selected = !quest.selected;
    this.calculateTotalSkillPoints();
    this.updateSkillPoints();
  }

  toggleAllQuests(event: Event): void {
    const target = event.target as HTMLInputElement;
    const selected = target.checked;
    this.quests.forEach(quest => {
      quest.selected = selected;
    });
    this.updateSkillPoints();
  }

  areAllQuestsSelected(): boolean {
    return this.quests.every(quest => quest.selected);
  }

  updateSkillPoints() {
    this.totalAvailableSP = this.currentStats.skillPoints + this.calculateTotalSkillPoints();
  }
}
