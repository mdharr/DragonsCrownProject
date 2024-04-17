import { Component, ElementRef, OnInit, ViewChild, AfterViewInit, OnDestroy } from '@angular/core';
import { AudioEntity } from 'src/app/models/audio-entity';
import { Rune } from 'src/app/models/rune';
import { Spell } from 'src/app/models/spell';

@Component({
  selector: 'app-rune-matcher',
  templateUrl: './rune-matcher.component.html',
  styleUrls: ['./rune-matcher.component.css']
})
export class RuneMatcherComponent implements OnInit, AfterViewInit, OnDestroy {

  // properties
  carriedRunes: Rune[] = [];
  carvedRunes: Rune[] = [];
  selectedRunes: Rune[] = [];
  runeKey: Rune[] = [];
  spellKey: Spell[] = [];
  spells: Spell[] = [];
  currentSpell: Spell = new Spell();
  currentRunes: Rune[] = [];
  currentCarvedRunes: Rune[] = [];
  userRunes: Rune[] = [];
  currentScore: number = 0;
  nextCounter: number = 0;
  runeContainerWidth: number = 0;
  runeContainerHeight: number = 0;
  currentTimeoutId: number | null = null;

  // sounds
  currentAudio: HTMLAudioElement | null = null;
  currentAudioBufferSource: AudioBufferSourceNode | null = null;
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
    { name: 'cast', path: 'assets/audio/dc_cast_se.mp3' },
    { name: 'click', path: 'assets/audio/dc_click_se.mp3' },
    { name: 'open', path: 'assets/audio/dc_open_se.mp3' },
    { name: 'reveal', path: 'assets/audio/dc_reveal_se.mp3' },
    { name: 'unveil', path: 'assets/audio/dc_unveil_se.mp3' },
    { name: 'unveil_alt', path: 'assets/audio/dc_unveil_se_alt.mp3' },
    { name: 'ending', path: 'assets/audio/dc_ending_se.mp3' },
    { name: 'blip', path: 'assets/audio/dc_blip_se.mp3' },
    { name: 'dialogue', path: 'assets/audio/dc_dialogue_se.mp3' },
  ]

  // booleans
  noSpellsRemaining: boolean = false;
  hasCurrentSpell: boolean = false;
  canEvaluate: boolean = false;
  revealSpell: boolean = false;
  enableNext: boolean = false;
  showRuneLetters: boolean = false;
  gameStarted: boolean = false;
  carriedRunesEnabled: boolean = false;
  suggestHint: boolean = false;
  suggestNewGame: boolean = false;
  evaluated: boolean = false;
  gameOver: boolean = false;
  private suggestHintTimeout: any;

  @ViewChild('runeContainer') runeContainerRef!: ElementRef;
  runePositions: Array<{ left: string, top: string }> = [];

  ngOnInit() {
    this.fetchData();
  }

  ngAfterViewInit() {
    this.typeOutText('Match missing runes etched on the wall with carried runes to proceed. Enter the correct combination and be rewarded with powerful magic spells. Click SHOW HINT at anytime if you get stuck!', 'menu-text');
  }

  ngOnDestroy() {
    this.stopCurrentSound();
    if (this.currentTimeoutId) {
      clearTimeout(this.currentTimeoutId);
    }
  }

  async fetchData() {
    // const response = await fetch('/assets/runes.json');
    const response = await fetch('assets/runes.json');
    const data = await response.json();
    this.runeKey = data.runes;
    this.spellKey = [...data.spells];
    this.carriedRunes = data.runes.filter((rune: Rune) => rune.isCarried);
    this.carvedRunes = data.runes.filter((rune: Rune) => !rune.isCarried);
    this.spells = data.spells;
    this.noSpellsRemaining = false;
  }

  getSpell() {
    const imageElements = document.querySelectorAll('.carried-runes img');
    imageElements.forEach(element => element.classList.remove('no-animation'));
    const divElement = document.querySelector('.current-spell-wrapper') as HTMLElement;
    divElement?.classList.add('reveal');
    setTimeout(() => {
      divElement?.classList.remove('reveal');
    }, 500);
    if (this.selectedRunes) {
      this.selectedRunes = [];
    }
    if (this.currentRunes.length) {
      this.currentRunes = [];
    }
    if (this.userRunes.length) {
      this.userRunes = [];
    }
    if (this.revealSpell) {
      this.revealSpell = false;
    }
    if (this.spells.length > 0) {
      try {
        const random = Math.floor(Math.random() * this.spells.length);
        this.currentSpell = this.spells.splice(random, 1)[0];
        this.nextCounter++;
        this.hasCurrentSpell = true;
        this.suggestHint = false;
        this.evaluated = false;
        this.currentSpell.runes.forEach(r => {
          const rune = this.runeKey.find(rune => rune.id === r);
          if (rune) {
            this.currentRunes.push(rune);
          }
        });
        this.calculateRunePositions();
        this.currentCarvedRunes = this.currentRunes.filter(r => !r.isCarried);
        this.userRunes = this.userRunes.concat(this.currentCarvedRunes);
        this.stopCurrentSound();
        this.playSound('pageflip', 0.5);
        this.carriedRunesEnabled = true;
        this.setTimerToSuggestHint();
      } catch (error) {
        console.error('Error choosing spell.');
      }
    } else {
      this.noSpellsRemaining = true;
      this.stopCurrentSound();
      this.playSound('ending', 0.5);
      setTimeout(() => {
        this.restart();
      }, 5500);
    }
  }

  setTimerToSuggestHint() {
    if (this.suggestHintTimeout) {
      clearTimeout(this.suggestHintTimeout);
    }

    this.suggestHintTimeout = setTimeout(() => {
      this.suggestHint = true;
    }, 10000);
  }

  restart() {
    this.fetchData();
    if (this.revealSpell) {
      this.revealSpell = false;
    }
    if (this.selectedRunes) {
      this.selectedRunes = [];
    }
    const imageElements = document.querySelectorAll('.carried-runes img');
    imageElements.forEach(element => element.classList.add('no-animation'));
    this.hasCurrentSpell = false;
    this.nextCounter = 0;
    this.playSound('erase', 0.5);
  }

  getRuneImageUrl(runeId: number) {
    const rune = this.runeKey.find(r => r.id === runeId);
    const selectedRunes = this.selectedRunes;
    const carriedRunes = this.currentSpell.runes
      .map(runeId => this.runeKey.find(r => r.id === runeId))
      .filter(rune => rune && rune.isCarried);

    if (rune && !rune.isCarried) {
      return rune?.imageUrl;
    } else if (carriedRunes.length > 0) {
      const imageUrlMap = new Map<number, string>();
      for (let i = 0; i < carriedRunes.length && i < selectedRunes.length; i++) {
        imageUrlMap.set(carriedRunes[i]!.id, selectedRunes[i]?.imageUrl || '');
      }
      // return imageUrlMap.get(runeId) || '/assets/graphics/runes/Unknown.png';
      return imageUrlMap.get(runeId) || 'assets/graphics/runes/Unknown.png';
    } else {
      // return '/assets/graphics/runes/Unknown.png';
      return 'assets/graphics/runes/Unknown.png';
    }
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

  // stopCurrentSound() {
  //   if (this.currentAudio) {
  //     this.currentAudio.pause();
  //     this.currentAudio.currentTime = 0;
  //     this.currentAudio = null;
  //   }
  // }

  stopCurrentSound() {
    if (this.currentAudio) {
        this.currentAudio.pause();
        this.currentAudio.currentTime = 0;
        this.currentAudio = null;
    }

    if (this.currentAudioBufferSource) {
        this.currentAudioBufferSource.stop();
        this.currentAudioBufferSource = null;
    }
  }

  selectRune(runeId: number) {
    if (this.hasCurrentSpell) {
      const selectedRune = this.runeKey.find(r => r.id === runeId);
      if (selectedRune && this.selectedRunes.includes(selectedRune)) {
        this.selectedRunes = this.selectedRunes.filter(r => r.id !== runeId);
        this.userRunes = this.userRunes.filter(r => r.id !== runeId);

        this.playSound('scratch', 0.5);
      } else {
        if (selectedRune && this.selectedRunes.length < (3 - this.currentCarvedRunes.length)) {
          this.selectedRunes.push(selectedRune);
          this.userRunes.push(selectedRune);

          this.playSound('rune', 0.5);
        }
      }
    }
  }

  isSelectionComplete() {
    return this.userRunes.length === 3;
  }

  isSelected(runeId: number): boolean {
    return this.selectedRunes.some(r => r.id === runeId);
  }

  isNextAvailable() {
    return this.nextCounter % 2 === 0;
  }

  evaluateCombination(spellRunes: Rune[], userRunes: Rune[]): boolean {
    let counter = 0;
    spellRunes.forEach(spellRune => {
      if (userRunes.some(userRune => userRune.id === spellRune.id)) {
        counter++;
      }
    });
    if (counter === spellRunes.length) {
      this.playSound('click', 0.5);
      this.currentScore++;
      this.revealSpell = true;
      this.evaluated = true;
      setTimeout(() => {
        this.stopCurrentSound();
        this.playSound('reveal', 0.3);
      }, 100)
      const evaluateButton = document.querySelector('#evaluate-button') as HTMLElement;
      evaluateButton.setAttribute('disabled', 'true');
      this.carriedRunesEnabled = false;
    } else {
      const divElement = document.querySelector('.current-spell-wrapper') as HTMLElement;
      divElement?.classList.add('shake-animation');
      this.stopCurrentSound();
      this.playSound('open', 0.5);
      setTimeout(() => {
        divElement?.classList.remove('shake-animation');
      }, 300);
    }
    if (counter === spellRunes.length) {
      this.nextCounter++;
      return true;
    } else {
      return false;
    }
  }

  dragStart(event: DragEvent, runeId: number) {
    event.dataTransfer?.setData('text/plain', runeId.toString());
  }

  allowDrop(event: DragEvent) {
    event.preventDefault();
  }

  dropRune(event: DragEvent) {
    event.preventDefault();
    const runeIdStr = event.dataTransfer?.getData('text/plain');
    if (runeIdStr) {
      const runeId = parseInt(runeIdStr, 10);
      const selectedRune = this.runeKey.find(r => r.id === runeId);
      if (selectedRune && this.selectedRunes.length < (3 - this.currentCarvedRunes.length)) {
        this.selectedRunes.push(selectedRune);
        this.userRunes.push(selectedRune);
        this.playSound('rune', 0.5);
      }
    }
  }

  getProgressWidth(): string {
    const progress = (this.spellKey.length - this.spells.length) / this.spellKey.length;
    return `${progress * 100}%`;
  }

  viewRuneLetters() {
    this.showRuneLetters = !this.showRuneLetters;
    this.playSound('blip');
  }
  // make this asynchronous and preload rune images before setting gameStarted to true
  startGame() {
    this.gameStarted = !this.gameStarted;
    this.stopCurrentSound();
    this.playSound('rune');
  }

  getRandomLeft(index: number): string {
    const maxLeft = 100;
    const left = Math.random() * maxLeft;
    return `${left}%`;
  }

  getRandomTop(index: number): string {
    const maxTop = 100;
    const top = Math.random() * maxTop;
    return `${top}%`;
  }

  calculateRunePositions() {
    const runeSize = 100; // The size of the rune image
    const containerWidth = 898; // Assuming the container width
    const containerHeight = 310; // Assuming the container height
    const positions = [];

    for (let i = 0; i < this.currentSpell.runes.length; i++) {
      let left, top, overlap;
      do {
        overlap = false;
        left = Math.random() * (containerWidth - runeSize);
        top = Math.random() * (containerHeight - runeSize);

        // Check for overlap with existing runes
        for (const pos of positions) {
          const existingLeft = parseFloat(pos.left);
          const existingTop = parseFloat(pos.top);
          if (Math.abs(left - existingLeft) < runeSize && Math.abs(top - existingTop) < runeSize) {
            overlap = true;
            break;
          }
        }
      } while (overlap);

      positions.push({ left: `${left}px`, top: `${top}px` });
    }

    this.runePositions = positions;
  }

  async typeOutText(input: string, elementId: string): Promise<void> {
    const element = document.getElementById(elementId) as HTMLParagraphElement;
    if (!element) {
      console.error('Element not found');
      return;
    }

    element.textContent = '';

    // Wait for the sound to be ready and playing
    const soundReady = await this.playLoopingSound('dialogue', 1.0);
    if (!soundReady) {
      console.error('Failed to play sound');
      return;
    }

    let temporaryText = '';
    for (let i = 0; i < input.length; i++) {
      temporaryText += input[i];
      element.textContent = temporaryText;

      // Logic to check if the next part of the word will fit
      if (i < input.length - 1 && element.scrollWidth > element.clientWidth) {
        temporaryText += '-';  // Add a hyphen at the break
        element.textContent = temporaryText;
        await new Promise<void>(resolve => setTimeout(resolve, this.getDelay(i)));
        temporaryText = '';  // Reset temporaryText for the next line
      }

      await new Promise<void>(resolve => setTimeout(resolve, this.getDelay(i)));
    }

    this.stopCurrentSound();
  }

  async playLoopingSound(soundName: string, volume: number = 1.0): Promise<AudioBufferSourceNode | null> {
    const audioObj = this.sounds.find(sound => sound.name === soundName);
    const audioPath = audioObj?.path;

    if (audioPath) {
      const context = new AudioContext();
      try {
        const response = await fetch(audioPath);
        const arrayBuffer = await response.arrayBuffer();
        const audioBuffer = await context.decodeAudioData(arrayBuffer);

        // Simulate a delay in preparing the audio
        // await new Promise(resolve => setTimeout(resolve, 3000));

        const source = context.createBufferSource();
        source.buffer = audioBuffer;
        source.loop = true;

        const gainNode = context.createGain();
        gainNode.gain.value = volume;

        source.connect(gainNode);
        gainNode.connect(context.destination);

        source.start(0);
        this.currentAudioBufferSource = source;

        return source;
      } catch (error) {
        console.error('Error loading or playing sound:', error);
        return null;
      }
    }

    return Promise.resolve(null);
  }

  getDelay(index: number): number {
    return index * 0.3;
  }

}
