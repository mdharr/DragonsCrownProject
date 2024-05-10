import { Component, inject } from '@angular/core';
import { SoundManagerService } from 'src/app/services/sound-manager.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent {

  soundManager= inject(SoundManagerService);

  toggleSounds() {
    this.soundManager.toggleSound();
  }

  soundEnabled() {
    return this.soundManager.isSoundEnabled();
  }
}
