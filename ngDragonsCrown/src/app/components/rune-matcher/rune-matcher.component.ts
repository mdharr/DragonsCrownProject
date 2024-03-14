import { Component, OnInit } from '@angular/core';
import { AudioEntity } from 'src/app/models/audio-entity';
import { Rune } from 'src/app/models/rune';
import { Spell } from 'src/app/models/spell';

@Component({
  selector: 'app-rune-matcher',
  templateUrl: './rune-matcher.component.html',
  styleUrls: ['./rune-matcher.component.css']
})
export class RuneMatcherComponent implements OnInit {

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

  // sounds
  currentAudio: HTMLAudioElement | null = null;
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
    { name: 'cast', path: '/assets/audio/dc_cast_se.mp3' },
    { name: 'click', path: '/assets/audio/dc_click_se.mp3' },
    { name: 'open', path: '/assets/audio/dc_open_se.mp3' },
    { name: 'reveal', path: '/assets/audio/dc_reveal_se.mp3' },
    { name: 'unveil', path: '/assets/audio/dc_unveilt_se.mp3' },
    { name: 'unveil_alt', path: '/assets/audio/dc_unveil_se_alt.mp3' },
    { name: 'ending', path: '/assets/audio/dc_ending_se.mp3' },
  ]

  // booleans
  noSpellsRemaining: boolean = false;
  hasCurrentSpell: boolean = false;
  canEvaluate: boolean = false;
  revealSpell: boolean = false;
  enableNext: boolean = false;

  ngOnInit() {
    this.fetchData();
  }

  async fetchData() {
    const response = await fetch('/assets/runes.json');
    const data = await response.json();
    this.runeKey = data.runes;
    this.spellKey = [...data.spells];
    this.carriedRunes = data.runes.filter((rune: Rune) => rune.isCarried);
    this.carvedRunes = data.runes.filter((rune: Rune) => !rune.isCarried);
    this.spells = data.spells;
    this.noSpellsRemaining = false;
  }

  getSpell() {
    console.log("Spell Key: ", this.spellKey.length);
    const imageElements = document.querySelectorAll('.carried-runes img');
    imageElements.forEach(element => element.classList.remove('no-animation'));
    console.log(imageElements);
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
        this.currentSpell.runes.forEach(r => {
          const rune = this.runeKey.find(rune => rune.id === r);
          if (rune) {
            this.currentRunes.push(rune);
          }
        });
        this.currentCarvedRunes = this.currentRunes.filter(r => !r.isCarried);
        this.userRunes = this.userRunes.concat(this.currentCarvedRunes);
        console.log("Current Carved Runes: ", this.currentCarvedRunes);
        this.stopCurrentSound();
        this.playSound('pageflip', 0.5);
      } catch (error) {
        console.error('Error choosing spell.');
      }
    } else {
      console.log('No spells remaining.');
      this.noSpellsRemaining = true;
      this.stopCurrentSound();
      this.playSound('ending', 0.5);
      setTimeout(() => {
        this.restart();
      }, 3500);
    }
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
    return rune && !rune.isCarried ? rune.imageUrl : '/assets/graphics/runes/Unknown.png';
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

  getDelay(index: number): number {
    return index * 0.3; // Adjust the multiplier to control wave speed
  }

  selectRune(runeId: number) {
    if (this.hasCurrentSpell) {
      const selectedRune = this.runeKey.find(r => r.id === runeId);
      if (selectedRune && this.selectedRunes.includes(selectedRune)) {
        this.selectedRunes = this.selectedRunes.filter(r => r.id !== runeId);
        this.userRunes = this.userRunes.filter(r => r.id !== runeId);
        // console.log("Selected Runes: ", this.selectedRunes);
        this.playSound('scratch', 0.5);
      } else {
        if (selectedRune && this.selectedRunes.length < (3 - this.currentCarvedRunes.length)) {
          this.selectedRunes.push(selectedRune);
          this.userRunes.push(selectedRune);
          // console.log("Selected Runes: ", this.selectedRunes);
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
      console.log('Correct');
      this.currentScore++;
      this.revealSpell = true;
      setTimeout(() => {
        this.stopCurrentSound();
        this.playSound('reveal', 0.3);
      }, 100)
      const evaluateButton = document.querySelector('#evaluate-button') as HTMLElement;
      evaluateButton.setAttribute('disabled', 'true');
    } else {
      const divElement = document.querySelector('.current-spell-wrapper') as HTMLElement;
      divElement?.classList.add('shake-animation');
      this.stopCurrentSound();
      this.playSound('open', 0.5);
      console.log('Incorrect');
      setTimeout(() => {
        divElement?.classList.remove('shake-animation');
      }, 300)
    }
    if (counter === spellRunes.length) {
      this.nextCounter++;
      return true;
    } else {
      return false;
    }
  }
}
