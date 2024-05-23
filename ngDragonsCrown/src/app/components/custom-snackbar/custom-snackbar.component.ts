import { Component, Inject, inject } from '@angular/core';
import { MatSnackBarRef, MAT_SNACK_BAR_DATA } from '@angular/material/snack-bar';
import { AudioEntity } from 'src/app/models/audio-entity';
import { SoundManagerService } from 'src/app/services/sound-manager.service';

@Component({
  selector: 'app-custom-snackbar',
  templateUrl: './custom-snackbar.component.html',
  styleUrls: ['./custom-snackbar.component.css']
})
export class CustomSnackbarComponent {

  currentAudio: HTMLAudioElement | null = null;

  soundManager = inject(SoundManagerService);

  sounds: AudioEntity[] = [
    { name: 'erase', path: 'assets/audio/dc_erase_se.mp3' },
  ];

  constructor(
    public snackBarRef: MatSnackBarRef<CustomSnackbarComponent>,
    @Inject(MAT_SNACK_BAR_DATA) public data: any
  ) {}

  dismiss() {
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('erase');
    }
    this.snackBarRef.dismiss();
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
