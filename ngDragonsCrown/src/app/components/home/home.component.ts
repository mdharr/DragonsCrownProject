import { SkillDetails } from './../../models/skill-details';
import { PlayerClassService } from './../../services/player-class.service';
import { AuthService } from './../../services/auth.service';
import { AfterViewInit, Component, ElementRef, inject, OnDestroy, OnInit, QueryList, Renderer2, ViewChild, ViewChildren } from '@angular/core';
import { PlayerClass } from 'src/app/models/player-class';
import { Subscription } from 'rxjs';
import { Skill } from 'src/app/models/skill';
import { Quest } from 'src/app/models/quest';

interface CombinedSkill {
  skillId: number;
  name: string;
  description: string;
  cardImageUrl: string;
  isCommon: boolean;
  rankDetailId: number;
  rank: number;
  requiredSkillPoints: number;
  similarSkillLevel: number;
  requiredPlayerLevel: number;
  effects: string;
}

// player class types
type ClassName = 'amazon' | 'dwarf' | 'elf' | 'fighter' | 'sorceress' | 'wizard';

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
  previousClassVoice: string = '';

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

  // tooltip
  tooltipVisible: boolean = false;
  tooltipUrl: string = '';
  tooltipIndex: number | null = null;
  tooltipTop: number = 0;
  tooltipLeft: number = 0;
  tooltipPosition = { top: 0, left: 0 };

  // typewriter
  currentTimeoutId: number | null = null;

  // audio
  private audioPaths: Record<ClassName, string> = {
    amazon: '/assets/audio/amazon_select.mp3',
    dwarf: '/assets/audio/dwarf_select.mp3',
    elf: '/assets/audio/elf_select.mp3',
    fighter: '/assets/audio/fighter_select.mp3',
    sorceress: '/assets/audio/sorceress_select.mp3',
    wizard: '/assets/audio/wizard_select.mp3',
  };

  // subscriptions
  private playerClassSubscription: Subscription | undefined;

  // dependencies
  auth = inject(AuthService);
  playerClassService = inject(PlayerClassService);
  renderer = inject(Renderer2);

  ngOnInit() {
    this.resetWindowPosition();
    this.subscribeToPlayerClassData();
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

      this.selectedClassIndex = classIndex;
      this.currentClassData = this.playerClasses[classIndex];


      this.currentStats = { ...this.currentClassData.classStats[0] };
      console.log("Level: " + this.currentStats.level);
      // this.updateSkillPoints();
      // this.currentStats.level = 1;
      this.updateTotalAvailableSP();

      try {
        await this.preloadImage(this.currentClassData.cardUrl);
        this.playerCardLoaded = true;
      } catch (error) {
        console.error('Image loading failed', error);
      }

      this.commonSkills = this.currentClassData.skills
        .filter((skillObj: { skill: { common: boolean; }; }) => skillObj.skill.common === true)
        .map((skillObj: { skill: any; }) => skillObj.skill);

      this.uniqueSkills = this.currentClassData.skills
        .filter((skillObj: { skill: { common: boolean; }; }) => skillObj.skill.common === false)
        .map((skillObj: { skill: any }) => skillObj.skill);

      this.quests = this.currentClassData.quests.map((questObj: { quest: any }) => questObj.quest);

      this.showCommonSkills = true;

      this.currentSpriteUrl = this.currentClassData?.spriteStartUrl;

      this.playClassAudio(this.currentClassData.name.toLowerCase());
      // this.typeOutText(this.currentClassData.description, 'description-text');
    }
  }

  onArtworkLoad() {
    console.log('High-quality image loaded');
    this.artworkLoaded = true;
  }

  levelUp(): void {
    if (!this.currentStats) {
      console.error('Current stats not defined');
      return;
    }
    const newLevel = Number(this.currentStats.level) + 1;
    this.updateLevel(newLevel);
  }

  levelDown(): void {
    if (!this.currentStats || this.currentStats.level <= 1) {
      console.error('Current stats not defined or already at minimum level');
      return;
    }
    const newLevel = Number(this.currentStats.level) - 1;
    this.updateLevel(newLevel);
  }

  resetLevel() {
    this.skillsList = [];
    this.updateLevel(1);
    this.currentLevelSP = this.initialTotalSP;
    this.updateTotalAvailableSP();
    this.updateCurrentBuild();
  }

  updateLevel(newLevel: number): void {
    const validLevel = Math.max(1, Math.min(newLevel, 99));
    const stats = this.currentClassData.classStats.find((stat: { level: number; }) => stat.level === validLevel);
    if (stats) {
        this.currentStats = { ...stats };
        // Assuming stats at each level includes the cumulative skill points up to that level
        // and you want to track additional skill points gained after level 1
        this.currentLevelSP = stats.skillPoints;
        this.updateTotalAvailableSP();
        this.calculateTotalExperience();
    } else {
        console.error('Stats for level', validLevel, 'not found');
    }
  }

  onLevelChange(): void {
    const enteredLevel = Number(this.currentStats.level);
    this.updateLevel(enteredLevel);
  }

  async typeOutText(input: string, elementId: string): Promise<void> {
    const element = document.getElementById(elementId) as HTMLParagraphElement;
    if (!element) {
        console.error('Element not found');
        return;
    }

    element.textContent = '';

    if (this.currentTimeoutId !== null) {
        clearTimeout(this.currentTimeoutId);
        this.currentTimeoutId = null;
    }

    for (let i = 0; i < input.length; i++) {
        if (this.currentTimeoutId === null && i !== 0) {
            return;
        }

        await new Promise<void>((resolve) => {
            this.currentTimeoutId = window.setTimeout(() => {
                element.textContent += input[i];
                resolve();
            }, 10);
        });
    }

    this.currentTimeoutId = null;
  }

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
    }
  }

  viewQuestList() {
    this.viewQuests = true;
    this.viewBuild = false;
  }

  viewCurrentBuild() {
    this.viewBuild = true;
    this.viewQuests = false;
  }

  async selectSkill(skillIndex: number, skillType: 'common' | 'unique'): Promise<void> {
    this.selectedSkill = { index: skillIndex, type: skillType };
    this.skillSelected = true;
    this.skillCardLoaded = false;
    this.toggleGlassEffect();

    const skill = skillType === 'common' ? this.commonSkills[skillIndex] : this.uniqueSkills[skillIndex];
    this.currentSkill = skill;

    try {
      await this.preloadImage(skill.cardImageUrl);
      this.skillCardLoaded = true;

    } catch (error) {
      console.error('Image loading failed', error);
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
    // this.updateSkillPoints();
    this.updateTotalAvailableSP();
    this.playQuestCompleteAudio();
  }

  toggleAllQuests(event: Event): void {
    const target = event.target as HTMLInputElement;
    const selected = target.checked;
    this.quests.forEach(quest => {
      quest.selected = selected;
    });
    // this.updateSkillPoints();
    this.updateTotalAvailableSP();
    this.playQuestCompleteAudio();
  }

  areAllQuestsSelected(): boolean {
    return this.quests.every(quest => quest.selected);
  }

  updateSkillPoints() {
    // this.totalAvailableSP = this.currentStats.skillPoints + this.calculateTotalSkillPoints();
    this.updateTotalAvailableSP();
  }

  isSkillDetailSelected(skill: Skill, skillDetail: SkillDetails): boolean {
    return this.skillsList.some(item =>
      item.skillId === skill.id && item.rank === skillDetail.rank
    );
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
    console.log(this.skillsList);
  }

  removeFromSkillsList(skill: Skill, selectedSkillDetail: SkillDetails): void {
    this.skillsList = this.skillsList.filter(item =>
      item.skillId !== skill.id || item.rank < selectedSkillDetail.rank
    );
    console.log(this.skillsList);
    this.updateTotalAvailableSP();
    this.updateCurrentBuild();
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
    }

    // Update total available SP after any changes
    this.updateTotalAvailableSP();
  }

  updateTotalAvailableSP(): void {
    // Skill points gained from quests
    const questSP = this.calculateTotalSkillPoints();

    // Total skill points spent on unlocking skills
    const spentSP = this.skillsList.reduce((total, item) => total + item.requiredSkillPoints, 0);
    console.log("Spent SP: ", spentSP);
    // Initial skill points at level 1 plus skill points gained from leveling up
    // Assuming 'currentLevelSP' represents just the additional points gained from leveling up beyond the initial SP
    const totalSkillPointsFromLevels = this.currentLevelSP;
    console.log("SP from levels: ", totalSkillPointsFromLevels);
    // Calculating total available skill points
    this.totalAvailableSP = totalSkillPointsFromLevels + questSP - spentSP;
    console.log("Available SP: ", this.totalAvailableSP);
  }

  isRankSelected(skillId: number, rank: number): boolean {
    return this.skillsList.some(skill => skill.skillId === skillId && skill.rank === rank);
  }

  removeSkillsByName(skillName: string, event: MouseEvent): void {
    event.stopPropagation(); // Prevent event from triggering parent click events

    // Filter out all skills from skillsList that have the specified name
    this.skillsList = this.skillsList.filter(skill => skill.name !== skillName);

    // Update totalAvailableSP accordingly
    this.updateTotalAvailableSP();
    this.updateCurrentBuild();
  }

  updateCurrentBuild(): void {
    // Step 1: Identify the highest rank for each skill
    const highestRanks = new Map<number, number>(); // Using skillId as key for uniqueness

    this.skillsList.forEach(skill => {
      const currentMaxRank = highestRanks.get(skill.skillId) || 0;
      if (skill.rank > currentMaxRank) {
        highestRanks.set(skill.skillId, skill.rank);
      }
    });

    // Step 2: Filter the skillsList based on the highest rank for each skill
    this.currentBuild = this.skillsList.filter(skill => {
      const highestRank = highestRanks.get(skill.skillId);
      return skill.rank === highestRank;
    });

    // Optionally, sort currentBuild by skillId or name if needed
    this.currentBuild.sort((a, b) => a.skillId - b.skillId);
  }

  playClassAudio(className: string) {
    if (this.previousClassVoice !== className) {
      this.previousClassVoice = className;
      // Validate that className is a valid key
      if (className in this.audioPaths) {
        const audioPath = this.audioPaths[className as ClassName];
        const audio = new Audio(audioPath);
        audio.play();
      } else {
        console.error('Invalid class name:', className);
      }
    }
  }

  playQuestCompleteAudio() {
    const audioPath = '/assets/audio/coinbag_1.wav';
    const audio = new Audio(audioPath);
    audio.play();
  }
}
