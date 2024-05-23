import { AudioEntity } from './../../models/audio-entity';
import { SkillDetails } from './../../models/skill-details';
import { PlayerClassService } from './../../services/player-class.service';
import { AuthService } from './../../services/auth.service';
import { AfterViewInit, Component, ElementRef, HostListener, inject, NgZone, OnDestroy, OnInit, QueryList, Renderer2, ViewChild, ViewChildren } from '@angular/core';
import { PlayerClass } from 'src/app/models/player-class';
import { Subject, Subscription, takeUntil } from 'rxjs';
import { Skill } from 'src/app/models/skill';
import { Quest } from 'src/app/models/quest';
import { ImageEntity } from 'src/app/models/image-entity';
import { PreloadService } from 'src/app/services/preload.service';
import { CombinedSkill } from 'src/app/models/combined-skill';
import html2canvas from 'html2canvas';
import { Router } from '@angular/router';
import { VideoEntity } from 'src/app/models/video-entity';
import { PreloadAudioEntitiesService } from 'src/app/services/preload-audio-entities.service';

import * as pako from 'pako';
import { trigger, style, transition, animate } from '@angular/animations';
import { SampleVoiceComponent } from '../sample-voice/sample-voice.component';
import { SoundManagerService } from 'src/app/services/sound-manager.service';
import { SnackbarService } from 'src/app/services/snackbar.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
  animations: [
    trigger('slideUpAndOut', [
      transition(':leave', [
        animate('0.15s linear', style({ transform: 'translateY(-100%)' }))
      ])
    ])
  ]
})
export class HomeComponent implements OnInit, OnDestroy, AfterViewInit {

  // properties
  playerClasses: PlayerClass[] = [];
  currentStats: any;
  currentSpriteUrl: string = '';
  totalExp: number = 0;
  commonSkills: Skill[] = [];
  uniqueSkills: Skill[] =[];
  currentLevel: number = 1;
  currentSkill: Skill = new Skill();
  selectedSkillIndex: number | null = null;
  selectedSkill: { index: number | null, type: 'common' | 'unique' | null } = { index: null, type: null };
  quests: Quest[] = [];
  selectedQuests: Quest[] = [];
  currentQuestSP: number = 0;
  currentLevelSP: number = 0;
  initialTotalSP: number = 1;
  totalAvailableSP: number = this.initialTotalSP;
  skillsList: CombinedSkill[] = [];
  currentBuild: CombinedSkill[] = [];
  originalBuild: CombinedSkill[] = [];
  previousClassVoice: string = '';
  skillsNameAsc: CombinedSkill[] = [];
  skillsNameDesc: CombinedSkill[] = [];
  skillsBySPAsc: CombinedSkill[] = [];
  skillsBySPDesc: CombinedSkill[] = [];
  currentVideoPath: string = '';
  currentVideoSrc: string = '';
  previousVideoPath: string = '';
  streamableImage: HTMLImageElement | null = null;
  private observer: IntersectionObserver | null = null;
  fetchController: AbortController | null = null;

  private listenerFn: (() => void) | null = null;

  // app state
  buildToShare: any;
  encodedData: any;

  // category counts
  categoryCounts = new Map([
    ["Attack", 0],
    ["Defense", 0],
    ["Supplemental", 0],
    ["Air", 0],
    ["Ground", 0],
    ["Bow and arrow", 0],
    ["Tools", 0],
    ["Special", 0],
    ["Common", 0]
  ]);

  // image assets to preload
  images: ImageEntity[] = [
    {
      name: 'build_bg',
      minUrl: 'https://live.staticflickr.com/65535/53593069654_0b983c5af3_k.jpg',
      maxUrl: 'https://live.staticflickr.com/65535/53593069654_0b983c5af3_k.jpg',
      isLoaded: false,
    },
    {
      name: 'character_bg',
      minUrl: 'https://live.staticflickr.com/65535/53624067626_10b6b47321_k.jpg',
      maxUrl: 'https://live.staticflickr.com/65535/53624067626_10b6b47321_k.jpg',
      isLoaded: false,
    },
  ];

  // subjects
  private destroy$ = new Subject<void>();

  // observed elements
  @ViewChildren('observedElement') observedElements!: QueryList<ElementRef>;
  @ViewChild('sheenBox', { static: false }) sheenBoxRef: ElementRef | undefined;
  @ViewChild('skillInfoBoard', { static: false }) skillInfoBoard!: ElementRef<HTMLDivElement>;
  @ViewChild('videoPlayer1') videoPlayer1!: ElementRef<HTMLVideoElement>;
  @ViewChild('videoPlayer2') videoPlayer2!: ElementRef<HTMLVideoElement>;
  @ViewChild('videoPlayer3') videoPlayer3!: ElementRef<HTMLVideoElement>;
  @ViewChild(SampleVoiceComponent) sampleVoiceComponent!: SampleVoiceComponent;

  // booleans
  classSelected: boolean = false;
  currentClassData: any = null;
  selectedClassIndex: number | null = null;
  selected: boolean = false;
  artworkLoaded: boolean = false;
  showCommonSkills: boolean = true;
  showUniqueSkills: boolean = false;
  skillSelected: boolean = false;
  currentSkillEffects: string[] = [];
  skillCardLoaded: boolean = false;
  playerCardLoaded: boolean = false;
  isModalVisible = false;
  viewQuests: boolean = false;
  viewBuild: boolean = false;
  viewRunes: boolean = false;
  showAll: boolean = false;
  showByNameAsc: boolean = false;
  showByNameDesc: boolean = false;
  showBySPAsc: boolean = false;
  showBySPDesc: boolean = false;
  isSkillInfoVisible: boolean = false;
  inputFocused: boolean = false;
  loading: boolean = false;
  classDataLoaded: boolean = false;
  audioPreloaded: boolean = false;
  classLoading: boolean = false;
  appLoading: boolean = false;
  showModal: boolean = false;
  viewSkillCard: boolean = false;

  // tooltip
  tooltipVisible: boolean = false;
  tooltipLoading: boolean = false;
  tooltipUrl: string = '';
  tooltipIndex: number | null = null;
  tooltipTop: number = 0;
  tooltipLeft: number = 0;
  tooltipPosition = { top: 0, left: 0 };

  // typewriter
  currentTimeoutId: number | null = null;

  // audio
  currentAudio: HTMLAudioElement | null = null;
  currentClassAudio: HTMLAudioElement | null = null;
  // private audioPaths: Record<ClassName, string> = {
  //   amazon: 'assets/audio/amazon_select.mp3',
  //   dwarf: 'assets/audio/dwarf_select.mp3',
  //   elf: 'assets/audio/elf_select.mp3',
  //   fighter: 'assets/audio/fighter_select.mp3',
  //   sorceress: 'assets/audio/sorceress_select.mp3',
  //   wizard: 'assets/audio/wizard_select.mp3',
  // };

  sounds: AudioEntity[] = [
    { name: 'coinbag', path: 'assets/audio/coinbag_1.wav' },
    { name: 'accept', path: 'assets/audio/dc_accept_se.mp3' },
    { name: 'coinflip', path: 'assets/audio/dc_coinflip_se.mp3' },
    { name: 'confirm', path: 'assets/audio/dc_confirm_se.mp3' },
    { name: 'erase', path: 'assets/audio/dc_erase_se.mp3' },
    { name: 'rune',  path: 'assets/audio/dc_rune_se.mp3' },
    { name: 'scratch', path: 'assets/audio/dc_scratch_se.mp3' },
    { name: 'tick', path: 'assets/audio/dc_tick_se.mp3' },
    { name: 'ticks', path: 'assets/audio/dc_ticks_se.mp3' },
    { name: 'unlock', path: 'assets/audio/dc_unlock_se.mp3' },
    { name: 'pageflip', path: 'assets/audio/dc_pageflip_se.mp3' },
    { name: 'treasure', path: 'assets/audio/dc_treasure_se.mp3' },
    { name: 'blip', path: 'assets/audio/dc_blip_se.mp3' },
    { name: 'dialogue', path: 'assets/audio/dc_dialogue_se.mp3' },
  ];

  videos: VideoEntity[] = [
    { name: 'fighter', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter_compressed_sm.mp4' },
    { name: 'amazon', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon_compressed_sm.mp4' },
    { name: 'elf', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf_compressed_sm.mp4' },
    { name: 'dwarf', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf_compressed_sm.mp4' },
    { name: 'sorceress', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress_compressed_sm.mp4' },
    { name: 'wizard', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard_compressed_sm.mp4' },
    // { name: 'fighter', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter_compressed.mp4' },
    // { name: 'amazon', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon_compressed.mp4' },
    // { name: 'elf', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf_compressed.mp4' },
    // { name: 'dwarf', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf_compressed.mp4' },
    // { name: 'sorceress', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress_compressed.mp4' },
    // { name: 'wizard', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard_compressed.mp4' },
    { name: 'fighter_intro', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/fighter_intro.mp4' },
    { name: 'amazon_intro', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/amazon_intro.mp4' },
    { name: 'elf_intro', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/elf_intro.mp4' },
    { name: 'dwarf_intro', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/dwarf_intro.mp4' },
    { name: 'sorceress_intro', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/sorceress_intro.mp4' },
    { name: 'wizard_intro', path: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownVideos/wizard_intro.mp4' },
  ];

  fighterSounds: AudioEntity[] = [
    { name: 'fighter1', path: 'assets/audio/select/fighter_select1.mp3' },
    { name: 'fighter2', path: 'assets/audio/select/fighter_select2.mp3' },
    { name: 'fighter3', path: 'assets/audio/select/fighter_select3.mp3' },
    { name: 'fighter4', path: 'assets/audio/select/fighter_select4.mp3' },
    { name: 'fighter5', path: 'assets/audio/select/fighter_select5.mp3' },
    { name: 'fighter6', path: 'assets/audio/select/fighter_select6.mp3' },
  ];

  amazonSounds: AudioEntity[] = [
    { name: 'amazon1', path: 'assets/audio/select/amazon_select1.mp3' },
    { name: 'amazon2', path: 'assets/audio/select/amazon_select2.mp3' },
    { name: 'amazon3', path: 'assets/audio/select/amazon_select3.mp3' },
    { name: 'amazon4', path: 'assets/audio/select/amazon_select4.mp3' },
    { name: 'amazon5', path: 'assets/audio/select/amazon_select5.mp3' },
  ];

  elfSounds: AudioEntity[] = [
    { name: 'elf1', path: 'assets/audio/select/elf_select1.mp3' },
    { name: 'elf2', path: 'assets/audio/select/elf_select2.mp3' },
    { name: 'elf3', path: 'assets/audio/select/elf_select3.mp3' },
    { name: 'elf4', path: 'assets/audio/select/elf_select4.mp3' },
    { name: 'elf5', path: 'assets/audio/select/elf_select5.mp3' },
    { name: 'elf6', path: 'assets/audio/select/elf_select6.mp3' },
  ];

  dwarfSounds: AudioEntity[] = [
    { name: 'dwarf1', path: 'assets/audio/select/dwarf_select1.mp3' },
    { name: 'dwarf2', path: 'assets/audio/select/dwarf_select2.mp3' },
    { name: 'dwarf3', path: 'assets/audio/select/dwarf_select3.mp3' },
    { name: 'dwarf4', path: 'assets/audio/select/dwarf_select4.mp3' },
    { name: 'dwarf5', path: 'assets/audio/select/dwarf_select5.mp3' },
    { name: 'dwarf6', path: 'assets/audio/select/dwarf_select6.mp3' },
  ];

  wizardSounds: AudioEntity[] = [
    { name: 'wizard1', path: 'assets/audio/select/wizard_select1.mp3' },
    { name: 'wizard2', path: 'assets/audio/select/wizard_select2.mp3' },
    { name: 'wizard3', path: 'assets/audio/select/wizard_select3.mp3' },
    { name: 'wizard4', path: 'assets/audio/select/wizard_select4.mp3' },
    { name: 'wizard5', path: 'assets/audio/select/wizard_select5.mp3' },
    { name: 'wizard6', path: 'assets/audio/select/wizard_select6.mp3' },
    { name: 'wizard7', path: 'assets/audio/select/wizard_select7.mp3' },
  ];

  sorceressSounds: AudioEntity[] = [
    { name: 'sorceress1', path: 'assets/audio/select/sorceress_select1.mp3' },
    { name: 'sorceress2', path: 'assets/audio/select/sorceress_select2.mp3' },
    { name: 'sorceress3', path: 'assets/audio/select/sorceress_select3.mp3' },
    { name: 'sorceress4', path: 'assets/audio/select/sorceress_select4.mp3' },
    { name: 'sorceress5', path: 'assets/audio/select/sorceress_select5.mp3' },
    { name: 'sorceress6', path: 'assets/audio/select/sorceress_select6.mp3' },
  ];

  // subscriptions
  private playerClassSubscription: Subscription | undefined;
  private preloadSubscription: Subscription | undefined;

  // dependencies
  auth = inject(AuthService);
  playerClassService = inject(PlayerClassService);
  renderer = inject(Renderer2);
  preloadService = inject(PreloadService);
  ngZone = inject(NgZone);
  router = inject(Router);
  preloadAudioService = inject(PreloadAudioEntitiesService);
  soundManager= inject(SoundManagerService);
  snackbarService = inject(SnackbarService);

  ngOnInit() {
    this.resetWindowPosition();
    this.subscribeToPlayerClassData();
    this.preloadImageEntities();
    this.preloadAllAudioEntities();

  }

  ngOnDestroy() {

    this.destroy$.next();
    this.destroy$.complete();

    if (this.observer) {
      this.observer.disconnect();
      this.observer = null;
    }

    window.removeEventListener('scroll', this.handleScroll);
    this.playerClassSubscription?.unsubscribe();
    this.preloadSubscription?.unsubscribe();

    this.renderer.setStyle(document.body, 'overflow', 'auto'); // Re-enable scroll when modal is closed

  }

  ngAfterViewInit(): void {
    this.observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('fadeIn');
          this.observer?.unobserve(entry.target);
        }
      });
    }, { threshold: 0.1 });

    this.observedElements.forEach(element => {
      this.observer?.observe(element.nativeElement);
    });
  }

  subscribeToPlayerClassData() {

    this.playerClassSubscription = this.playerClassService.indexAll().pipe(
      takeUntil(this.destroy$)
    ).subscribe({
      next: (data) => {
        this.playerClasses = data;
      },
      error: (fail) => {
        console.error('Error retrieving player classes data');
        console.error(fail);
      }
    });
  }

  resetWindowPosition() {
    history.scrollRestoration = 'manual';
    window.scrollTo(0, 0);
  }

  preloadAllAudioEntities() {
    if (!this.audioPreloaded) {
      this.preloadAudioService.preloadAudio(
        this.sounds
      ).then(() => {
          this.audioPreloaded = true;
      });
    }
  }

  triggerParticles() {
    const particles = document.querySelector('.particle video') as HTMLVideoElement | null;
    if (particles) {
      particles.play()
        .catch(error => console.error('Error trying to play the video:', error));
    } else {
      console.error('Video element not found!');
    }
  }

  preloadImageEntities() {
    this.images.forEach((image) => {
      this.preloadSubscription = this.preloadService.preloadImage(image.maxUrl).subscribe({
        next: (url) => {
          if (url === image.maxUrl) {
            image.isLoaded = true;
          }
        },
        error: (error) => console.error(`Failed to load image ${image.name}:`, error),
      });
    });
  }

  getImageUrl(name: string): string {
    const image = this.images.find(img => img.name === name);
    return image?.isLoaded ? image.maxUrl : image!.minUrl;
  }

  resetPortraits() {
    let ul = document.querySelector('#portraits-ul');
    if (ul) {
        Array.from(ul.childNodes).forEach(child => {
            const element = child as HTMLElement;
            element.style.opacity = '0.5';
            element.style.filter = 'drop-shadow(2px 4px 4px rgba(0, 0, 0, 0.5))';
        });
        ul = null;
    }
  }

  selectPortrait(elementId: string) {
    const element = document.querySelector(`#${elementId}`) as HTMLElement;
    element.style.opacity = '1';
    element.style.filter = 'filter: drop-shadow(2px 4px 10px rgba(0, 0, 0, 0.5)) brightness(1.1)';
  }

  resetCategoryCounts() {
    this.categoryCounts.forEach((value, key, map) => {
      map.set(key, 0);
    });
  }

  async loadClassData(classIndex: number): Promise<void> {
    this.classSelected = true;
    this.skillSelected = false;
    this.currentSkill = new Skill();
    this.selectedSkill = { index: null, type: null };
    this.viewQuests = false;
    this.viewBuild = false;
    this.viewRunes = false;
    this.currentLevelSP = 1;
    this.loading = true;
    this.classDataLoaded = true;
    this.showUniqueSkills = false;
    this.classLoading = false;

    if(this.classSelected) {
      this.selected = true;
      this.triggerParticles();

      if (!this.currentClassData || this.currentClassData.name !== this.playerClasses[classIndex].name) {
        this.pausePreviousVideo();
        this.appLoading = true;
        this.classLoading = true;
        this.renderer.setStyle(document.body, 'overflow', 'hidden');
        this.selectedClassIndex = classIndex;
        this.currentClassData = this.playerClasses[classIndex];

        this.currentStats = { ...this.currentClassData.classStats[0] };
        this.resetLevel();

        if (this.soundManager.isSoundEnabled()) {

          await this.playSound('accept', 0.5);
        }

        try {
          await this.preloadImage(this.currentClassData.cardUrl);
          this.playerCardLoaded = true;
          this.loading = false;
        } catch (error) {
          console.error('Image loading failed', error);
        }

        this.resetQuestsAndSkillPoints();
        this.resetCategoryCounts();

        this.commonSkills = this.currentClassData.skills
          .filter((skillObj: { skill: { common: boolean; }; }) => skillObj.skill.common === true)
          .map((skillObj: { skill: any; }) => skillObj.skill);

        this.uniqueSkills = this.currentClassData.skills
          .filter((skillObj: { skill: { common: boolean; }; }) => skillObj.skill.common === false)
          .map((skillObj: { skill: any }) => skillObj.skill);

        this.quests = this.currentClassData.quests.map((questObj: { quest: any }) => questObj.quest);

        this.showCommonSkills = true;
        this.currentSpriteUrl = this.currentClassData?.spriteStartUrl;

        await this.playClassMedia(this.currentClassData.name.toLowerCase());
        this.classLoading = false;
        this.appLoading = false;
        this.renderer.setStyle(document.body, 'overflow', 'auto');
      }
    }
  }

  pausePreviousVideo() {
    if (this.videoPlayer1 && this.videoPlayer1.nativeElement) {
      const currentVideo = this.videoPlayer1.nativeElement;
      if (!currentVideo.paused) {
        currentVideo.pause();
      }
    } else {
      console.error('Video player is not initialized.');
    }
  }

  async prepareVideo(className: string): Promise<HTMLVideoElement> {
    const videoPath = this.getVideoPath(className.toLowerCase());
    if (videoPath) {
      const videoPlayer = this.videoPlayer2.nativeElement as HTMLVideoElement;
      videoPlayer.src = videoPath;

      return new Promise((resolve, reject) => {
        videoPlayer.addEventListener('canplaythrough', () => resolve(videoPlayer), { once: true });
        videoPlayer.addEventListener('error', () => reject(new Error('Error loading video')), { once: true });
      });
    } else {
      throw new Error('Video not found');
    }
  }

  async playVideo(videoPlayer: HTMLVideoElement): Promise<void> {
    try {
      await videoPlayer.play();
      // Update the current and previous video paths
      this.previousVideoPath = this.currentVideoPath;
      this.currentVideoPath = videoPlayer.src;
      // Replace the current video player source
      const currentVideoPlayer = this.videoPlayer1.nativeElement as HTMLVideoElement;
      currentVideoPlayer.src = videoPlayer.src;
    } catch (error) {
      console.error('Error playing video:', error);
    }
  }

  async prepareAudio(className: string): Promise<HTMLAudioElement> {
    this.stopCurrentClassSound();
    const audioEntities = this.getClassAudioEntity(className);
    if (audioEntities.length > 0) {
      const randomIndex = this.getRandomNum(audioEntities);
      const selectedAudioEntity = audioEntities[randomIndex];
      const audio = new Audio(selectedAudioEntity.path);
      audio.volume = 0.5;
      this.currentClassAudio = audio;
      return new Promise((resolve, reject) => {
        audio.oncanplaythrough = () => resolve(audio);
        audio.onerror = () => reject(new Error('Error loading audio'));
      });
    } else {
      throw new Error('No audio found for class: ' + className);
    }
  }

  async playAudio(audio: HTMLAudioElement): Promise<void> {
    try {
      await audio.play();
      this.currentAudio = audio;  // Update the current audio reference if needed
    } catch (error) {
      console.error('Error playing audio:', error);
    }
  }

  async loadClassAudio(className: string): Promise<void> {
    try {
      const audio = await this.prepareAudio(className);
      await this.playAudio(audio);
    } catch (error) {
      console.error('Error handling audio:', error);
    }
  }

  async playClassMedia(className: string): Promise<void> {
    try {
      // Prepare both audio and video
      const videoPromise = this.prepareVideo(className);

      if (this.soundManager.isSoundEnabled()) {

        const audioPromise = this.prepareAudio(className);

              // Wait for both media to be ready
              const [videoPlayer, audio] = await Promise.all([videoPromise, audioPromise]);

              // Play both media
              const playVideoPromise = this.playVideo(videoPlayer);
              const playAudioPromise = this.playAudio(audio);

              // Wait for both to start playing
              await Promise.all([playVideoPromise, playAudioPromise]);
      } else {
        const videoPlayer = await videoPromise;

        const playVideoPromise = this.playVideo(videoPlayer);
        await Promise.all([playVideoPromise]);
      }
    } catch (error) {
      console.error('Error synchronizing media playback:', error);
    }
  }

  getVideoPath(className: string): string | undefined {
    const video = this.videos.find(v => v.name.toLowerCase() === className.toLowerCase());
    return video ? video.path : undefined;
  }

  onArtworkLoad() {
    this.artworkLoaded = true;
  }

  levelUp(): void {
    if (!this.currentStats || this.currentStats.level >= 99) {
      console.error('Current stats not defined');
      return;
    }
    const newLevel = Number(this.currentStats.level) + 1;
    this.updateLevel(newLevel);
    if (this.soundManager.isSoundEnabled()) {
      this.playSound('confirm');
    }
  }

  levelDown(): void {
    if (!this.currentStats || this.currentStats.level <= 1) {
      console.error('Current stats not defined or already at minimum level');
      return;
    }
    const newLevel = Number(this.currentStats.level) - 1;
    this.updateLevel(newLevel);
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('confirm');
    }
  }

  resetLevel() {
    this.skillsList = [];
    this.updateLevel(1);
    this.currentLevelSP = this.initialTotalSP;
    this.updateTotalAvailableSP();
    this.updateCurrentBuild();
  }

  setLevelToOne() {
    if (this.skillsList.length > 0 || this.currentStats.level > 1) {
      this.skillsList = [];
      this.updateLevel(1);
      this.currentLevelSP = this.initialTotalSP;
      this.updateTotalAvailableSP();
      this.updateCurrentBuild();
      if (this.soundManager.isSoundEnabled()) {

        this.playSound('erase');
      }
    }
  }

  setLevelToMax() {
    if (this.currentStats.level !== 99) {
      this.updateLevel(99);
      this.updateTotalAvailableSP();
      this.updateCurrentBuild();
      if (this.soundManager.isSoundEnabled()) {

        this.playSound('confirm');
      }
    }
  }

  updateLevel(newLevel: number): void {
    const validLevel = Math.max(1, Math.min(newLevel, 99));
    const stats = this.currentClassData.classStats.find((stat: { level: number; }) => stat.level === validLevel);
    if (stats) {
        this.currentStats = { ...stats };
        this.currentLevelSP = stats.skillPoints;
        this.updateTotalAvailableSP();
        this.calculateTotalExperience();
        if (this.totalAvailableSP < 0) {
          this.resetSkills();
        }
    } else {
        console.error('Stats for level', validLevel, 'not found');
    }
  }

  onEnterPress(event: KeyboardEvent): void {
    if (event.key === 'Enter') {
      let element = event.target as HTMLElement;
      element.blur();
    }
  }

  onLevelChange(): void {
    const enteredLevel = Number(this.currentStats.level);
    if (isNaN(enteredLevel)) {
      this.updateLevel(1);
    } else {
      this.updateLevel(enteredLevel);
    }
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('confirm');
    }
  }

  showTooltip = async (event: MouseEvent, videoName: string, index: number): Promise<void> => {
    if (!event.currentTarget) {
      console.error('Event target is null');
      return;
    }

    // Abort any ongoing fetch operation
    if (this.fetchController) {
      this.fetchController.abort();
      this.fetchController = null; // Clear the existing controller
    }

    this.tooltipVisible = true;
    this.tooltipLoading = true;
    const currentTooltipIndex = index; // Store the current index
    this.tooltipIndex = currentTooltipIndex;
    this.currentVideoSrc = ''; // Reset the video source initially
    this.fetchController = new AbortController(); // New controller for the new fetch

    const videoPath = this.getIntroVideoPath(videoName);
    if (!videoPath) {
      console.error('Video path is empty for:', videoName);
      this.tooltipLoading = false;
      return;
    }

    try {
      const introVideoResponse = await fetch(videoPath, { signal: this.fetchController.signal });
      if (introVideoResponse.ok) {
        // Check if the tooltip index has changed
        if (this.tooltipIndex !== currentTooltipIndex) {
          return; // Bail out if no longer hovering over the same portrait
        }
        this.currentVideoSrc = ''; // Clear the current source
        this.currentVideoSrc = videoPath;
        this.tooltipLoading = false;
      } else {
        console.error('Failed to fetch intro video:', introVideoResponse.statusText);
        this.tooltipLoading = false;
      }
    } catch (error) {
      if (error instanceof Error && error.name !== 'AbortError') {
        console.error('Error fetching intro video:', error.message);
      }
      this.tooltipLoading = false;
    } finally {
      this.fetchController = null;
    }
  }

  hideTooltip = (): void => {
    this.tooltipVisible = false;
    this.tooltipLoading = false;
    this.currentVideoSrc = '';

    // Abort the fetch operation when the tooltip is hidden
    if (this.fetchController) {
      this.fetchController.abort();
      this.fetchController = null;
    }
  }

  getIntroVideoPath(videoName: string): string {
    const video = this.videos.find(v => v.name.toLowerCase() === videoName.toLowerCase() + "_intro");
    return video ? video.path : '';
  }

  forcePlayVideo(videoElement: HTMLVideoElement): void {
    if (videoElement) {
      videoElement.play().catch(err => {
        console.error('Error attempting to play video:', err.message);
      });
    }
  }

  changeSpriteTo(type: 'start' | 'end') {
    if (type === 'start') {
      this.currentSpriteUrl = this.currentClassData?.spriteStartUrl;
    } else {
      this.currentSpriteUrl = this.currentClassData?.spriteEndUrl;
    }
  }

  calculateTotalExperience() {
    const level = this.currentStats.level - 1;
    let total = 0;
    for(let i = level; i >= 1; i--) {
      total += this.currentClassData.classStats[level].requiredExp
    }
    this.totalExp = total;
  }

  viewCommonSkills() {
    this.showCommonSkills = true;
    this.viewQuests = false;
    this.viewBuild = false;
    this.viewRunes = false;
    this.showUniqueSkills = false;
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('accept', 0.5);
    }
  }

  viewUniqueSkills() {
    this.showUniqueSkills = true;
    this.viewQuests = false;
    this.viewBuild = false;
    this.viewRunes = false;
    this.showCommonSkills = false;
    // const commonBtn = document.querySelector('#common-btn');
    // const uniqueBtn = document.querySelector('#unique-btn');
    // commonBtn?.classList.remove('selected-skills');
    // uniqueBtn?.classList.add('selected-skills');
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('accept', 0.5);
    }
  }

  viewQuestList() {
    this.viewQuests = true;
    this.viewBuild = false;
    this.viewRunes = false;
    this.showCommonSkills = false;
    this.showUniqueSkills = false;
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('accept', 0.5);
    }
  }

  viewCurrentBuild() {
    this.viewBuild = true;
    this.viewQuests = false;
    this.viewRunes = false;
    this.showCommonSkills = false;
    this.showUniqueSkills = false;
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('accept', 0.5);
    }
  }

  viewRunesMatcher() {
    this.viewRunes = true;
    this.viewBuild = false;
    this.viewQuests = false;
    this.showCommonSkills = false;
    this.showUniqueSkills = false;
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('accept', 0.5);
    }
  }

  async selectSkill(skillIndex: number, skillType: 'common' | 'unique'): Promise<void> {
    if (this.selectedSkill && this.selectedSkill.index === skillIndex && this.selectedSkill.type === skillType) {
    } else {
      this.selectedSkill = { index: skillIndex, type: skillType };
      this.skillSelected = true;
      this.skillCardLoaded = false;
      this.isSkillInfoVisible = false;
      this.toggleGlassEffect();
      this.stopCurrentSound();
      if (this.soundManager.isSoundEnabled()) {

        this.playSound('pageflip');
      }

      const skill = skillType === 'common' ? this.commonSkills[skillIndex] : this.uniqueSkills[skillIndex];
      this.currentSkill = skill;

      try {
        this.ngZone.runOutsideAngular(() => {
          setTimeout(() => {
            this.ngZone.run(() => {
              // Now that the image is loaded, show the skill info
              this.isSkillInfoVisible = true;
              // Use requestAnimationFrame to ensure the DOM has updated
              requestAnimationFrame(() => {
                this.adjustChildrenPosition(window.scrollY);
              });
            });
          }, 100);
        });

        await this.preloadImage(skill.cardImageUrl);
        this.skillCardLoaded = true;

      } catch (error) {
        console.error('Image loading failed', error);
      }
    }
  }

  toggleGlassEffect(): void {
    if (this.sheenBoxRef && this.sheenBoxRef.nativeElement) {
      const sheenBox = this.sheenBoxRef.nativeElement;
      if (sheenBox.classList.contains('glass')) {
        this.renderer.removeClass(sheenBox, 'glass');
        setTimeout(() => this.renderer.addClass(sheenBox, 'glass'), 10);
      } else {
        this.renderer.addClass(sheenBox, 'glass');
      }
    }
  }

  preloadImage(url: string): Promise<HTMLImageElement> {
    return new Promise((resolve, reject) => {
      const img = new Image();
      img.onload = () => resolve(img);
      img.onerror = reject;
      img.src = url;
    });
  }

  preloadBackgroundImage(url: string): Promise<HTMLImageElement> {
    return new Promise((resolve, reject) => {
      const img = new Image();
      img.onload = () => resolve(img);
      img.onerror = reject;
      img.src = url;
    });
  }

  isQuestSelected(quest: Quest): boolean {
    return false;
  }

  calculateTotalSkillPoints(): number {
    return this.quests
      .filter(quest => quest.selected)
      .reduce((acc, quest) => acc + quest.skillPoints, 0);
  }

  toggleQuest(quest: Quest): void {
    quest.selected = !quest.selected;
    this.calculateTotalSkillPoints();
    this.updateTotalAvailableSP();
    this.stopCurrentSound();
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('coinbag', 0.5);
    }
    if (this.totalAvailableSP < 0) {
      this.resetSkills();
    }
  }

  toggleAllQuests(event: Event): void {
    const target = event.target as HTMLInputElement;
    const selected = target.checked;

    this.quests.forEach(quest => {
      quest.selected = selected;
    });

    this.updateTotalAvailableSP();
    this.stopCurrentSound();
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('coinbag', 0.5);
    }
    if (this.totalAvailableSP < 0) {
      this.resetSkills();
    }
  }

  areAllQuestsSelected(): boolean {
    return this.quests.every(quest => quest.selected);
  }

  updateSkillPoints() {
    this.updateTotalAvailableSP();
  }

  resetQuestsAndSkillPoints(): void {
    this.quests.forEach(quest => quest.selected = false);
    // Recalculate total available SP since quests skill points should now be reset
    this.updateTotalAvailableSP();
  }

  resetSkillsByCategory(category: string) {
    this.skillsList.filter(skill => !(skill.category === category));
  }

  isSkillDetailSelected(skill: Skill, skillDetail: SkillDetails): boolean {
    return this.skillsList.some(item =>
      item.skillId === skill.id && item.rank === skillDetail.rank
    );
  }

  isSkillDetailHighestRank(skill: Skill, skillDetail: SkillDetails): boolean {
    return skillDetail.rank === Math.max(...this.skillsList
      .filter(item => item.name === skill.name)
      .map(item => item.rank));
  }

  addToSkillsList(skill: Skill, selectedSkillDetail: SkillDetails): void {
    // First, remove any existing entries of this skill up to the selected rank to avoid duplicates
    this.skillsList = this.skillsList.filter(item => item.skillId !== skill.id || item.rank > selectedSkillDetail.rank);

    let additions = 0;

    // Then, add all ranks up to and including the selected rank
    skill.skillDetails.forEach(skillDetail => {
      if (skillDetail.rank <= selectedSkillDetail.rank) {
        this.addSkillDetailToList(skill, skillDetail);
        additions++;
      }
    });

    if (additions > 0) {
      this.updateCategoryCount(skill.category, additions);
    }

    this.updateCurrentBuild();
  }

  private addSkillDetailToList(skill: Skill, skillDetail: SkillDetails): void {
    const skillToAdd: CombinedSkill = {
      skillId: skill.id,
      name: skill.name,
      description: skill.description,
      cardImageUrl: skill.cardImageUrl,
      isCommon: skill.isCommon,
      rankDetailId: skillDetail.id,
      rank: skillDetail.rank,
      requiredSkillPoints: skillDetail.requiredSkillPoints,
      similarSkillLevel: skillDetail.similarSkillLevel,
      requiredPlayerLevel: skillDetail.requiredPlayerLevel,
      effects: skillDetail.effects,
      category: skill.category,
    };

    this.skillsList.push(skillToAdd);
    this.updateCurrentBuild();
  }

  updateCategoryCount(category: string, change: number): void {
    const currentCount = this.categoryCounts.get(category) || 0;
    this.categoryCounts.set(category, currentCount + change);
  }

  // iteration 1
  // removeFromSkillsList(skill: Skill, selectedSkillDetail: SkillDetails): void {
  //   const ranksBeingRemoved = this.skillsList.filter(item =>
  //     item.skillId === skill.id && item.rank >= selectedSkillDetail.rank
  //   ).length;

  //   this.skillsList = this.skillsList.filter(item =>
  //     !(item.skillId === skill.id && item.rank >= selectedSkillDetail.rank)
  //   );
  //   const skillCategory = skill.category;

  //   const skills = this.skillsList.filter(item => item.category === skillCategory);

  //   if (ranksBeingRemoved > 0) {
  //     this.updateCategoryCount(skill.category, -ranksBeingRemoved);
  //   }

  //   this.updateTotalAvailableSP();
  //   this.updateCurrentBuild();
  //   if (this.soundManager.isSoundEnabled()) {

  //     this.stopCurrentSound();
  //     this.playSound('erase');
  //   }
  // }

  // meetSimilarSkillLvlReqs(category: string): boolean {
  //   const categoryCount = this.categoryCounts.get(category) ?? 0;
  //   return this.skillsList
  //     .filter(skill => skill.category === category)
  //     .every(skill => skill.similarSkillLevel > categoryCount);
  // }

  // iteration 2
  // removeFromSkillsList(skill: Skill, selectedSkillDetail: SkillDetails): void {
  //   console.log("Removing from skills list");

  //   // Calculate ranks being removed
  //   const ranksBeingRemoved = this.skillsList.filter(item =>
  //     item.skillId === skill.id && item.rank >= selectedSkillDetail.rank
  //   ).length;
  //   console.log(`Ranks being removed: ${ranksBeingRemoved}`);

  //   // Remove the specified ranks from the skills list
  //   this.skillsList = this.skillsList.filter(item =>
  //     !(item.skillId === skill.id && item.rank >= selectedSkillDetail.rank)
  //   );
  //   // console.log(`Skills list after removal: ${JSON.stringify(this.skillsList)}`);

  //   const skillCategory = skill.category;

  //   if (ranksBeingRemoved > 0) {
  //     this.updateCategoryCount(skill.category, -ranksBeingRemoved);
  //   }

  //   // Continuously check and update skills in the category until all meet the similar skill level requirement
  //   while (!this.meetSimilarSkillLvlReqs(skillCategory)) {
  //     console.log(this.meetSimilarSkillLvlReqs(skillCategory));
  //     console.log("Checking similar skill level requirements");
  //     const skillsInCategory = this.skillsList.filter(item => item.category === skillCategory);
  //     let skillRemoved = false;

  //     for (let skillInCategory of skillsInCategory) {
  //       const categoryCount = this.categoryCounts.get(skillCategory) ?? 0;
  //       // console.log(`Category count: ${categoryCount}, Skill similar skill level: ${skillInCategory.similarSkillLevel}`);

  //       // Remove ranks one by one, ensuring the similar skill level requirement is not counted for itself or ranks with the same similar skill level
  //       if (skillInCategory.similarSkillLevel >= categoryCount) {
  //         console.log("Inside first if");

  //         // Find the current rank to remove
  //         const rankToRemove = this.skillsList.find(item =>
  //           item.skillId === skillInCategory.skillId && item.rank === skillInCategory.rank
  //         );

  //         if (rankToRemove) {
  //           console.log("Inside second if");

  //           // Check if the previous rank has the same similar skill level requirement
  //           const previousRank = this.skillsList.find(item =>
  //             item.skillId === skillInCategory.skillId && item.rank === skillInCategory.rank - 1 && item.similarSkillLevel === skillInCategory.similarSkillLevel
  //           );

  //           // Remove the current rank
  //           this.skillsList = this.skillsList.filter(item => item !== rankToRemove);
  //           this.updateCategoryCount(skillCategory, -1);

  //           // If previous rank has the same similar skill level requirement, remove it as well
  //           if (previousRank) {
  //             console.log("Removing previous rank with the same similar skill level");
  //             this.skillsList = this.skillsList.filter(item => item !== previousRank);
  //             this.updateCategoryCount(skillCategory, -1);
  //           }

  //           skillRemoved = true;
  //           break; // Break the loop to start the while check again
  //         }
  //       }
  //     }

  //     if (!skillRemoved) {
  //       // Break if no skills were removed in this iteration to avoid infinite loop
  //       break;
  //     }
  //   }

  //   // console.log(`Final skills list: ${JSON.stringify(this.skillsList)}`);

  //   this.updateTotalAvailableSP();
  //   this.updateCurrentBuild();

  //   if (this.soundManager.isSoundEnabled()) {
  //     this.stopCurrentSound();
  //     this.playSound('erase');
  //   }
  // }

  // meetSimilarSkillLvlReqs(category: string): boolean {
  //   const categoryCount = this.categoryCounts.get(category) ?? 0;
  //   return this.skillsList
  //     .filter(skill => skill.category === category)
  //     .every(skill => skill.similarSkillLevel < categoryCount);
  // }

  // iteration 3
  removeFromSkillsList(skill: Skill, selectedSkillDetail: SkillDetails): void {

    // Calculate ranks being removed
    const ranksBeingRemoved = this.skillsList.filter(item =>
      item.skillId === skill.id && item.rank >= selectedSkillDetail.rank
    ).length;

    // Remove the specified ranks from the skills list
    this.skillsList = this.skillsList.filter(item =>
      !(item.skillId === skill.id && item.rank >= selectedSkillDetail.rank)
    );

    const skillCategory = skill.category;

    if (ranksBeingRemoved > 0) {
      this.updateCategoryCount(skill.category, -ranksBeingRemoved);
    }

    // Continuously check and remove skills in the category until all meet the similar skill level requirement
    let skillRemoved = true;
    let snackbarShown = false;
    while (skillRemoved) {
      if (!snackbarShown) {
        snackbarShown = true;
        this.openSnackbar(`Additional ranks may have been removed for ${ skill.category.toUpperCase() } to ensure strict build planning.`, 'Dismiss');
      }
      skillRemoved = false;
      const categoryCount = this.categoryCounts.get(skillCategory) ?? 0;

      // Filter skills in the category that do not meet the requirements
      const skillsToRemove = this.skillsList.filter(skill =>
        skill.category === skillCategory && (skill.similarSkillLevel >= categoryCount - 3 && skill.similarSkillLevel > 0)
      );

      if (skillsToRemove.length > 0) {
        skillRemoved = true;
        for (let skillToRemove of skillsToRemove) {
          // Remove each skill that does not meet the requirement
          this.skillsList = this.skillsList.filter(item => item !== skillToRemove);
          this.updateCategoryCount(skillCategory, -1);
        }
      }
    }

    console.log(`Final skills list: ${JSON.stringify(this.skillsList)}`);

    this.updateTotalAvailableSP();
    this.updateCurrentBuild();

    if (this.soundManager.isSoundEnabled()) {
      this.stopCurrentSound();
      this.playSound('erase');
    }
  }

  meetSimilarSkillLvlReqs(category: string): boolean {
    const categoryCount = this.categoryCounts.get(category) ?? 0;
    return this.skillsList
      .filter(skill => skill.category === category)
      .every(skill => skill.similarSkillLevel < categoryCount - 3 || skill.similarSkillLevel === 0);
  }

  handleSkillClick(skill: Skill, skillDetail: SkillDetails): void {
    // Check if the selected rank is already selected
    const isAlreadySelected = this.isSkillDetailSelected(skill, skillDetail);

    // Calculate the number of ranks to potentially add or remove
    const ranksToAdd = skill.skillDetails.filter(detail =>
      detail.rank <= skillDetail.rank && !this.isSkillDetailSelected(skill, detail)
    ).length;

    if (isAlreadySelected) {
        // If the selected rank is already selected, remove it and all higher ranks
        this.removeFromSkillsList(skill, skillDetail);
    } else {
        // First, find out the total SP required to add this rank and all previous unselected ranks
        const requiredSPToAdd = skill.skillDetails
            .filter(detail => detail.rank <= skillDetail.rank && !this.isSkillDetailSelected(skill, detail))
            .reduce((total, detail) => total + detail.requiredSkillPoints, 0);

        const requiredSimilarSkillPointsToAdd = skill.skillDetails
        .filter(detail => detail.rank <= skillDetail.rank && detail.similarSkillLevel <= skillDetail.similarSkillLevel && !this.isSkillDetailSelected(skill, detail))
        .reduce((total, detail) => total + detail.similarSkillLevel, 0);

        // Check if we have enough SP to add the skill and its unselected previous ranks
        if (requiredSPToAdd <= this.totalAvailableSP) {
          if (this.categoryCounts.has(skill.category) && requiredSimilarSkillPointsToAdd <= (this.categoryCounts.get(skill.category) ?? 0) || skill.category === null) {
            // If so, add all ranks up to and including the selected rank that haven't been selected yet
            skill.skillDetails.forEach(detail => {
                if (detail.rank <= skillDetail.rank && !this.isSkillDetailSelected(skill, detail)) {
                    this.addSkillDetailToList(skill, detail);
                }
            });
          } else {
            // alert(`${ skill.name.toUpperCase() } is ${ skill.category.toUpperCase() } type. ${skill} requires a total of ${ requiredSimilarSkillPointsToAdd } ranks between all ${ skill.category } skills to unlock.`);
            this.openSnackbar(`This rank of ${ skill.name.toUpperCase() } requires a total of ${ requiredSimilarSkillPointsToAdd } points between all ${ skill.category.toUpperCase() } type skills. Please level up other ${ skill.category.toUpperCase() } skills first.`, 'Dismiss');
            return;
          }
            // Update category count positively since adding skills
            // this.updateCategoryCount(skill.category, ranksToAdd);
        } else {
            // alert("Not enough skill points available.");
            this.openSnackbar(`Insufficient skill points. ${ requiredSPToAdd - this.totalAvailableSP } more ${ requiredSPToAdd - this.totalAvailableSP > 1 ? 'points' : 'point' } required.`, 'Dismiss');
            return;
        }
        if (this.soundManager.isSoundEnabled()) {

          this.stopCurrentSound();
          this.playSound('confirm');
        }
    }

    this.updateCategoryCount(skill.category, isAlreadySelected ? -ranksToAdd : ranksToAdd);

    // Update total available SP after any changes
    this.updateTotalAvailableSP();
    console.log(this.categoryCounts);
  }

  updateTotalAvailableSP(): void {
    const questSP = this.calculateTotalSkillPoints();

    const spentSP = this.skillsList.reduce((total, item) => total + item.requiredSkillPoints, 0);

    const totalSkillPointsFromLevels = this.currentLevelSP;

    this.totalAvailableSP = totalSkillPointsFromLevels + questSP - spentSP;
  }

  isRankSelected(skillId: number, rank: number): boolean {
    return this.skillsList.some(skill => skill.skillId === skillId && skill.rank === rank);
  }

  removeSkillsByName(skillName: string, event?: MouseEvent): void {
    event?.stopPropagation(); // Prevent event from triggering parent click events

    // Determine how many instances of the skill are being removed
    const removals = this.skillsList.filter(skill => skill.name === skillName);
    const removalCount = removals.length;

    if (this.skillsList.some(skill => skill.name === skillName)) {
      if (this.soundManager.isSoundEnabled()) {

        this.playSound('scratch');
      }
    }

    this.skillsList = this.skillsList.filter(skill => skill.name !== skillName);

    // Update category count for the skill's category (assuming all removed skills have the same category)
    if (removalCount > 0) {
      const skillCategory = removals[0].category; // Assuming all instances have the same category
      const currentCount = this.categoryCounts.get(skillCategory) || 0;
      this.categoryCounts.set(skillCategory, currentCount - removalCount);
    }

    this.updateTotalAvailableSP();
    this.updateCurrentBuild();
  }

  updateCurrentBuild(): void {
    const highestRanks = new Map<number, number>();

    this.skillsList.forEach(skill => {
      const currentMaxRank = highestRanks.get(skill.skillId) || 0;
      if (skill.rank > currentMaxRank) {
        highestRanks.set(skill.skillId, skill.rank);
      }
    });

    this.currentBuild = this.skillsList.filter(skill => {
      const highestRank = highestRanks.get(skill.skillId);
      return skill.rank === highestRank;
    });

    this.originalBuild = this.currentBuild;
    this.buildToShare = {};

    // Iterate over each skill in this.originalBuild
    this.originalBuild.forEach(skill => {
        // Copy over the required properties to this.buildToShare
        this.buildToShare[skill.skillId] = {
            name: skill.name,
            description: skill.description,
            rank: skill.rank
        };
    });

    this.skillsNameAsc = this.sortByNameAsc(this.currentBuild);
    this.skillsNameDesc = this.sortByNameDesc(this.currentBuild);
    this.skillsBySPAsc = this.sortBySPAsc(this.currentBuild, this.currentClassData.skills);
    this.skillsBySPDesc = this.sortBySPDesc(this.currentBuild, this.currentClassData.skills);
  }

  // test
  async compressData(data: any): Promise<string> {
    return new Promise((resolve, reject) => {
      try {
        const jsonBuild = JSON.stringify(data);
        const compressedData = pako.deflate(jsonBuild);
        const byteArray = Array.from(compressedData); // Convert Uint8Array to array of numbers
        const base64Data = btoa(String.fromCharCode.apply(null, byteArray)); // Convert to base64
        const encodedData = encodeURIComponent(base64Data);
        resolve(encodedData);
      } catch (error) {
        reject(error);
      }
    });
  }

  async generateShareLinkAsText(): Promise<string> {
    if (!this.encodedData) {
      return '';
    }
    const shareLink = `https://www.dragonscrownplanner.com/DragonsCrown/#/build?encodedBuild=${this.encodedData}&classId=${this.currentClassData.id}`;
    return shareLink;
  }

  async copyShareLinkToClipboard(shareLink: string): Promise<void> {
    try {
      await navigator.clipboard.writeText(shareLink);
    } catch (err) {
      console.error('Failed to copy share link: ', err);
    }
  }

  async generateAndCopyShareLink(buildData: any): Promise<void> {
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('rune', 0.5);
    }
    try {
      const encodedData = await this.compressData(buildData);
      this.encodedData = encodedData;
      const shareLink = await this.generateShareLinkAsText();
      await this.copyShareLinkToClipboard(shareLink);
    } catch (error) {
      console.error('Error generating and copying share link:', error);
    }
  }

  getClassAudioEntity(className: string) {
    let soundArr: AudioEntity[];

    switch (className.toLowerCase()) {
        case 'fighter':
            soundArr = this.fighterSounds;
            break;
        case 'amazon':
            soundArr = this.amazonSounds;
            break;
        case 'elf':
            soundArr = this.elfSounds;
            break;
        case 'dwarf':
            soundArr = this.dwarfSounds;
            break;
        case 'wizard':
            soundArr = this.wizardSounds;
            break;
        case 'sorceress':
            soundArr = this.sorceressSounds;
            break;
        default:
            soundArr = [];
            break;
    }
    return soundArr;
  }

  getRandomNum(arr: any) {
    return Math.floor(Math.random() * arr.length);
  }

  async playSound(soundName: string, volume: number = 1.0): Promise<HTMLAudioElement> {
    const audioObj = this.sounds.find(sound => sound.name === soundName);
    const audioPath = audioObj?.path;
    if (audioPath) {
      const audio = new Audio(audioPath);
      audio.volume = volume;

      return new Promise((resolve, reject) => {
        audio.play().then(() => {
          this.currentAudio = audio;
          resolve(audio);
        }).catch((error) => {
          console.error('Error playing audio:', error);
          reject(error);
        });
      });
    } else {
      return Promise.reject(new Error('Audio path not found'));
    }
  }

  stopCurrentSound() {
    if (this.currentAudio) {
      this.currentAudio.pause();
      this.currentAudio.currentTime = 0;
      this.currentAudio = null;
    }
  }

  stopCurrentClassSound() {
    if (this.currentClassAudio) {
      this.currentClassAudio.pause();
      this.currentClassAudio.currentTime = 0;
      this.currentClassAudio = null;
    }
  }

  onInputClick(): void {
    if (!this.inputFocused) {
      if (this.soundManager.isSoundEnabled()) {

        this.playSound('confirm');
      }
    }
    this.inputFocused = true; // Set flag to true after the first click
  }

  onInputBlur(): void {
    this.inputFocused = false; // Reset flag when input loses focus
  }

  getRequiredExpForNextLevel(): number {
    const nextLevel = this.currentStats.level + 1;
    const nextLevelStats = this.currentClassData.classStats.find((stat: { level: any; }) => stat.level === nextLevel);
    return nextLevelStats ? nextLevelStats.requiredExp : 0;
  }

  calculateSP(combinedSkill: CombinedSkill, allSkills: any[]): number {
    const fullSkill = allSkills.find(skill => skill.skill.name === combinedSkill.name);
    if (!fullSkill) {
      return 0;
    }

    const skillPointsUpToRank = fullSkill.skill.skillDetails
      .filter((detail: { rank: number }) => detail.rank <= combinedSkill.rank)
      .reduce((acc: any, detail: { requiredSkillPoints: any; }) => acc + detail.requiredSkillPoints, 0);

    return skillPointsUpToRank;
  }

  resetSkills() {
    while(this.totalAvailableSP < 0) {
      this.skillsList.pop();
      this.updateTotalAvailableSP();
    }
    this.updateCurrentBuild();
  }

  sortByNameAsc(skills: any) {
    return [...skills].sort((a, b) => a.name.localeCompare(b.name));
  }

  sortByNameDesc(skills: any) {
    return [...skills].sort((a, b) => b.name.localeCompare(a.name));
  }

  sortBySPAsc(skills: CombinedSkill[], allSkills: Skill[]): CombinedSkill[] {
    const sorted = [...skills].sort((a, b) => {
      const spA = this.calculateSP(a, allSkills);
      const spB = this.calculateSP(b, allSkills);
      return spA - spB;
    });
    return sorted;
  }

  sortBySPDesc(skills: CombinedSkill[], allSkills: Skill[]): CombinedSkill[] {
    const sorted = [...skills].sort((a, b) => {
      const spA = this.calculateSP(a, allSkills);
      const spB = this.calculateSP(b, allSkills);
      return spB - spA;
    });
    return sorted;
  }

  toggleShowAll() {
    if(this.showAll) {
      this.showAll = false;
    }
    else {
      this.showAll = true;
    }
  }

  toggleDisplayOption(selectedOption: string) {
    // Reset all options to false
    this.showAll = false;
    this.showByNameAsc = false;
    this.showByNameDesc = false;
    this.showBySPAsc = false;
    this.showBySPDesc = false;

    // Set the selected option to true
    switch (selectedOption) {
      case 'all':
        this.showAll = true;
        this.currentBuild = this.originalBuild;
        break;
      case 'name_asc':
        this.showByNameAsc = true;
        this.currentBuild = this.skillsNameAsc;
        break;
      case 'name_desc':
        this.showByNameDesc = true;
        this.currentBuild = this.skillsNameDesc;
        break;
      case 'sp_asc':
        this.showBySPAsc = true;
        this.currentBuild = this.skillsBySPAsc;
        break;
      case 'sp_desc':
        this.showBySPDesc = true;
        this.currentBuild = this.skillsBySPDesc;
        break;
      default:
        this.showAll = true;
        break;
    }
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('confirm');
    }

  }

  captureAndDownloadScreenshot() {
    const element = document.querySelector('.meta-wrapper.build-background') as HTMLElement;
    if (element) {
      if (this.soundManager.isSoundEnabled()) {

        this.playSound('confirm');
      }
      html2canvas(element).then(canvas => {
        const link = document.createElement('a');
        link.download = `level-${this.currentStats.level}-${this.currentClassData.name.toLowerCase()}-build.png`;
        link.href = canvas.toDataURL();
        link.click();
        setTimeout(() => {
          this.stopCurrentSound();
          if (this.soundManager.isSoundEnabled()) {

            this.playSound('treasure', 0.5);
          }
        }, 100);
      });
    }
  }

  async captureAndDownloadScreenshotOfTemp() {
    // Create a temporary container for the screenshot
    const tempContainer = document.createElement('div');
    // Ensure the temporary container is not visible on the screen
    tempContainer.style.position = 'absolute';
    tempContainer.style.left = '-9999px';
    tempContainer.style.backgroundColor = '#000';
    document.body.appendChild(tempContainer);

    // Select the elements you want to capture
    const element1 = document.querySelector('div.col.n1.class-background') as HTMLElement;
    const element2 = document.querySelector('.meta-wrapper.build-background') as HTMLElement;

    // Style elements
    if(element1) element1.style.color = '#fff';
    if(element1) element1.style.width = '100%';
    const styles = window.getComputedStyle(element1);
    if(element2) element2.style.color = '#fff';

    // Clone the elements and append them to the temporary container
    if(element1) tempContainer.appendChild(element1.cloneNode(true));
    if(element2) tempContainer.appendChild(element2.cloneNode(true));

    // Use html2canvas to capture the temporary container
    const canvas = await html2canvas(tempContainer);

    // Create a link to download the captured image
    const link = document.createElement('a');
    link.download = `level-${this.currentStats.level}-${this.currentClassData.name.toLowerCase()}-build.png`;
    link.href = canvas.toDataURL();
    link.click();
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('treasure', 0.5);
    }

    // Clean up: remove the temporary container
    document.body.removeChild(tempContainer);
  }

  generateBuildDataAsText(): string {
    const buildText = this.currentBuild.map(skill =>
      `Name: ${skill.name}, Description: ${skill.description}, SP Spent: ${this.calculateSP(skill, this.currentClassData.skills)}, Rank: ${skill.rank}, Effects: ${skill.effects}`
    ).join('\n\n');

    return buildText;
  }

  async copyBuildToClipboard(): Promise<void> {
    try {
      const buildData = this.generateBuildDataAsText();
      await navigator.clipboard.writeText(buildData);
      if (this.soundManager.isSoundEnabled()) {

        this.playSound('rune');
      }
    } catch (err) {
      console.error('Failed to copy build data: ', err);
    }
  }

  exportBuildAsTextFile(): void {
    const buildData = this.generateBuildDataAsText();
    const blob = new Blob([buildData], { type: 'text/plain' });
    const link = document.createElement('a');
    link.download = `level-${this.currentStats.level}-${this.currentClassData.name.toLowerCase()}-build.txt`;
    link.href = URL.createObjectURL(blob);
    link.click();
    if (this.soundManager.isSoundEnabled()) {

      this.playSound('treasure', 0.5);
    }
  }

  @HostListener('window:scroll', ['$event'])
  handleScroll() {
    const windowScroll = window.scrollY;
    if (this.skillInfoBoard) {
      this.adjustChildrenPosition(windowScroll);
    }
  }

  adjustChildrenPosition(windowScroll: number) {
    const boardRect = this.skillInfoBoard.nativeElement.getBoundingClientRect();
    const boardTop = windowScroll + boardRect.top;
    const boardBottom = boardTop + this.skillInfoBoard.nativeElement.offsetHeight - 27;

    Array.from(this.skillInfoBoard.nativeElement.children).forEach((child: Element) => {
        const childElement = child as HTMLElement;
        let newPosition = windowScroll - boardTop + this.skillInfoBoard.nativeElement.clientTop; // Initial position based on top of skillInfoBoard

        // Ensure newPosition does not allow child to move beyond skillInfoBoard bottom
        const childBottomPosition = boardTop + newPosition + childElement.offsetHeight; // Position of the bottom of the child
        if (childBottomPosition > boardBottom) {
            newPosition -= (childBottomPosition - boardBottom); // Adjust position to keep child within skillInfoBoard
        }

        newPosition = Math.max(0, newPosition); // Ensure newPosition does not go above skillInfoBoard top

        childElement.style.transform = `translateY(${newPosition}px)`;
    });
  }

  findPlayerClassBySkill(skillId: number) {
    const currentSkillId = this.currentSkill.id;
    if (currentSkillId) {

    }
  }

  // toggleModal(): void {
  //   this.showModal = !this.showModal;
  //   if (this.showModal) {
  //     this.renderer.addClass(document.body.querySelector('.wrapper'), 'body-no-scroll');
  //   } else {
  //     this.renderer.removeClass(document.body.querySelector('.wrapper'), 'body-no-scroll');
  //   }
  // }

  toggleModal(): void {
    this.showModal = !this.showModal;
    if (this.showModal) {
      // Disable scroll when modal is open
      this.renderer.setStyle(document.body, 'overflow', 'hidden');
      // Listen for escape key to close modal
      this.listenerFn = this.renderer.listen('window', 'keydown', (event) => {
        if (event.key === 'Escape') {
          this.closeModal();
        }
      });
      if (this.soundManager.isSoundEnabled()) {
        this.playSound('confirm');
      }
      this.triggerIntro();
    } else {
      this.closeModal();
    }
  }

  closeModal(): void {
    this.showModal = false;
    this.renderer.setStyle(document.body, 'overflow', 'auto'); // Re-enable scroll when modal is closed
    if (this.listenerFn) {
      this.listenerFn(); // Remove event listener when modal is closed
      this.listenerFn = null;
    }
    if (!this.showModal && this.sampleVoiceComponent) {
      this.sampleVoiceComponent.stopAudio();
    }
    if (this.soundManager.isSoundEnabled()) {
      this.playSound('confirm');
    }
  }

  triggerIntro() {
    const modalVideo = document.querySelector('.modal-video video') as HTMLVideoElement | null;
    if (modalVideo) {
      modalVideo.play()
        .catch(error => console.error('Error trying to play the video:', error));
    } else {
      console.error('Video element not found!');
    }
  }

  async enableSkillCardView() {
    if (this.soundManager.isSoundEnabled()) {
      await this.playSound('confirm', 0.5);
    }
    this.viewSkillCard = !this.viewSkillCard;
  }

  async openSnackbar(message: string, action: string, currentClassData?: any) {
    if (this.soundManager.isSoundEnabled()) {

      await this.playSound('rune', 1);
    }
    this.snackbarService.openSnackbar(message, action, this.currentClassData.name.toLowerCase());
  }
}
