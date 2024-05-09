import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-sample-voice',
  templateUrl: './sample-voice.component.html',
  styleUrls: ['./sample-voice.component.css']
})
export class SampleVoiceComponent implements OnInit {

  private currentAudio: HTMLAudioElement | null = null;
  private currentId: number | null = null;
  activeId: number | null = null;
  isLoading: { [id: number]: boolean } = {};  // Track loading state for each ID
  jpAudios: any;
  enAudios: any;

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

  ngOnInit() {
    this.jpAudios = this.audios.filter(item => item.lang === 'jp');
    this.enAudios = this.audios.filter(item => item.lang === 'en');
  }

  playAudio(id: number, audioUrl: string): void {
    if (this.currentId === id) {
      if (this.currentAudio) {
        this.currentAudio.pause();
      }
      this.resetAudio(id);
      return;
    }

    if (this.currentAudio && this.currentId !== null) {
      this.currentAudio.pause();
      this.resetAudio(this.currentId);
    }

    this.isLoading[id] = true;
    this.fetchAndPlayAudio(id, audioUrl);
  }

  private fetchAndPlayAudio(id: number, audioUrl: string): void {
    const audio = new Audio(audioUrl);
    audio.addEventListener('canplaythrough', () => {
      if (this.isLoading[id]) {
        this.isLoading[id] = false;
        this.currentAudio = audio;
        this.currentAudio.play();
        this.currentId = id;
        this.activeId = id;

        this.currentAudio.addEventListener('ended', () => this.resetAudio(id));
      } else {
        audio.pause();
      }
    });

    audio.load();
  }

  private resetAudio(id: number): void {
    if (this.currentId === id) {
      if (this.currentAudio) {
        this.currentAudio.pause();
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

  stopAudio(): void {
    if (this.currentAudio) {
      this.currentAudio.pause();
      this.currentAudio = null;
      this.currentId = null;
      this.activeId = null;
    }
  }
}
