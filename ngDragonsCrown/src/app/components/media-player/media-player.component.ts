import { Component, ElementRef, Input, ViewChild } from '@angular/core';

@Component({
  selector: 'app-media-player',
  templateUrl: './media-player.component.html',
  styleUrls: ['./media-player.component.css']
})
export class MediaPlayerComponent {
  @Input() skillName: string = '';
  @Input() className: string = '';
  videoPath: string = '';
  isLoading: boolean = false;
  // skills: Map<string, string> = new Map([
  //   ['Slide Attack', 'assets/graphics/media/common-skills-slide-attack-sm.mp4'],
  //   ['Wealth to Health', 'assets/graphics/media/common-skills-wealth-to-health-sm.mp4'],
  //   ['Money is Power', 'assets/graphics/media/common-skills-money-is-power-sm.mp4'],
  //   ['Vitality Boost', 'assets/graphics/media/common-skills-vitality-boost-sm.mp4'],
  //   ['Nutritionist', 'assets/graphics/media/common-skills-nutritionist-sm.mp4'],
  //   ['Maintenance', 'assets/graphics/media/common-skills-maintenance-sm.mp4'],
  //   ['Adroit Hands', 'assets/graphics/media/common-skills-adroit-hands-sm.mp4'],
  //   ['Evasion', 'assets/graphics/media/common-skills-evasion-sm.mp4'],
  //   ['Deep Pockets', 'assets/graphics/media/common-skills-deep-pockets-sm.mp4'],
  //   ['Bash', 'assets/graphics/media/fighter-skills-bash-sm.mp4'],
  //   ['Cover Allies', 'assets/graphics/media/fighter-skills-cover-allies-sm.mp4'],
  //   ['Cyclone Masher', 'assets/graphics/media/fighter-skills-cyclone-masher-sm.mp4'],
  //   ['Distraction', 'assets/graphics/media/fighter-skills-distraction-sm.mp4'],
  //   ['Judgement', 'assets/graphics/media/fighter-skills-judgement-sm.mp4'],
  //   ['Reflect Missile', 'assets/graphics/media/fighter-skills-reflect-missile-sm.mp4'],
  //   ['Rebuke', 'assets/graphics/media/fighter-skills-rebuke-sm.mp4'],
  //   ['Reflex Guard', 'assets/graphics/media/fighter-skills-reflex-guard-sm.mp4'],
  //   ['Sacrifice', 'assets/graphics/media/fighter-skills-sacrifice-sm.mp4'],
  //   ['Shield Tactics', 'assets/graphics/media/fighter-skills-shield-tactics-sm.mp4'],
  //   ['Shockwave', 'assets/graphics/media/fighter-skills-shockwave-sm.mp4'],
  //   ['Tempest Edge', 'assets/graphics/media/fighter-skills-tempest-edge-sm.mp4'],
  //   ['Adrenaline', 'assets/graphics/media/amazon-skills-adrenaline-sm.mp4'],
  //   ['Berserk', 'assets/graphics/media/amazon-skills-berserk-sm.mp4'],
  //   ['Brandish', 'assets/graphics/media/amazon-skills-brandish-sm.mp4'],
  //   ['Brutal Drive', 'assets/graphics/media/amazon-skills-brutal-drive-sm.mp4'],
  //   ['Deadly Revolution', 'assets/graphics/media/amazon-skills-deadly-revolution-sm.mp4'],
  //   ['Incite Rage', 'assets/graphics/media/amazon-skills-incite-rage-sm.mp4'],
  //   ['Iron Will', 'assets/graphics/media/amazon-skills-iron-will-sm.mp4'],
  //   ['Neck Splitter', 'assets/graphics/media/amazon-skills-neck-splitter-sm.mp4'],
  //   ['Parry', 'assets/graphics/media/amazon-skills-parry-sm.mp4'],
  //   ['Punisher', 'assets/graphics/media/amazon-skills-punisher-sm.mp4'],
  //   ['Stun Wave', 'assets/graphics/media/amazon-skills-stun-wave-sm.mp4'],
  //   ['War Paint', 'assets/graphics/media/amazon-skills-war-paint-sm.mp4'],
  //   ['Blaze', 'assets/graphics/media/wizard-skills-blaze-sm.mp4'],
  //   ['Concentrate', 'assets/graphics/media/wizard-skills-concentrate-sm.mp4'],
  //   ['Create Golem', 'assets/graphics/media/wizard-skills-create-golem-sm.mp4'],
  //   ['Extinction', 'assets/graphics/media/wizard-skills-extinction-sm.mp4'],
  //   ['Extract', 'assets/graphics/media/wizard-skills-extract-sm.mp4'],
  //   ['Fire Ward', 'assets/graphics/media/wizard-skills-fire-ward-sm.mp4'],
  //   ['Flame Burst', 'assets/graphics/media/wizard-skills-flame-burst-sm.mp4'],
  //   ['Levitation', 'assets/graphics/media/wizard-skills-levitation-sm.mp4'],
  //   ['Mental Absorb', 'assets/graphics/media/wizard-skills-mental-absorb-sm.mp4'],
  //   ['Meteor Swarm', 'assets/graphics/media/wizard-skills-meteor-swarm-sm.mp4'],
  //   ['Slow', 'assets/graphics/media/wizard-skills-slow-sm.mp4'],
  //   ['Spirit Up', 'assets/graphics/media/wizard-skills-spirit-up-sm.mp4'],
  //   ['Storm', 'assets/graphics/media/wizard-skills-storm-sm.mp4'],
  //   ['Thunderbolt', 'assets/graphics/media/wizard-skills-thunderbolt-sm.mp4'],
  // ]);

  skills: Map<string, Map<string, string>> = new Map([
    ['Slide Attack', new Map([
      ['fighter', 'assets/graphics/media/common-skills-slide-attack-sm.mp4'],
      ['amazon', 'assets/graphics/media/common-skills-slide-attack-sm.mp4'],
      ['elf', 'assets/graphics/media/common-skills-slide-attack-sm.mp4'],
      ['dwarf', 'assets/graphics/media/common-skills-slide-attack-sm.mp4'],
      ['sorceress', 'assets/graphics/media/common-skills-slide-attack-sm.mp4'],
      ['wizard', 'assets/graphics/media/common-skills-slide-attack-sm.mp4'],
    ])],
    ['Wealth to Health', new Map([
      ['fighter', 'assets/graphics/media/common-skills-wealth-to-health-sm.mp4'],
      ['amazon', 'assets/graphics/media/common-skills-wealth-to-health-sm.mp4'],
      ['elf', 'assets/graphics/media/common-skills-wealth-to-health-sm.mp4'],
      ['dwarf', 'assets/graphics/media/common-skills-wealth-to-health-sm.mp4'],
      ['sorceress', 'assets/graphics/media/common-skills-wealth-to-health-sm.mp4'],
      ['wizard', 'assets/graphics/media/common-skills-wealth-to-health-sm.mp4'],
    ])],
    ['Money is Power', new Map([
      ['fighter', 'assets/graphics/media/common-skills-money-is-power-sm.mp4'],
      ['amazon', 'assets/graphics/media/common-skills-money-is-power-sm.mp4'],
      ['elf', 'assets/graphics/media/common-skills-money-is-power-sm.mp4'],
      ['dwarf', 'assets/graphics/media/common-skills-money-is-power-sm.mp4'],
      ['sorceress', 'assets/graphics/media/common-skills-money-is-power-sm.mp4'],
      ['wizard', 'assets/graphics/media/common-skills-money-is-power-sm.mp4'],
    ])],
    ['Vitality Boost', new Map([
      ['fighter', 'assets/graphics/media/common-skills-vitality-boost-sm.mp4'],
      ['amazon', 'assets/graphics/media/common-skills-vitality-boost-sm.mp4'],
      ['elf', 'assets/graphics/media/common-skills-vitality-boost-sm.mp4'],
      ['dwarf', 'assets/graphics/media/common-skills-vitality-boost-sm.mp4'],
      ['sorceress', 'assets/graphics/media/common-skills-vitality-boost-sm.mp4'],
      ['wizard', 'assets/graphics/media/common-skills-vitality-boost-sm.mp4'],
    ])],
    ['Nutritionist', new Map([
      ['fighter', 'assets/graphics/media/common-skills-nutritionist-sm.mp4'],
      ['amazon', 'assets/graphics/media/common-skills-nutritionist-sm.mp4'],
      ['elf', 'assets/graphics/media/common-skills-nutritionist-sm.mp4'],
      ['dwarf', 'assets/graphics/media/common-skills-nutritionist-sm.mp4'],
      ['sorceress', 'assets/graphics/media/common-skills-nutritionist-sm.mp4'],
      ['wizard', 'assets/graphics/media/common-skills-nutritionist-sm.mp4'],
    ])],
    ['Maintenance', new Map([
      ['fighter', 'assets/graphics/media/common-skills-maintenance-sm.mp4'],
      ['amazon', 'assets/graphics/media/common-skills-maintenance-sm.mp4'],
      ['elf', 'assets/graphics/media/common-skills-maintenance-sm.mp4'],
      ['dwarf', 'assets/graphics/media/common-skills-maintenance-sm.mp4'],
      ['sorceress', 'assets/graphics/media/common-skills-maintenance-sm.mp4'],
      ['wizard', 'assets/graphics/media/common-skills-maintenance-sm.mp4'],
    ])],
    ['Adroit Hands', new Map([
      ['fighter', 'assets/graphics/media/common-skills-adroit-hands-sm.mp4'],
      ['amazon', 'assets/graphics/media/common-skills-adroit-hands-sm.mp4'],
      ['elf', 'assets/graphics/media/common-skills-adroit-hands-sm.mp4'],
      ['dwarf', 'assets/graphics/media/common-skills-adroit-hands-sm.mp4'],
      ['sorceress', 'assets/graphics/media/common-skills-adroit-hands-sm.mp4'],
      ['wizard', 'assets/graphics/media/common-skills-adroit-hands-sm.mp4'],
    ])],
    ['Evasion', new Map([
      ['fighter', 'assets/graphics/media/common-skills-evasion-sm.mp4'],
      ['amazon', 'assets/graphics/media/common-skills-evasion-sm.mp4'],
      ['elf', 'assets/graphics/media/common-skills-evasion-sm.mp4'],
      ['dwarf', 'assets/graphics/media/common-skills-evasion-sm.mp4'],
      ['sorceress', 'assets/graphics/media/common-skills-evasion-sm.mp4'],
      ['wizard', 'assets/graphics/media/common-skills-evasion-sm.mp4'],
    ])],
    ['Deep Pockets', new Map([
      ['fighter', 'assets/graphics/media/common-skills-deep-pockets-sm.mp4'],
      ['amazon', 'assets/graphics/media/common-skills-deep-pockets-sm.mp4'],
      ['elf', 'assets/graphics/media/common-skills-deep-pockets-sm.mp4'],
      ['dwarf', 'assets/graphics/media/common-skills-deep-pockets-sm.mp4'],
      ['sorceress', 'assets/graphics/media/common-skills-deep-pockets-sm.mp4'],
      ['wizard', 'assets/graphics/media/common-skills-deep-pockets-sm.mp4'],
    ])],
    ['Bash', new Map([['fighter', 'assets/graphics/media/fighter-skills-bash-sm.mp4'],])],
    ['Cover Allies', new Map([['fighter', 'assets/graphics/media/fighter-skills-cover-allies-sm.mp4'],])],
    ['Cyclone Masher', new Map([['fighter', 'assets/graphics/media/fighter-skills-cyclone-masher-sm.mp4'],])],
    ['Distraction', new Map([['fighter', 'assets/graphics/media/fighter-skills-distraction-sm.mp4'],])],
    ['Judgement', new Map([['fighter', 'assets/graphics/media/fighter-skills-judgement-sm.mp4'],])],
    ['Reflect Missile', new Map([['fighter', 'assets/graphics/media/fighter-skills-reflect-missile-sm.mp4'],])],
    ['Rebuke', new Map([['fighter', 'assets/graphics/media/fighter-skills-rebuke-sm.mp4'],])],
    ['Reflex Guard', new Map([['fighter', 'assets/graphics/media/fighter-skills-reflex-guard-sm.mp4'],])],
    ['Sacrifice', new Map([['fighter', 'assets/graphics/media/fighter-skills-sacrifice-sm.mp4'],])],
    ['Shield Tactics', new Map([['fighter', 'assets/graphics/media/fighter-skills-shield-tactics-sm.mp4'],])],
    ['Shockwave', new Map([['fighter', 'assets/graphics/media/fighter-skills-shockwave-sm.mp4'],])],
    ['Tempest Edge', new Map([['fighter', 'assets/graphics/media/fighter-skills-tempest-edge-sm.mp4'],])],
    ['Adrenaline', new Map([['amazon', 'assets/graphics/media/amazon-skills-adrenaline-sm.mp4']])],
    ['Berserk', new Map([['amazon', 'assets/graphics/media/amazon-skills-berserk-sm.mp4']])],
    ['Brandish', new Map([['amazon', 'assets/graphics/media/amazon-skills-brandish-sm.mp4']])],
    ['Brutal Drive', new Map([['amazon', 'assets/graphics/media/amazon-skills-brutal-drive-sm.mp4']])],
    ['Deadly Revolution', new Map([['amazon', 'assets/graphics/media/amazon-skills-deadly-revolution-sm.mp4']])],
    ['Incite Rage', new Map([['amazon', 'assets/graphics/media/amazon-skills-incite-rage-sm.mp4']])],
    ['Iron Will', new Map([['amazon', 'assets/graphics/media/amazon-skills-iron-will-sm.mp4']])],
    ['Neck Splitter', new Map([['amazon', 'assets/graphics/media/amazon-skills-neck-splitter-sm.mp4']])],
    ['Parry', new Map([['amazon', 'assets/graphics/media/amazon-skills-parry-sm.mp4']])],
    ['Punisher', new Map([['amazon', 'assets/graphics/media/amazon-skills-punisher-sm.mp4']])],
    ['Stun Wave', new Map([['amazon', 'assets/graphics/media/amazon-skills-stun-wave-sm.mp4']])],
    ['War Paint', new Map([['amazon', 'assets/graphics/media/amazon-skills-war-paint-sm.mp4']])],
    ['Backstab', new Map([['elf', 'assets/graphics/media/elf-skills-backstab-sm.mp4']])],
    ['Battle Hardened', new Map([['elf', 'assets/graphics/media/elf-skills-battle-hardened-sm.mp4']])],
    ['Clone Strikes', new Map([['elf', 'assets/graphics/media/elf-skills-clone-strikes-sm.mp4']])],
    ['Deadly Boots', new Map([['elf', 'assets/graphics/media/elf-skills-deadly-boots-sm.mp4']])],
    ['Elemental Lore', new Map([['elf', 'assets/graphics/media/elf-skills-elemental-lore-sm.mp4']])],
    ['Holdout Dagger', new Map([['elf', 'assets/graphics/media/elf-skills-holdout-dagger-sm.mp4']])],
    ['Impact Arrow', new Map([['elf', 'assets/graphics/media/elf-skills-impact-arrow-sm.mp4']])],
    ['Power Shot', new Map([['elf', 'assets/graphics/media/elf-skills-power-shot-sm.mp4']])],
    ['Rapid Fire', new Map([['elf', 'assets/graphics/media/elf-skills-rapid-fire-sm.mp4']])],
    ['Salamander Oil', new Map([['elf', 'assets/graphics/media/elf-skills-salamander-oil-sm.mp4']])],
    ['Spacious Quiver', new Map([['elf', 'assets/graphics/media/elf-skills-spacious-quiver-sm.mp4']])],
    ['Toxic Extract', new Map([['elf', 'assets/graphics/media/elf-skills-toxic-extract-sm.mp4']])],
    ['Bomb Satchel', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-bomb-satchel-sm.mp4']])],
    ['Eagle Dive', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-eagle-dive-sm.mp4']])],
    ['Fire Barrel', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-fire-barrel-sm.mp4']])],
    ['Frenzy', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-frenzy-sm.mp4']])],
    ['Grand Smash', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-grand-smash-sm.mp4']])],
    ['Lethal Fists', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-lethal-fists-sm.mp4']])],
    ['Magma Infusion', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-magma-infusion-sm.mp4']])],
    ['Powder Mastery', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-powder-mastery-sm.mp4']])],
    ['Power Bomb', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-power-bomb-sm.mp4']])],
    ['Rock Skin', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-rock-skin-sm.mp4']])],
    ['Toughness', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-toughness-sm.mp4']])],
    ['Trinket Maniac', new Map([['dwarf', 'assets/graphics/media/dwarf-skills-trinket-maniac-sm.mp4']])],
    ['Animate Skeleton', new Map([['sorceress', 'assets/graphics/media/sorceress-skills-animate-skeleton-sm.mp4']])],
    ['Blizzard', new Map([['sorceress', 'assets/graphics/media/sorceress-skills-blizzard-sm.mp4']])],
    ['Create Food', new Map([['sorceress', 'assets/graphics/media/sorceress-skills-create-food-sm.mp4']])],
    ['Curse', new Map([['sorceress', 'assets/graphics/media/sorceress-skills-curse-sm.mp4']])],
    ['Gravity', new Map([['sorceress', 'assets/graphics/media/sorceress-skills-gravity-sm.mp4']])],
    ['Ice Prison', new Map([['sorceress', 'assets/graphics/media/sorceress-skills-ice-prison-sm.mp4']])],
    ['Petrification', new Map([['sorceress', 'assets/graphics/media/sorceress-skills-petrification-sm.mp4']])],
    ['Protection', new Map([['sorceress', 'assets/graphics/media/sorceress-skills-protection-sm.mp4']])],
    ['Rock Press', new Map([['sorceress', 'assets/graphics/media/sorceress-skills-rock-press-sm.mp4']])],
    ['Thunderhead', new Map([['sorceress', 'assets/graphics/media/sorceress-skills-thunderhead-sm.mp4']])],
    ['Blaze', new Map([['wizard', 'assets/graphics/media/wizard-skills-blaze-sm.mp4']])],
    ['Concentrate', new Map([
      ['wizard', 'assets/graphics/media/wizard-skills-concentrate-sm.mp4'],
      ['sorceress', 'assets/graphics/media/sorceress-skills-concentrate-sm.mp4']
    ])],
    ['Create Golem', new Map([['wizard', 'assets/graphics/media/wizard-skills-create-golem-sm.mp4']])],
    ['Extinction', new Map([['wizard', 'assets/graphics/media/wizard-skills-extinction-sm.mp4']])],
    ['Extract', new Map([
      ['wizard', 'assets/graphics/media/wizard-skills-extract-sm.mp4'],
      ['sorceress', 'assets/graphics/media/sorceress-skills-extract-sm.mp4']
    ])],
    ['Fire Ward', new Map([['wizard', 'assets/graphics/media/wizard-skills-fire-ward-sm.mp4']])],
    ['Flame Burst', new Map([['wizard', 'assets/graphics/media/wizard-skills-flame-burst-sm.mp4']])],
    ['Levitation', new Map([
      ['wizard', 'assets/graphics/media/wizard-skills-levitation-sm.mp4'],
      ['sorceress', 'assets/graphics/media/sorceress-skills-levitation-sm.mp4']
    ])],
    ['Mental Absorb', new Map([
      ['wizard', 'assets/graphics/media/wizard-skills-mental-absorb-sm.mp4'],
      ['sorceress', 'assets/graphics/media/sorceress-skills-mental-absorb-sm.mp4']
    ])],
    ['Meteor Swarm', new Map([['wizard', 'assets/graphics/media/wizard-skills-meteor-swarm-sm.mp4']])],
    ['Slow', new Map([['wizard', 'assets/graphics/media/wizard-skills-slow-sm.mp4']])],
    ['Spirit Up', new Map([
      ['wizard', 'assets/graphics/media/wizard-skills-spirit-up-sm.mp4'],
      ['sorceress', 'assets/graphics/media/sorceress-skills-spirit-up-sm.mp4']
    ])],
    ['Storm', new Map([['wizard', 'assets/graphics/media/wizard-skills-storm-sm.mp4']])],
    ['Thunderbolt', new Map([['wizard', 'assets/graphics/media/wizard-skills-thunderbolt-sm.mp4']])],
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

  // getVideoPath(): string {
  //   return this.skills.get(this.skillName) || '';
  // }

  getVideoPath(): string {
    const skillMap = this.skills.get(this.skillName);
    if (skillMap) {
      return skillMap.get(this.className.toLowerCase()) || '';
    }
    return '';
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
