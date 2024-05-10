import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class SoundManagerService {

  private soundEnabled: boolean = true;

  constructor() {
    const savedState = localStorage.getItem('soundEnabled');
    this.soundEnabled = savedState !== null ? savedState === 'true' : true;
  }

  toggleSound(): void {
    this.soundEnabled = !this.soundEnabled;
    localStorage.setItem('soundEnabled', this.soundEnabled.toString());
  }

  isSoundEnabled(): boolean {
    return this.soundEnabled;
  }
}
