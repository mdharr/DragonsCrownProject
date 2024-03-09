import { Component, HostListener, OnInit, AfterViewInit, ViewChild, ElementRef } from '@angular/core';

@Component({
  selector: 'app-scroll-to-top-button',
  templateUrl: './scroll-to-top-button.component.html',
  styleUrls: ['./scroll-to-top-button.component.css']
})
export class ScrollToTopButtonComponent implements AfterViewInit {
  @ViewChild('fairyElement', { static: true }) fairyElement!: ElementRef<HTMLImageElement>;

  @HostListener('window:scroll', [])
  onWindowScroll() {
    this.toggleButtonVisibility();
  }

  ngAfterViewInit(): void {
    // this.animateFairy();
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
    const audioPath = '/assets/audio/dc_coinflip_se.mp3';
    const audio = new Audio(audioPath);
    audio.play();
  }

  // animateFairy(): void {
  //   let targetX = Math.floor(Math.random() * 41) - 20;
  //   let targetY = Math.floor(Math.random() * 41) - 20;
  //   let currentX = 0;
  //   let currentY = 0;

  //   const updateTargetPosition = () => {
  //     const nextTargetX = Math.floor(Math.random() * 41) - 20;
  //     const nextTargetY = Math.floor(Math.random() * 41) - 20;

  //     targetX += (nextTargetX - targetX);
  //     targetY += (nextTargetY - targetY);
  //   };

  //   const moveTowardsTarget = () => {
  //     const diffX = targetX - currentX;
  //     const diffY = targetY - currentY;

  //     currentX += diffX * 0.05;
  //     currentY += diffY * 0.05;

  //     this.fairyElement.nativeElement.style.transform = `translate(${currentX}px, ${currentY}px)`;

  //     requestAnimationFrame(moveTowardsTarget);
  //   };

  //   setInterval(updateTargetPosition, 2000);

  //   moveTowardsTarget();
  // }
}
