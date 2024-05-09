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
  //   ['Slide Attack', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-slide-attack-sm.mp4'],
  //   ['Wealth to Health', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-wealth-to-health-sm.mp4'],
  //   ['Money is Power', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-money-is-power-sm.mp4'],
  //   ['Vitality Boost', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-vitality-boost-sm.mp4'],
  //   ['Nutritionist', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-nutritionist-sm.mp4'],
  //   ['Maintenance', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-maintenance-sm.mp4'],
  //   ['Adroit Hands', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-adroit-hands-sm.mp4'],
  //   ['Evasion', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-evasion-sm.mp4'],
  //   ['Deep Pockets', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-deep-pockets-sm.mp4'],
  //   ['Bash', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-bash-sm.mp4'],
  //   ['Cover Allies', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-cover-allies-sm.mp4'],
  //   ['Cyclone Masher', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-cyclone-masher-sm.mp4'],
  //   ['Distraction', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-distraction-sm.mp4'],
  //   ['Judgement', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-judgement-sm.mp4'],
  //   ['Reflect Missile', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-reflect-missile-sm.mp4'],
  //   ['Rebuke', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-rebuke-sm.mp4'],
  //   ['Reflex Guard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-reflex-guard-sm.mp4'],
  //   ['Sacrifice', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-sacrifice-sm.mp4'],
  //   ['Shield Tactics', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-shield-tactics-sm.mp4'],
  //   ['Shockwave', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-shockwave-sm.mp4'],
  //   ['Tempest Edge', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-tempest-edge-sm.mp4'],
  //   ['Adrenaline', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-adrenaline-sm.mp4'],
  //   ['Berserk', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-berserk-sm.mp4'],
  //   ['Brandish', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-brandish-sm.mp4'],
  //   ['Brutal Drive', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-brutal-drive-sm.mp4'],
  //   ['Deadly Revolution', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-deadly-revolution-sm.mp4'],
  //   ['Incite Rage', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-incite-rage-sm.mp4'],
  //   ['Iron Will', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-iron-will-sm.mp4'],
  //   ['Neck Splitter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-neck-splitter-sm.mp4'],
  //   ['Parry', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-parry-sm.mp4'],
  //   ['Punisher', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-punisher-sm.mp4'],
  //   ['Stun Wave', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-stun-wave-sm.mp4'],
  //   ['War Paint', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-war-paint-sm.mp4'],
  //   ['Blaze', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-blaze-sm.mp4'],
  //   ['Concentrate', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-concentrate-sm.mp4'],
  //   ['Create Golem', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-create-golem-sm.mp4'],
  //   ['Extinction', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-extinction-sm.mp4'],
  //   ['Extract', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-extract-sm.mp4'],
  //   ['Fire Ward', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-fire-ward-sm.mp4'],
  //   ['Flame Burst', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-flame-burst-sm.mp4'],
  //   ['Levitation', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-levitation-sm.mp4'],
  //   ['Mental Absorb', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-mental-absorb-sm.mp4'],
  //   ['Meteor Swarm', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-meteor-swarm-sm.mp4'],
  //   ['Slow', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-slow-sm.mp4'],
  //   ['Spirit Up', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-spirit-up-sm.mp4'],
  //   ['Storm', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-storm-sm.mp4'],
  //   ['Thunderbolt', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-thunderbolt-sm.mp4'],
  // ]);

  skills: Map<string, Map<string, string>> = new Map([
    ['Slide Attack', new Map([
      ['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-slide-attack-sm.mp4'],
      ['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-slide-attack-sm.mp4'],
      ['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-slide-attack-sm.mp4'],
      ['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-slide-attack-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-slide-attack-sm.mp4'],
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-slide-attack-sm.mp4'],
    ])],
    ['Wealth to Health', new Map([
      ['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-wealth-to-health-sm.mp4'],
      ['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-wealth-to-health-sm.mp4'],
      ['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-wealth-to-health-sm.mp4'],
      ['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-wealth-to-health-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-wealth-to-health-sm.mp4'],
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-wealth-to-health-sm.mp4'],
    ])],
    ['Money is Power', new Map([
      ['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-money-is-power-sm.mp4'],
      ['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-money-is-power-sm.mp4'],
      ['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-money-is-power-sm.mp4'],
      ['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-money-is-power-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-money-is-power-sm.mp4'],
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-money-is-power-sm.mp4'],
    ])],
    ['Vitality Boost', new Map([
      ['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-vitality-boost-sm.mp4'],
      ['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-vitality-boost-sm.mp4'],
      ['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-vitality-boost-sm.mp4'],
      ['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-vitality-boost-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-vitality-boost-sm.mp4'],
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-vitality-boost-sm.mp4'],
    ])],
    ['Nutritionist', new Map([
      ['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-nutritionist-sm.mp4'],
      ['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-nutritionist-sm.mp4'],
      ['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-nutritionist-sm.mp4'],
      ['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-nutritionist-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-nutritionist-sm.mp4'],
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-nutritionist-sm.mp4'],
    ])],
    ['Maintenance', new Map([
      ['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-maintenance-sm.mp4'],
      ['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-maintenance-sm.mp4'],
      ['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-maintenance-sm.mp4'],
      ['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-maintenance-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-maintenance-sm.mp4'],
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-maintenance-sm.mp4'],
    ])],
    ['Adroit Hands', new Map([
      ['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-adroit-hands-sm.mp4'],
      ['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-adroit-hands-sm.mp4'],
      ['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-adroit-hands-sm.mp4'],
      ['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-adroit-hands-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-adroit-hands-sm.mp4'],
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-adroit-hands-sm.mp4'],
    ])],
    ['Evasion', new Map([
      ['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-evasion-sm.mp4'],
      ['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-evasion-sm.mp4'],
      ['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-evasion-sm.mp4'],
      ['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-evasion-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-evasion-sm.mp4'],
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-evasion-sm.mp4'],
    ])],
    ['Deep Pockets', new Map([
      ['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-deep-pockets-sm.mp4'],
      ['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-deep-pockets-sm.mp4'],
      ['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-deep-pockets-sm.mp4'],
      ['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-deep-pockets-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-deep-pockets-sm.mp4'],
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/common-skills-deep-pockets-sm.mp4'],
    ])],
    ['Bash', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-bash-sm.mp4'],])],
    ['Cover Allies', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-cover-allies-sm.mp4'],])],
    ['Cyclone Masher', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-cyclone-masher-sm.mp4'],])],
    ['Distraction', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-distraction-sm.mp4'],])],
    ['Judgement', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-judgement-sm.mp4'],])],
    ['Reflect Missile', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-reflect-missile-sm.mp4'],])],
    ['Rebuke', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-rebuke-sm.mp4'],])],
    ['Reflex Guard', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-reflex-guard-sm.mp4'],])],
    ['Sacrifice', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-sacrifice-sm.mp4'],])],
    ['Shield Tactics', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-shield-tactics-sm.mp4'],])],
    ['Shockwave', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-shockwave-sm.mp4'],])],
    ['Tempest Edge', new Map([['fighter', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter-skills-tempest-edge-sm.mp4'],])],
    ['Adrenaline', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-adrenaline-sm.mp4']])],
    ['Berserk', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-berserk-sm.mp4']])],
    ['Brandish', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-brandish-sm.mp4']])],
    ['Brutal Drive', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-brutal-drive-sm.mp4']])],
    ['Deadly Revolution', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-deadly-revolution-sm.mp4']])],
    ['Incite Rage', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-incite-rage-sm.mp4']])],
    ['Iron Will', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-iron-will-sm.mp4']])],
    ['Neck Splitter', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-neck-splitter-sm.mp4']])],
    ['Parry', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-parry-sm.mp4']])],
    ['Punisher', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-punisher-sm.mp4']])],
    ['Stun Wave', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-stun-wave-sm.mp4']])],
    ['War Paint', new Map([['amazon', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon-skills-war-paint-sm.mp4']])],
    ['Backstab', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-backstab-sm.mp4']])],
    ['Battle Hardened', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-battle-hardened-sm.mp4']])],
    ['Clone Strikes', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-clone-strikes-sm.mp4']])],
    ['Deadly Boots', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-deadly-boots-sm.mp4']])],
    ['Elemental Lore', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-elemental-lore-sm.mp4']])],
    ['Holdout Dagger', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-holdout-dagger-sm.mp4']])],
    ['Impact Arrow', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-impact-arrow-sm.mp4']])],
    ['Power Shot', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-power-shot-sm.mp4']])],
    ['Rapid Fire', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-rapid-fire-sm.mp4']])],
    ['Salamander Oil', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-salamander-oil-sm.mp4']])],
    ['Spacious Quiver', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-spacious-quiver-sm.mp4']])],
    ['Toxic Extract', new Map([['elf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf-skills-toxic-extract-sm.mp4']])],
    ['Bomb Satchel', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-bomb-satchel-sm.mp4']])],
    ['Eagle Dive', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-eagle-dive-sm.mp4']])],
    ['Fire Barrel', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-fire-barrel-sm.mp4']])],
    ['Frenzy', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-frenzy-sm.mp4']])],
    ['Grand Smash', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-grand-smash-sm.mp4']])],
    ['Lethal Fists', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-lethal-fists-sm.mp4']])],
    ['Magma Infusion', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-magma-infusion-sm.mp4']])],
    ['Powder Mastery', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-powder-mastery-sm.mp4']])],
    ['Power Bomb', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-power-bomb-sm.mp4']])],
    ['Rock Skin', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-rock-skin-sm.mp4']])],
    ['Toughness', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-toughness-sm.mp4']])],
    ['Trinket Maniac', new Map([['dwarf', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf-skills-trinket-maniac-sm.mp4']])],
    ['Animate Skeleton', new Map([['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-animate-skeleton-sm.mp4']])],
    ['Blizzard', new Map([['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-blizzard-sm.mp4']])],
    ['Create Food', new Map([['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-create-food-sm.mp4']])],
    ['Curse', new Map([['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-curse-sm.mp4']])],
    ['Gravity', new Map([['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-gravity-sm.mp4']])],
    ['Ice Prison', new Map([['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-ice-prison-sm.mp4']])],
    ['Petrification', new Map([['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-petrification-sm.mp4']])],
    ['Protection', new Map([['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-protection-sm.mp4']])],
    ['Rock Press', new Map([['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-rock-press-sm.mp4']])],
    ['Thunderhead', new Map([['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-thunderhead-sm.mp4']])],
    ['Blaze', new Map([['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-blaze-sm.mp4']])],
    ['Concentrate', new Map([
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-concentrate-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-concentrate-sm.mp4']
    ])],
    ['Create Golem', new Map([['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-create-golem-sm.mp4']])],
    ['Extinction', new Map([['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-extinction-sm.mp4']])],
    ['Extract', new Map([
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-extract-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-extract-sm.mp4']
    ])],
    ['Fire Ward', new Map([['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-fire-ward-sm.mp4']])],
    ['Flame Burst', new Map([['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-flame-burst-sm.mp4']])],
    ['Levitation', new Map([
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-levitation-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-levitation-sm.mp4']
    ])],
    ['Mental Absorb', new Map([
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-mental-absorb-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-mental-absorb-sm.mp4']
    ])],
    ['Meteor Swarm', new Map([['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-meteor-swarm-sm.mp4']])],
    ['Slow', new Map([['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-slow-sm.mp4']])],
    ['Spirit Up', new Map([
      ['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-spirit-up-sm.mp4'],
      ['sorceress', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress-skills-spirit-up-sm.mp4']
    ])],
    ['Storm', new Map([['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-storm-sm.mp4']])],
    ['Thunderbolt', new Map([['wizard', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard-skills-thunderbolt-sm.mp4']])],
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
