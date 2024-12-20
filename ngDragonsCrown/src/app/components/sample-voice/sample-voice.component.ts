import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { AudioEntity } from 'src/app/models/audio-entity';
import { SoundManagerService } from 'src/app/services/sound-manager.service';

@Component({
  selector: 'app-sample-voice',
  templateUrl: './sample-voice.component.html',
  styleUrls: ['./sample-voice.component.css']
})
export class SampleVoiceComponent implements OnInit, OnDestroy {

  private currentAudio: HTMLAudioElement | null = null;
  private currentId: number | null = null;
  activeId: number | null = null;
  isLoading: { [id: number]: boolean } = {};  // Track loading state for each ID
  jpAudios: any;
  enAudios: any;
  toggleLanguage: boolean = false;
  showJapanese: boolean = false;
  showEnglish: boolean = true;
  loading: boolean = true;

  sounds: AudioEntity[] = [{ name: 'confirm', path: 'assets/audio/dc_confirm_se.mp3' },];
  currentSound: HTMLAudioElement | null = null;

  audios = [
    { id: 20000, url: 'https://dragons-crown.com/resources/audio/20000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/ja_voice1.png', lang: "jp" },
    { id: 30000, url: 'https://dragons-crown.com/resources/audio/30000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/ja_voice2.png', lang: "jp" },
    { id: 40000, url: 'https://dragons-crown.com/resources/audio/40000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/ja_voice3.png', lang: "jp" },
    { id: 50000, url: 'https://dragons-crown.com/resources/audio/50000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/ja_voice4.png', lang: "jp" },
    { id: 60000, url: 'https://dragons-crown.com/resources/audio/60000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/ja_voice5.png', lang: "jp" },
    { id: 70000, url: 'https://dragons-crown.com/resources/audio/70000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/ja_voice6.png', lang: "jp" },
    { id: 80000, url: 'https://dragons-crown.com/resources/audio/80000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/ja_voice7.png', lang: "jp" },
    { id: 120000, url: 'https://dragons-crown.com/resources/audio/120000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/en_voice1.png', lang: "en" },
    { id: 130000, url: 'https://dragons-crown.com/resources/audio/130000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/en_voice2.png', lang: "en" },
    { id: 140000, url: 'https://dragons-crown.com/resources/audio/140000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/en_voice3.png', lang: "en" },
    { id: 150000, url: 'https://dragons-crown.com/resources/audio/150000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/en_voice4.png', lang: "en" },
    { id: 160000, url: 'https://dragons-crown.com/resources/audio/160000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/en_voice5.png', lang: "en" },
    { id: 170000, url: 'https://dragons-crown.com/resources/audio/170000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/en_voice6.png', lang: "en" },
    { id: 180000, url: 'https://dragons-crown.com/resources/audio/180000.wav', imgSrc: 'https://dragons-crown.com/resources/img/sp/howtoplay/facility/en_voice7.png', lang: "en" }
  ];

  private audioCache: { [key: string]: HTMLAudioElement } = {};

  soundManager= inject(SoundManagerService);

  ngOnInit() {
    this.jpAudios = this.audios.filter(item => item.lang === 'jp');
    this.enAudios = this.audios.filter(item => item.lang === 'en');
    this.loadImages(this.enAudios);
  }

  // ngOnDestroy() {
  //   this.stopAudio();
  // }

  loadImages(audios: any[]): void {
    this.loading = true;
    const imagesToLoad = [...audios];
    let loadedImages = 0;

    imagesToLoad.forEach(audio => {
      const img = new Image();
      img.src = audio.imgSrc;
      img.onload = () => {
        loadedImages++;
        if (loadedImages === imagesToLoad.length) {
          this.loading = false;
        }
      };
      img.onerror = () => {
        loadedImages++;
        if (loadedImages === imagesToLoad.length) {
          this.loading = false;
        }
      };
    });
  }

  // playAudio(id: number, audioUrl: string): void {
  //   if (this.soundManager.isSoundEnabled()) {

  //     this.playSound('confirm', 0.5);
  //   }
  //   if (this.currentId === id) {
  //     if (this.currentAudio) {
  //       this.currentAudio.pause();
  //     }
  //     this.resetAudio(id);
  //     return;
  //   }

  //   if (this.currentAudio && this.currentId !== null) {
  //     this.currentAudio.pause();
  //     this.resetAudio(this.currentId);
  //   }

  //   this.isLoading[id] = true;
  //   this.fetchAndPlayAudio(id, audioUrl);
  // }

  // private fetchAndPlayAudio(id: number, audioUrl: string): void {
  //   const audio = new Audio(audioUrl);
  //   audio.addEventListener('canplaythrough', () => {
  //     if (this.isLoading[id]) {
  //       this.isLoading[id] = false;
  //       this.currentAudio = audio;
  //       this.currentAudio.play();
  //       this.currentId = id;
  //       this.activeId = id;

  //       this.currentAudio.addEventListener('ended', () => this.resetAudio(id));
  //     } else {
  //       audio.pause();
  //     }
  //   });

  //   audio.load();
  // }

  private resetAudio(id: number): void {
    if (this.currentId === id) {
      if (this.currentAudio) {
        this.currentAudio.pause();
        this.currentAudio.currentTime = 0;
        this.currentAudio = null;
      }
      this.currentId = null;
      this.activeId = null;
      this.isLoading[id] = false;
    }
  }

  anyLoading(): boolean {
    return Object.values(this.isLoading).some(status => status);
  }

  // stopAudio(): void {
  //   if (this.currentAudio) {
  //     this.currentAudio.pause();
  //     this.currentAudio = null;
  //     this.currentId = null;
  //     this.activeId = null;
  //   }
  // }

  // stopAudio(): void {
  //   if (this.currentAudio) {
  //     this.currentAudio.pause();
  //     this.currentAudio.currentTime = 0; // Reset the audio to the beginning
  //     this.currentAudio.src = ''; // Clear the source
  //     this.currentAudio.load(); // Reload the audio element
  //     this.currentAudio = null;
  //     this.currentId = null;
  //     this.activeId = null;
  //   }
  // }

  toggleEnglish() {
    if (this.showJapanese) {
      this.loadImages(this.enAudios);
      this.stopAudio();
      this.showJapanese = !this.showJapanese;
      this.showEnglish = !this.showEnglish;
      if (this.soundManager.isSoundEnabled()) {

        this.playSound('confirm', 0.5);
      }
    }
  }

  toggleJapanese() {
    if (this.showEnglish) {
      this.loadImages(this.enAudios);
      this.stopAudio();
      this.showEnglish = !this.showEnglish;
      this.showJapanese = !this.showJapanese;
      if (this.soundManager.isSoundEnabled()) {

        this.playSound('confirm', 0.5);
      }
    }
  }

  // async playSound(soundName: string, volume: number = 1.0): Promise<HTMLAudioElement> {
  //   const audioObj = this.sounds.find(sound => sound.name === soundName);
  //   const audioPath = audioObj?.path;
  //   if (audioPath) {
  //     const audio = new Audio(audioPath);
  //     audio.volume = volume;

  //     return new Promise((resolve, reject) => {
  //       audio.play().then(() => {
  //         this.currentAudio = audio;
  //         resolve(audio);
  //       }).catch((error) => {
  //         console.error('Error playing audio:', error);
  //         reject(error);
  //       });
  //     });
  //   } else {
  //     return Promise.reject(new Error('Audio path not found'));
  //   }
  // }

  async playSound(soundName: string, volume: number = 1.0): Promise<HTMLAudioElement> {
    const audioObj = this.sounds.find(sound => sound.name === soundName);
    const audioPath = audioObj?.path;
    if (audioPath) {
      if (this.currentSound) {
        this.currentSound.pause();
        this.currentSound.currentTime = 0;
      }

      let audio: HTMLAudioElement;
      if (this.audioCache[audioPath]) {
        audio = this.audioCache[audioPath];
      } else {
        audio = new Audio(audioPath);
        this.audioCache[audioPath] = audio;
      }

      audio.volume = volume;

      return new Promise((resolve, reject) => {
        const playPromise = audio.play();
        if (playPromise !== undefined) {
          playPromise.then(() => {
            this.currentSound = audio;
            resolve(audio);
          }).catch((error) => {
            console.error('Error playing audio:', error);
            reject(error);
          });
        } else {
          this.currentSound = audio;
          resolve(audio);
        }
      });
    } else {
      return Promise.reject(new Error('Audio path not found'));
    }
  }

  stopAudio(): void {
    if (this.currentAudio) {
      this.currentAudio.pause();
      this.currentAudio.currentTime = 0;
    }
    if (this.currentSound) {
      this.currentSound.pause();
      this.currentSound.currentTime = 0;
    }
    this.currentAudio = null;
    this.currentSound = null;
    this.currentId = null;
    this.activeId = null;
  }

  playAudio(id: number, audioUrl: string): void {
    if (this.soundManager.isSoundEnabled()) {
      this.playSound('confirm', 0.5);
    }

    if (this.currentId === id && this.currentAudio) {
      this.stopAudio();
      return;
    }

    this.stopAudio();

    this.isLoading[id] = true;
    this.fetchAndPlayAudio(id, audioUrl);
  }

  private fetchAndPlayAudio(id: number, audioUrl: string): void {
    let audio: HTMLAudioElement;
    if (this.audioCache[audioUrl]) {
      audio = this.audioCache[audioUrl];
    } else {
      audio = new Audio(audioUrl);
      this.audioCache[audioUrl] = audio;
    }

    const playAudioWhenReady = () => {
      if (this.isLoading[id]) {
        this.isLoading[id] = false;
        this.currentAudio = audio;
        audio.currentTime = 0;  // Reset the audio to the beginning
        const playPromise = audio.play();
        if (playPromise !== undefined) {
          playPromise.catch(error => {
            console.error('Error playing audio:', error);
            this.resetAudio(id);
          });
        }
        this.currentId = id;
        this.activeId = id;

        audio.onended = () => this.resetAudio(id);
      }
    };

    if (audio.readyState >= 3) {  // HAVE_FUTURE_DATA or HAVE_ENOUGH_DATA
      playAudioWhenReady();
    } else {
      audio.oncanplay = playAudioWhenReady;
      audio.load();
    }
  }

  // ... (keep other methods unchanged)

  ngOnDestroy() {
    this.stopAudio();
    // Clear the audio cache
    for (const key in this.audioCache) {
      this.audioCache[key].pause();
      this.audioCache[key].src = '';
      this.audioCache[key].load();
    }
    this.audioCache = {};
  }
}
