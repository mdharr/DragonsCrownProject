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
    ['Bash', 'assets/graphics/media/fighter-skills-bash-sm.mp4'],
    ['Cover Allies', 'assets/graphics/media/fighter-skills-cover-allies-sm.mp4'],
    ['Cyclone Masher', 'assets/graphics/media/fighter-skills-cyclone-masher-sm.mp4'],
    ['Distraction', 'assets/graphics/media/fighter-skills-distraction-sm.mp4'],
    ['Judgement', 'assets/graphics/media/fighter-skills-judgement-sm.mp4'],
    ['Reflect Missile', 'assets/graphics/media/fighter-skills-reflect-missile-sm.mp4'],
    ['Rebuke', 'assets/graphics/media/fighter-skills-rebuke-sm.mp4'],
    ['Reflex Guard', 'assets/graphics/media/fighter-skills-reflex-guard-sm.mp4'],
    ['Sacrifice', 'assets/graphics/media/fighter-skills-sacrifice-sm.mp4'],
    ['Shield Tactics', 'assets/graphics/media/fighter-skills-shield-tactics-sm.mp4'],
    ['Shockwave', 'assets/graphics/media/fighter-skills-shockwave-sm.mp4'],
    ['Tempest Edge', 'assets/graphics/media/fighter-skills-tempest-edge-sm.mp4'],
    ['Adrenaline', 'assets/graphics/media/amazon-skills-adrenaline-sm.mp4'],
    ['Berserk', 'assets/graphics/media/amazon-skills-berserk-sm.mp4'],
    ['Brandish', 'assets/graphics/media/amazon-skills-brandish-sm.mp4'],
    ['Brutal Drive', 'assets/graphics/media/amazon-skills-brutal-drive-sm.mp4'],
    ['Deadly Revolution', 'assets/graphics/media/amazon-skills-deadly-revolution-sm.mp4'],
    ['Incite Rage', 'assets/graphics/media/amazon-skills-incite-rage-sm.mp4'],
    ['Iron Will', 'assets/graphics/media/amazon-skills-iron-will-sm.mp4'],
    ['Neck Splitter', 'assets/graphics/media/amazon-skills-neck-splitter-sm.mp4'],
    ['Parry', 'assets/graphics/media/amazon-skills-parry-sm.mp4'],
    ['Punisher', 'assets/graphics/media/amazon-skills-punisher-sm.mp4'],
    ['Stun Wave', 'assets/graphics/media/amazon-skills-stun-wave-sm.mp4'],
    ['War Paint', 'assets/graphics/media/amazon-skills-war-paint-sm.mp4'],
    ['Blaze', 'assets/graphics/media/wizard-skills-blaze-sm.mp4'],
    ['Concentrate', 'assets/graphics/media/wizard-skills-concentrate-sm.mp4'],
    ['Create Golem', 'assets/graphics/media/wizard-skills-create-golem-sm.mp4'],
    ['Extinction', 'assets/graphics/media/wizard-skills-extinction-sm.mp4'],
    ['Extract', 'assets/graphics/media/wizard-skills-extract-sm.mp4'],
    ['Fire Ward', 'assets/graphics/media/wizard-skills-fire-ward-sm.mp4'],
    ['Flame Burst', 'assets/graphics/media/wizard-skills-flame-burst-sm.mp4'],
    ['Levitation', 'assets/graphics/media/wizard-skills-levitation-sm.mp4'],
    ['Mental Absorb', 'assets/graphics/media/wizard-skills-mental-absorb-sm.mp4'],
    ['Meteor Swarm', 'assets/graphics/media/wizard-skills-meteor-swarm-sm.mp4'],
    ['Slow', 'assets/graphics/media/wizard-skills-slow-sm.mp4'],
    ['Spirit Up', 'assets/graphics/media/wizard-skills-spirit-up-sm.mp4'],
    ['Storm', 'assets/graphics/media/wizard-skills-storm-sm.mp4'],
    ['Thunderbolt', 'assets/graphics/media/wizard-skills-thunderbolt-sm.mp4'],
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
