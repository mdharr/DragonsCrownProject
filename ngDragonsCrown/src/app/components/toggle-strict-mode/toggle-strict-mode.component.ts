import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { AudioEntity } from 'src/app/models/audio-entity';
import { SnackbarService } from 'src/app/services/snackbar.service';
import { SoundManagerService } from 'src/app/services/sound-manager.service';
import { StrictModeService } from 'src/app/services/strict-mode.service';

@Component({
  selector: 'app-toggle-strict-mode',
  templateUrl: './toggle-strict-mode.component.html',
  styleUrls: ['./toggle-strict-mode.component.css']
})
export class ToggleStrictModeComponent {

  currentAudio: HTMLAudioElement | null = null;

  sounds: AudioEntity[] = [
    { name: 'confirm', path: 'assets/audio/dc_confirm_se.mp3' },
  ];

  constructor(
    private dialogRef: MatDialogRef<ToggleStrictModeComponent>,
    @Inject(MAT_DIALOG_DATA) private data: any,
    private strictModeService: StrictModeService,
    private snackbarService: SnackbarService,
    private soundManager: SoundManagerService
  ) {}

  toggleStrictMode() {
    this.strictModeService.toggleStrictMode();
    this.closeDialog();
  }

  async closeDialog() {
    if (this.soundManager.isSoundEnabled()) {

      await this.playSound('confirm', 1);
    }
    this.dialogRef.close();
  }

  openSnackbar(message: string, action: string) {
    this.snackbarService.openSnackbar(message, action);
  }

  isStrictModeActive() {
    return this.strictModeService.isStrictModeEnabled();
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
