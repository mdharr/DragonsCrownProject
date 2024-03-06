import { Component, AfterViewInit } from '@angular/core';

declare var particlesJS: any;

@Component({
  selector: 'app-particles',
  templateUrl: './particles.component.html',
  styleUrls: ['./particles.component.css']
})
export class ParticlesComponent implements AfterViewInit {

  ngAfterViewInit() {
    particlesJS.load('particles-js', 'assets/particles.json', function() {
      console.log('callback - particles.js config loaded');
    });
  }

}
