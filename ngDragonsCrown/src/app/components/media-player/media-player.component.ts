import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-media-player',
  templateUrl: './media-player.component.html',
  styleUrls: ['./media-player.component.css']
})
export class MediaPlayerComponent {
  @Input() skillName: string = '';
  videoPath: string = '';
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

  constructor() { }

  ngOnInit(): void {
    this.videoPath = this.getVideoPath();
  }

  getVideoPath(): string {
    return this.skills.get(this.skillName) || '';
  }

}
