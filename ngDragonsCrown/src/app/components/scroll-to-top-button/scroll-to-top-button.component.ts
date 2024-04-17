import { Component, HostListener, ViewChild, ElementRef } from '@angular/core';

@Component({
  selector: 'app-scroll-to-top-button',
  templateUrl: './scroll-to-top-button.component.html',
  styleUrls: ['./scroll-to-top-button.component.css']
})
export class ScrollToTopButtonComponent {
  @ViewChild('fairyElement', { static: true }) fairyElement!: ElementRef<HTMLImageElement>;

  @HostListener('window:scroll', [])
  onWindowScroll() {
    this.toggleButtonVisibility();
  }

  scrollToTop() {
    setTimeout(() => {
      window.scrollTo({ top: 0, behavior: 'auto' });
      this.playCoinflipAudio();
    }, 100);
  }

  toggleButtonVisibility() {
    const button = document.querySelector('.scroll-to-top-button') as HTMLElement;
    if (button) {
      button.style.display = window.scrollY > 300 ? 'flex' : 'none';
      button.style.alignItems = window.scrollY > 300 ? 'center' : 'none';
    }
  }

  playCoinflipAudio() {
    // const audioPath = '/assets/audio/dc_coinflip_se.mp3';
    const audioPath = 'assets/audio/dc_coinflip_se.mp3';
    const audio = new Audio(audioPath);
    audio.play();
  }

}
