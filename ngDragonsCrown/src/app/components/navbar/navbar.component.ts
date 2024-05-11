import { Component, inject } from '@angular/core';
import { AudioEntity } from 'src/app/models/audio-entity';
import { SoundManagerService } from 'src/app/services/sound-manager.service';
import { ToastService } from 'src/app/services/toast.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent {

  sounds: AudioEntity[] = [{ name: 'confirm', path: 'assets/audio/dc_confirm_se.mp3' },];
  currentAudio: HTMLAudioElement | null = null;

  soundManager = inject(SoundManagerService);
  toastService = inject(ToastService);

  toggleSounds() {
    if (!this.soundManager.isSoundEnabled()) {

      this.playSound('confirm', 0.5);
    }
    this.toastService.show(this.soundEnabled() ? 'Sound Enabled' : 'Sound Disabled'); console.log('Toasty!');
    this.soundManager.toggleSound();
  }

  soundEnabled() {
    return this.soundManager.isSoundEnabled();
  }

  async playSound(soundName: string, volume: number = 1.0): Promise<HTMLAudioElement> {
    const audioObj = this.sounds.find(sound => sound.name === soundName);
    const audioPath = audioObj?.path;
    if (audioPath) {
      const audio = new Audio(audioPath);
      audio.volume = volume;

      return new Promise((resolve, reject) => {
        audio.play().then(() => {
          this.currentAudio = audio;
          resolve(audio);
        }).catch((error) => {
          console.error('Error playing audio:', error);
          reject(error);
        });
      });
    } else {
      return Promise.reject(new Error('Audio path not found'));
    }
  }
}
