import { PlayerClassService } from './../../services/player-class.service';
import { AuthService } from './../../services/auth.service';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { PlayerClass } from 'src/app/models/player-class';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit, OnDestroy {

  // properties
  playerClasses: PlayerClass[] = [];
  currentStats: any;

  // booleans
  classSelected: boolean = false;
  currentClassData: any = null;
  selectedClassIndex: number | null = null;

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
      this.selectedClassIndex = classIndex;
      this.currentClassData = this.playerClasses[classIndex];
      // Reset currentStats to the initial state for the newly selected class
      this.currentStats = { ...this.currentClassData.classStats[0] };
      console.log(this.currentClassData);
      this.typeOutText(this.currentClassData.description, 'description-text');
    }
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

  updateLevel(newLevel: number): void {
    const validLevel = Math.max(1, Math.min(newLevel, 2)); // Ensure level is within bounds
    const stats = this.currentClassData.classStats.find((stat: { level: number; }) => stat.level === validLevel);
    if (stats) {
      this.currentStats = { ...stats };
    } else {
      console.error('Stats for level', validLevel, 'not found');
    }
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

}
