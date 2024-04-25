import { Directive, ElementRef, HostListener, Renderer2 } from '@angular/core';

@Directive({
  selector: '[appParallax]'
})
export class ParallaxDirective {
  constructor(private el: ElementRef, private renderer: Renderer2) {}

  @HostListener('window:scroll', ['$event'])
  onWindowScroll() {
    const parallaxFactor = 0.015;
    const offset = window.pageYOffset * parallaxFactor;
    this.renderer.setStyle(
      this.el.nativeElement,
      'backgroundPositionY',
      `calc(50% + ${offset}px)`
    );
  }

}
