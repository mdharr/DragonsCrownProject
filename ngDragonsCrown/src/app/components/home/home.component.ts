import { AudioEntity } from './../../models/audio-entity';
import { SkillDetails } from './../../models/skill-details';
import { PlayerClassService } from './../../services/player-class.service';
import { AuthService } from './../../services/auth.service';
import { AfterViewInit, Component, ElementRef, inject, OnDestroy, OnInit, QueryList, Renderer2, ViewChild, ViewChildren } from '@angular/core';
import { PlayerClass } from 'src/app/models/player-class';
import { Subscription } from 'rxjs';
import { Skill } from 'src/app/models/skill';
import { Quest } from 'src/app/models/quest';
import { ImageEntity } from 'src/app/models/image-entity';
import { PreloadService } from 'src/app/services/preload.service';
import { CombinedSkill } from 'src/app/models/combined-skill';
import { ClassName } from 'src/app/types/class-name.type';

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
      minUrl: 'https://live.staticflickr.com/65535/53572893684_541cc6b34d_k.jpg',
      maxUrl: 'https://live.staticflickr.com/65535/53572893684_541cc6b34d_k.jpg',
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

  // booleans
  classSelected: boolean = false;
  currentClassData: any = null;
  selectedClassIndex: number | null = null;
  selected: boolean = false;
  artworkLoaded: boolean = false;
  showCommonSkills: boolean = true;
  skillSelected: boolean = false;
  currentSkillEffects: string[] = [];
  skillCardLoaded: boolean = false;
  playerCardLoaded: boolean = false;
  isModalVisible = false;
  viewQuests: boolean = false;
  viewBuild: boolean = false;
  showAll: boolean = false;
  showByNameAsc: boolean = false;
  showByNameDesc: boolean = false;
  showBySPAsc: boolean = false;
  showBySPDesc: boolean = false;

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
  ]

  // subscriptions
  private playerClassSubscription: Subscription | undefined;

  // dependencies
  auth = inject(AuthService);
  playerClassService = inject(PlayerClassService);
  renderer = inject(Renderer2);
  preloadService = inject(PreloadService);

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
    this.currentLevelSP = 1;

    if(this.classSelected) {
      this.selected = true;
      if (!this.currentClassData || this.currentClassData.name !== this.playerClasses[classIndex].name) {
        this.playSound('accept');
        setTimeout(() => {
          this.playClassAudio(this.currentClassData.name.toLowerCase());
        }, 200);
      }
      this.selectedClassIndex = classIndex;
      this.currentClassData = this.playerClasses[classIndex];
      // console.log("CURRENT CLASS DATA: ", this.currentClassData);

      this.currentStats = { ...this.currentClassData.classStats[0] };
      this.resetLevel();

      try {
        await this.preloadImage(this.currentClassData.cardUrl);
        this.playerCardLoaded = true;
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
      // Trigger the blur event manually
      let element = event.target as HTMLElement;
      element.blur();
    }
  }

  onLevelChange(): void {
    const enteredLevel = Number(this.currentStats.level);
    this.updateLevel(enteredLevel);
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
    if(this.showCommonSkills === false || this.showCommonSkills === true) {
      this.viewQuests = false;
      this.viewBuild = false;
      this.showCommonSkills = true;
      const commonBtn = document.querySelector('#common-btn');
      const uniqueBtn = document.querySelector('#unique-btn');
      uniqueBtn?.classList.remove('selected-skills');
      commonBtn?.classList.add('selected-skills');
      this.playSound('accept');
    }
  }

  viewUniqueSkills() {
    if(this.showCommonSkills === true || this.showCommonSkills === false) {
      this.viewQuests = false;
      this.viewBuild = false;
      this.showCommonSkills = false;
      const commonBtn = document.querySelector('#common-btn');
      const uniqueBtn = document.querySelector('#unique-btn');
      commonBtn?.classList.remove('selected-skills');
      uniqueBtn?.classList.add('selected-skills');
      this.playSound('accept');
    }
  }

  viewQuestList() {
    this.viewQuests = true;
    this.viewBuild = false;
    this.playSound('accept');
  }

  viewCurrentBuild() {
    this.viewBuild = true;
    this.viewQuests = false;
    this.playSound('accept');
  }

  async selectSkill(skillIndex: number, skillType: 'common' | 'unique'): Promise<void> {
    if (this.selectedSkill && this.selectedSkill.index === skillIndex && this.selectedSkill.type === skillType) {
      // console.log("This skill is already selected.");
    } else {
      this.selectedSkill = { index: skillIndex, type: skillType };
      // console.log(this.selectedSkill);
      this.skillSelected = true;
      this.skillCardLoaded = false;
      this.toggleGlassEffect();
      this.playSound('pageflip');

      const skill = skillType === 'common' ? this.commonSkills[skillIndex] : this.uniqueSkills[skillIndex];
      this.currentSkill = skill;

      try {
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
    this.playSound('coinbag');
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
    this.playSound('coinbag');
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
    this.skillsNameAsc = this.sortByNameAsc(this.currentBuild);
    this.skillsNameDesc = this.sortByNameDesc(this.currentBuild);
    this.skillsBySPAsc = this.sortBySPAsc(this.currentBuild, this.currentClassData.skills);
    this.skillsBySPDesc = this.sortBySPDesc(this.currentBuild, this.currentClassData.skills);
  }

  // playClassAudio(className: string) {
  //   if (this.previousClassVoice !== className) {
  //     this.previousClassVoice = className;
  //     // Validate that className is a valid key
  //     if (className in this.audioPaths) {
  //       const audioPath = this.audioPaths[className as ClassName];
  //       const audio = new Audio(audioPath);
  //       audio.play();
  //     } else {
  //       console.error('Invalid class name:', className);
  //     }
  //   }
  // }

  playClassAudio(className: string) {
    if (this.previousClassVoice !== className) {
      this.previousClassVoice = className;

      const targetClass = this.sounds.find(sound => sound.name === className);
      if (targetClass) {
        this.playSound(targetClass.name);
      } else {
        console.error('Invalid class name:', className);
      }
    }
  }

  playSound(soundName: string) {
    const audioObj = this.sounds.find(sound => sound.name === soundName);
    const audioPath = audioObj?.path;
    const audio = new Audio(audioPath);
    audio.play();
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

}
