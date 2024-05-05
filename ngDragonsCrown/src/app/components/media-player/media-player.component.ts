import { Component, ElementRef, Input, ViewChild } from '@angular/core';

@Component({
  selector: 'app-media-player',
  templateUrl: './media-player.component.html',
  styleUrls: ['./media-player.component.css']
})
export class MediaPlayerComponent {
  @Input() skillName: string = '';
  videoPath: string = '';
  isLoading: boolean = false;
  skills: Map<string, string> = new Map([
    ['Slide Attack', 'assets/graphics/media/common-skills-slide-attack-sm.mp4'],
    ['Wealth to Health', 'assets/graphics/media/common-skills-wealth-to-health-sm.mp4'],
    ['Money is Power', 'assets/graphics/media/common-skills-money-is-power-sm.mp4'],
    ['Vitality Boost', 'assets/graphics/media/common-skills-vitality-boost-sm.mp4'],
    ['Nutritionist', 'assets/graphics/media/common-skills-nutritionist-sm.mp4'],
    ['Maintenance', 'assets/graphics/media/common-skills-maintenance-sm.mp4'],
    ['Adroit Hands', 'assets/graphics/media/common-skills-adroit-hands-sm.mp4'],
    ['Evasion', 'assets/graphics/media/common-skills-evasion-sm.mp4'],
    ['Deep Pockets', 'assets/graphics/media/common-skills-deep-pockets-sm.mp4'],
  ]);

  @ViewChild('videoPlayer') videoPlayer!: ElementRef<HTMLVideoElement>;

  constructor() { }

  ngOnInit(): void {
    this.videoPath = this.getVideoPath();
  }

  ngAfterViewInit(): void {
    // Add 'loadstart' event listener to track when the video starts loading
    this.videoPlayer.nativeElement.addEventListener('loadstart', this.videoLoading.bind(this));
    // Add 'canplaythrough' event listener for when the video is ready to play
    this.videoPlayer.nativeElement.addEventListener('canplaythrough', this.videoReady.bind(this));
  }

  getVideoPath(): string {
    return this.skills.get(this.skillName) || '';
  }

  videoLoading(): void {
    this.isLoading = true;
  }

  videoReady(): void {
    console.log('Video is ready to play!');
    this.isLoading = false;
    this.videoPlayer.nativeElement.play();
  }

}
