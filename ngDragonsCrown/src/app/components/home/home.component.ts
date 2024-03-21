import { AudioEntity } from './../../models/audio-entity';
import { SkillDetails } from './../../models/skill-details';
import { PlayerClassService } from './../../services/player-class.service';
import { AuthService } from './../../services/auth.service';
import { AfterViewInit, Component, ElementRef, HostListener, inject, NgZone, OnDestroy, OnInit, QueryList, Renderer2, ViewChild, ViewChildren } from '@angular/core';
import { PlayerClass } from 'src/app/models/player-class';
import { Subscription } from 'rxjs';
import { Skill } from 'src/app/models/skill';
import { Quest } from 'src/app/models/quest';
import { ImageEntity } from 'src/app/models/image-entity';
import { PreloadService } from 'src/app/services/preload.service';
import { CombinedSkill } from 'src/app/models/combined-skill';
import { ClassName } from 'src/app/types/class-name.type';
import html2canvas from 'html2canvas';
import { Router, RouterLink } from '@angular/router';
import { VideoEntity } from 'src/app/models/video-entity';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
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

  // app state
  buildToShare: any;
  encodedData: any;

  // image assets to preload
  images: ImageEntity[] = [
    {
      name: 'red_bg',
      minUrl: 'https://live.staticflickr.com/65535/53569475467_2d136f39b1_k.jpg',
      maxUrl: 'https://dragonscrown.s3.amazonaws.com/DragonsCrownPatterns/bg_pattern.png',
      isLoaded: false,
    },
    {
      name: 'build_bg',
      // minUrl: 'https://live.staticflickr.com/65535/53572893684_541cc6b34d_k.jpg',
      // maxUrl: 'https://live.staticflickr.com/65535/53572893684_541cc6b34d_k.jpg',
      minUrl: 'https://live.staticflickr.com/65535/53593069654_0b983c5af3_k.jpg',
      maxUrl: 'https://live.staticflickr.com/65535/53593069654_0b983c5af3_k.jpg',
      isLoaded: false,
    },
    {
      name: 'castle_bg',
      minUrl: 'https://live.staticflickr.com/65535/53570769145_4230a9f7f7_k.jpg',
      maxUrl: 'https://live.staticflickr.com/65535/53570755564_eb3a3d67b6_k.jpg',
      isLoaded: false,
    },
    {
      name: 'character_bg',
      minUrl: 'https://live.staticflickr.com/65535/53570769120_a9e153d0c8_k.jpg',
      maxUrl: 'https://live.staticflickr.com/65535/53560863818_20e5c2da14_k.jpg',
      isLoaded: false,
    },
  ];

  // observed elements
  @ViewChildren('observedElement') observedElements!: QueryList<ElementRef>;
  @ViewChild('sheenBox', { static: false }) sheenBoxRef: ElementRef | undefined;
  @ViewChild('skillInfoBoard', { static: false }) skillInfoBoard!: ElementRef<HTMLDivElement>;

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

  // tooltip
  tooltipVisible: boolean = false;
  tooltipUrl: string = '';
  tooltipIndex: number | null = null;
  tooltipTop: number = 0;
  tooltipLeft: number = 0;
  tooltipPosition = { top: 0, left: 0 };

  // typewriter
  currentTimeoutId: number | null = null;
  introText: string = "Embark on an epic journey across Hydeland, a land steeped in mystery and danger, in pursuit of the legendary Dragon's Crown. With this arcane tool at your disposal, you have the power to meticulously craft your adventurer, choosing your path with care and strategy. Fine-tune your character's stats, carefully plan out your skills, and share your hero's build with companions and fellow seekers of the crown.";

  // audio
  currentAudio: HTMLAudioElement | null = null;
  currentClassAudio: HTMLAudioElement | null = null;
  private audioPaths: Record<ClassName, string> = {
    amazon: '/assets/audio/amazon_select.mp3',
    dwarf: '/assets/audio/dwarf_select.mp3',
    elf: '/assets/audio/elf_select.mp3',
    fighter: '/assets/audio/fighter_select.mp3',
    sorceress: '/assets/audio/sorceress_select.mp3',
    wizard: '/assets/audio/wizard_select.mp3',
  };

  sounds: AudioEntity[] = [
    { name: 'fighter', path: '/assets/audio/fighter_select.mp3' },
    { name: 'amazon', path: '/assets/audio/amazon_select.mp3' },
    { name: 'elf', path: '/assets/audio/elf_select.mp3' },
    { name: 'dwarf', path: '/assets/audio/dwarf_select.mp3' },
    { name: 'sorceress', path: '/assets/audio/sorceress_select.mp3' },
    { name: 'wizard', path: '/assets/audio/wizard_select.mp3' },
    { name: 'coinbag', path: '/assets/audio/coinbag_1.wav' },
    { name: 'accept', path: '/assets/audio/dc_accept_se.mp3' },
    { name: 'coinflip', path: '/assets/audio/dc_coinflip_se.mp3' },
    { name: 'confirm', path: '/assets/audio/dc_confirm_se.mp3' },
    { name: 'erase', path: '/assets/audio/dc_erase_se.mp3' },
    { name: 'rune',  path: '/assets/audio/dc_rune_se.mp3' },
    { name: 'scratch', path: '/assets/audio/dc_scratch_se.mp3' },
    { name: 'tick', path: '/assets/audio/dc_tick_se.mp3' },
    { name: 'ticks', path: '/assets/audio/dc_ticks_se.mp3' },
    { name: 'unlock', path: '/assets/audio/dc_unlock_se.mp3' },
    { name: 'pageflip', path: '/assets/audio/dc_pageflip_se.mp3' },
    { name: 'treasure', path: '/assets/audio/dc_treasure_se.mp3' },
    { name: 'blip', path: '/assets/audio/dc_blip_se.mp3' },
    { name: 'dialogue', path: '/assets/audio/dc_dialogue_se.mp3' },
  ];

  videos: VideoEntity[] = [
    { name: 'fighter', path: '/assets/graphics/media/fighter_compressed.mp4' },
    { name: 'amazon', path: '/assets/graphics/media/amazon_compressed.mp4' },
    { name: 'elf', path: '/assets/graphics/media/elf_compressed.mp4' },
    { name: 'dwarf', path: '/assets/graphics/media/dwarf_compressed.mp4' },
    { name: 'sorceress', path: '/assets/graphics/media/sorceress_compressed.mp4' },
    { name: 'wizard', path: '/assets/graphics/media/wizard_compressed.mp4' },
  ];

  fighterSounds: AudioEntity[] = [
    { name: 'fighter1', path: '/assets/audio/select/fighter_select1.mp3' },
    { name: 'fighter2', path: '/assets/audio/select/fighter_select2.mp3' },
    { name: 'fighter3', path: '/assets/audio/select/fighter_select3.mp3' },
    { name: 'fighter4', path: '/assets/audio/select/fighter_select4.mp3' },
    { name: 'fighter5', path: '/assets/audio/select/fighter_select5.mp3' },
    { name: 'fighter6', path: '/assets/audio/select/fighter_select6.mp3' },
  ];

  amazonSounds: AudioEntity[] = [
    { name: 'amazon1', path: '/assets/audio/select/amazon_select1.mp3' },
    { name: 'amazon2', path: '/assets/audio/select/amazon_select2.mp3' },
    { name: 'amazon3', path: '/assets/audio/select/amazon_select3.mp3' },
    { name: 'amazon4', path: '/assets/audio/select/amazon_select4.mp3' },
    { name: 'amazon5', path: '/assets/audio/select/amazon_select5.mp3' },
  ];

  elfSounds: AudioEntity[] = [
    { name: 'elf1', path: '/assets/audio/select/elf_select1.mp3' },
    { name: 'elf2', path: '/assets/audio/select/elf_select2.mp3' },
    { name: 'elf3', path: '/assets/audio/select/elf_select3.mp3' },
    { name: 'elf4', path: '/assets/audio/select/elf_select4.mp3' },
    { name: 'elf5', path: '/assets/audio/select/elf_select5.mp3' },
    { name: 'elf6', path: '/assets/audio/select/elf_select6.mp3' },
  ];

  dwarfSounds: AudioEntity[] = [
    { name: 'dwarf1', path: '/assets/audio/select/dwarf_select1.mp3' },
    { name: 'dwarf2', path: '/assets/audio/select/dwarf_select2.mp3' },
    { name: 'dwarf3', path: '/assets/audio/select/dwarf_select3.mp3' },
    { name: 'dwarf4', path: '/assets/audio/select/dwarf_select4.mp3' },
    { name: 'dwarf5', path: '/assets/audio/select/dwarf_select5.mp3' },
    { name: 'dwarf6', path: '/assets/audio/select/dwarf_select6.mp3' },
  ];

  wizardSounds: AudioEntity[] = [
    { name: 'wizard1', path: '/assets/audio/select/wizard_select1.mp3' },
    { name: 'wizard2', path: '/assets/audio/select/wizard_select2.mp3' },
    { name: 'wizard3', path: '/assets/audio/select/wizard_select3.mp3' },
    { name: 'wizard4', path: '/assets/audio/select/wizard_select4.mp3' },
    { name: 'wizard5', path: '/assets/audio/select/wizard_select5.mp3' },
    { name: 'wizard6', path: '/assets/audio/select/wizard_select6.mp3' },
    { name: 'wizard7', path: '/assets/audio/select/wizard_select7.mp3' },
  ];

  sorceressSounds: AudioEntity[] = [
    { name: 'sorceress1', path: '/assets/audio/select/sorceress_select1.mp3' },
    { name: 'sorceress2', path: '/assets/audio/select/sorceress_select2.mp3' },
    { name: 'sorceress3', path: '/assets/audio/select/sorceress_select3.mp3' },
    { name: 'sorceress4', path: '/assets/audio/select/sorceress_select4.mp3' },
    { name: 'sorceress5', path: '/assets/audio/select/sorceress_select5.mp3' },
    { name: 'sorceress6', path: '/assets/audio/select/sorceress_select6.mp3' },
  ];

  // subscriptions
  private playerClassSubscription: Subscription | undefined;

  // dependencies
  auth = inject(AuthService);
  playerClassService = inject(PlayerClassService);
  renderer = inject(Renderer2);
  preloadService = inject(PreloadService);
  ngZone = inject(NgZone);
  router = inject(Router);

  ngOnInit() {
    this.resetWindowPosition();
    this.subscribeToPlayerClassData();
    this.preloadImageEntities();
    // this.typeOutText(this.introText, 'introduction-text');
  }

  ngOnDestroy() {
    if(this.playerClassSubscription) {
      this.playerClassSubscription.unsubscribe();
    }
  }

  ngAfterViewInit(): void {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('fadeIn');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.1 });

    this.observedElements.forEach(element => {
      observer.observe(element.nativeElement);
    });
  }

  subscribeToPlayerClassData() {
    this.playerClassSubscription = this.playerClassService.indexAll().subscribe({
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

  preloadImageEntities() {
    this.images.forEach((image) => {
      this.preloadService.preloadImage(image.maxUrl).subscribe({
        next: (url) => {
          if (url === image.maxUrl) {
            image.isLoaded = true;
            // Update the UI or trigger changes as needed
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
    const ul = document.querySelector('#portraits-ul');
    if(ul) {
      Array.from(ul.childNodes).forEach(child => {
        const element = child as HTMLElement;
        element.style.opacity = '0.5';
        element.style.filter = 'drop-shadow(2px 4px 4px rgba(0, 0, 0, 0.5))';
      })
    }
  }

  selectPortrait(elementId: string) {
    const element = document.querySelector(`#${elementId}`) as HTMLElement;
    element.style.opacity = '1';
    element.style.filter = 'filter: drop-shadow(2px 4px 10px rgba(0, 0, 0, 0.5)) brightness(1.1)';
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

    if(this.classSelected) {
      this.selected = true;
      if (!this.currentClassData || this.currentClassData.name !== this.playerClasses[classIndex].name) {
        this.playSound('accept', 0.5);
        setTimeout(() => {
          this.stopCurrentClassSound();
          // this.playClassAudio(this.currentClassData.name.toLowerCase());
          this.findClassAudio(this.currentClassData.name.toLowerCase());
        }, 200);
      }
      this.selectedClassIndex = classIndex;
      this.currentClassData = this.playerClasses[classIndex];

      this.currentStats = { ...this.currentClassData.classStats[0] };
      this.resetLevel();

      try {
        await this.preloadImage(this.currentClassData.cardUrl);
        this.playerCardLoaded = true;
        this.loading = false;
      } catch (error) {
        console.error('Image loading failed', error);
      }

      // Reset quests and skill points from quests
      this.resetQuestsAndSkillPoints();

      this.commonSkills = this.currentClassData.skills
        .filter((skillObj: { skill: { common: boolean; }; }) => skillObj.skill.common === true)
        .map((skillObj: { skill: any; }) => skillObj.skill);

      this.uniqueSkills = this.currentClassData.skills
        .filter((skillObj: { skill: { common: boolean; }; }) => skillObj.skill.common === false)
        .map((skillObj: { skill: any }) => skillObj.skill);

      this.quests = this.currentClassData.quests.map((questObj: { quest: any }) => questObj.quest);

      this.showCommonSkills = true;
      this.currentSpriteUrl = this.currentClassData?.spriteStartUrl;

    }
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
    this.playSound('confirm');
  }

  levelDown(): void {
    if (!this.currentStats || this.currentStats.level <= 1) {
      console.error('Current stats not defined or already at minimum level');
      return;
    }
    const newLevel = Number(this.currentStats.level) - 1;
    this.updateLevel(newLevel);
    this.playSound('confirm');
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
      this.playSound('erase');
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
    this.playSound('confirm');
  }

  // async typeOutText(input: string, elementId: string): Promise<void> {
  //   const element = document.getElementById(elementId) as HTMLParagraphElement;
  //   if (!element) {
  //       console.error('Element not found');
  //       return;
  //   }

  //   element.textContent = '';

  //   if (this.currentTimeoutId !== null) {
  //       clearTimeout(this.currentTimeoutId);
  //       this.currentTimeoutId = null;
  //   }

  //   for (let i = 0; i < input.length; i++) {
  //       if (this.currentTimeoutId === null && i !== 0) {
  //           return;
  //       }

  //       await new Promise<void>((resolve) => {
  //           this.currentTimeoutId = window.setTimeout(() => {
  //               element.textContent += input[i];
  //               resolve();
  //           }, 10);
  //       });
  //   }

  //   this.currentTimeoutId = null;
  // }

  showTooltip(event: MouseEvent, gifUrl: string, index: number): void {
    const element = event.currentTarget as HTMLElement;
    const rect = element.getBoundingClientRect();

    this.tooltipVisible = true;
    this.tooltipUrl = gifUrl;
    this.tooltipIndex = index;
    this.tooltipTop = rect.top + window.scrollY - element.offsetHeight;
    this.tooltipLeft = rect.left + window.scrollX;
  }

  hideTooltip(): void {
    this.tooltipVisible = false;
    this.tooltipUrl = '';
    this.tooltipIndex = null;
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
    // const commonBtn = document.querySelector('#common-btn');
    // const uniqueBtn = document.querySelector('#unique-btn');
    // uniqueBtn?.classList.remove('selected-skills');
    // commonBtn?.classList.add('selected-skills');
    this.playSound('accept', 0.5);
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
    this.playSound('accept', 0.5);
  }

  viewQuestList() {
    this.viewQuests = true;
    this.viewBuild = false;
    this.viewRunes = false;
    this.showCommonSkills = false;
    this.showUniqueSkills = false;
    this.playSound('accept', 0.5);
  }

  viewCurrentBuild() {
    this.viewBuild = true;
    this.viewQuests = false;
    this.viewRunes = false;
    this.showCommonSkills = false;
    this.showUniqueSkills = false;
    this.playSound('accept', 0.5);
  }

  viewRunesMatcher() {
    this.viewRunes = true;
    this.viewBuild = false;
    this.viewQuests = false;
    this.showCommonSkills = false;
    this.showUniqueSkills = false;
    this.playSound('accept', 0.5);
  }

  async selectSkill(skillIndex: number, skillType: 'common' | 'unique'): Promise<void> {
    if (this.selectedSkill && this.selectedSkill.index === skillIndex && this.selectedSkill.type === skillType) {
      // console.log("This skill is already selected.");
    } else {
      this.selectedSkill = { index: skillIndex, type: skillType };
      // console.log(this.selectedSkill);
      this.skillSelected = true;
      this.skillCardLoaded = false;
      this.isSkillInfoVisible = false;
      this.toggleGlassEffect();
      this.stopCurrentSound();
      this.playSound('pageflip');

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
    this.playSound('coinbag', 0.5);
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
    this.playSound('coinbag', 0.5);
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

    // Then, add all ranks up to and including the selected rank
    skill.skillDetails.forEach(skillDetail => {
      if (skillDetail.rank <= selectedSkillDetail.rank) {
        this.addSkillDetailToList(skill, skillDetail);
      }
    });
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
    };

    this.skillsList.push(skillToAdd);
    this.updateCurrentBuild();
  }

  removeFromSkillsList(skill: Skill, selectedSkillDetail: SkillDetails): void {
    this.skillsList = this.skillsList.filter(item =>
      !(item.skillId === skill.id && item.rank >= selectedSkillDetail.rank)
    );
    this.updateTotalAvailableSP();
    this.updateCurrentBuild();
    this.stopCurrentSound();
    this.playSound('erase');
  }

  handleSkillClick(skill: Skill, skillDetail: SkillDetails): void {
    // Check if the selected rank is already selected
    const isAlreadySelected = this.isSkillDetailSelected(skill, skillDetail);

    if (isAlreadySelected) {
        // If the selected rank is already selected, remove it and all higher ranks
        this.removeFromSkillsList(skill, skillDetail);
    } else {
        // First, find out the total SP required to add this rank and all previous unselected ranks
        const requiredSPToAdd = skill.skillDetails
            .filter(detail => detail.rank <= skillDetail.rank && !this.isSkillDetailSelected(skill, detail))
            .reduce((total, detail) => total + detail.requiredSkillPoints, 0);

        // Check if we have enough SP to add the skill and its unselected previous ranks
        if (requiredSPToAdd <= this.totalAvailableSP) {
            // If so, add all ranks up to and including the selected rank that haven't been selected yet
            skill.skillDetails.forEach(detail => {
                if (detail.rank <= skillDetail.rank && !this.isSkillDetailSelected(skill, detail)) {
                    this.addSkillDetailToList(skill, detail);
                }
            });
        } else {
            alert("Not enough skill points available.");
            return;
        }
        this.stopCurrentSound();
        this.playSound('confirm');
    }
    // Update total available SP after any changes
    this.updateTotalAvailableSP();
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

  removeSkillsByName(skillName: string, event: MouseEvent): void {
    event.stopPropagation(); // Prevent event from triggering parent click events

    if (this.skillsList.some(skill => skill.name === skillName)) {
      this.playSound('scratch');
    }

    this.skillsList = this.skillsList.filter(skill => skill.name !== skillName);
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
        console.log(this.buildToShare);
    });

    this.skillsNameAsc = this.sortByNameAsc(this.currentBuild);
    this.skillsNameDesc = this.sortByNameDesc(this.currentBuild);
    this.skillsBySPAsc = this.sortBySPAsc(this.currentBuild, this.currentClassData.skills);
    this.skillsBySPDesc = this.sortBySPDesc(this.currentBuild, this.currentClassData.skills);
  }

  encodeBuild(buildData: any): string {
    const jsonBuild = JSON.stringify(buildData);
    return encodeURIComponent(jsonBuild);
  }

  generateShareLinkAsText(): string {
    if (this.encodedData === null) {
      return ''; // Return empty string if data is not encoded
    }
    return `http://localhost:4305/#/build?encodedBuild=${this.encodedData}`;
  }

  async copyShareLinkToClipboard(): Promise<void> {
    const shareLink = this.generateShareLinkAsText();
    if (shareLink === '') {
      console.error('Share link is not generated.');
      return;
    }

    try {
      await navigator.clipboard.writeText(shareLink);
      console.log('Share link copied to clipboard:', shareLink);
    } catch (err) {
      console.error('Failed to copy share link: ', err);
    }
  }

  generateAndCopyShareLink(): void {
    this.playSound('rune', 0.5);
    this.encodedData = this.encodeBuild(this.buildToShare);
    this.copyShareLinkToClipboard();
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
    return Math.floor(Math.random() * arr.length) + 1;
  }

  findClassAudio(className: string) {
    if (this.previousClassVoice !== className) {
      this.previousClassVoice = className;
      const audioEntityArr = this.getClassAudioEntity(className);
      const randomIndex = this.getRandomNum(audioEntityArr);
      const targetClassSound = audioEntityArr.find((sound) => sound.name === (className + randomIndex));
      console.log(targetClassSound);
      if (targetClassSound) {
        this.currentClassAudio = this.playSoundForClass(targetClassSound.name, audioEntityArr, 0.3);
      } else {
        console.error('Invalid class name:', className);
      }
    }
  }

  playSoundForClass(soundName: string, audioEntity: AudioEntity[], volume: number = 1.0): HTMLAudioElement | null {
    const audioObj = audioEntity.find(sound => sound.name === soundName);
    const audioPath = audioObj?.path;
    if (audioPath) {
      const audio = new Audio(audioPath);
      audio.volume = volume;
      audio.play();
      this.currentAudio = audio;
      return audio;
    }
    return null;
  }

  // playClassAudio(className: string) {
  //   if (this.previousClassVoice !== className) {
  //     this.previousClassVoice = className;

  //     const targetClass = this.sounds.find(sound => sound.name === className);
  //     if (targetClass) {
  //       this.currentClassAudio = this.playSound(targetClass.name, 0.3);
  //     } else {
  //       console.error('Invalid class name:', className);
  //     }
  //   }
  // }

  getVideoPath(className: string): string | undefined {
    const video = this.videos.find(v => v.name.toLowerCase() === className.toLowerCase());
    return video ? video.path : undefined;
  }

  playSound(soundName: string, volume: number = 1.0): HTMLAudioElement | null {
    const audioObj = this.sounds.find(sound => sound.name === soundName);
    const audioPath = audioObj?.path;
    if (audioPath) {
      const audio = new Audio(audioPath);
      audio.volume = volume;
      audio.play();
      this.currentAudio = audio;
      return audio;
    }
    return null;
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
      this.playSound('confirm');
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
    this.playSound('confirm');
    // Log the current state for debugging
    // console.log({
    //   'showAll': this.showAll,
    //   'showByNameAsc': this.showByNameAsc,
    //   'showByNameDesc': this.showByNameDesc,
    //   'showBySPAsc': this.showBySPAsc,
    //   'showBySPDesc': this.showBySPDesc,
    // });
  }

  captureAndDownloadScreenshot() {
    const element = document.querySelector('.meta-wrapper.build-background') as HTMLElement;
    if (element) {
      this.playSound('confirm');
      html2canvas(element).then(canvas => {
        const link = document.createElement('a');
        link.download = `level-${this.currentStats.level}-${this.currentClassData.name.toLowerCase()}-build.png`;
        link.href = canvas.toDataURL();
        link.click();
        setTimeout(() => {
          this.stopCurrentSound();
          this.playSound('treasure', 0.5);
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
    // console.log(element1.style)
    const styles = window.getComputedStyle(element1);
    console.log(styles);
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
    this.playSound('treasure', 0.5);

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
      this.playSound('rune');
      console.log('Build data copied to clipboard.');
    } catch (err) {
      console.error('Failed to copy build data: ', err);
    }
  }

  // generateShareLinkAsText(): string {
  //   const shareLink = `http://localhost:4305/#/build?encodedBuild=${this.encodedData}`;
  //   return shareLink;
  // }

  // async copyShareLinkToClipboard(): Promise<void> {
  //   try {
  //     const shareLink = this.generateShareLinkAsText();
  //     await navigator.clipboard.writeText(shareLink);
  //     this.playSound('rune');
  //     console.log('Share link copied to clipboard:', shareLink);
  //   } catch (err) {
  //     console.error('Failed to copy share link: ', err);
  //   }
  // }

  exportBuildAsTextFile(): void {
    const buildData = this.generateBuildDataAsText();
    const blob = new Blob([buildData], { type: 'text/plain' });
    const link = document.createElement('a');
    link.download = `level-${this.currentStats.level}-${this.currentClassData.name.toLowerCase()}-build.txt`;
    link.href = URL.createObjectURL(blob);
    link.click();
    this.playSound('treasure', 0.5);
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

}
