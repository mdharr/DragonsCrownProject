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
  runeKey: Rune[] = [];
  spellKey: Spell[] = [];
  spells: Spell[] = [];
  currentSpell: Spell = new Spell();

  // sounds
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
  ]

  // booleans
  noSpellsRemaining: boolean = false;

  ngOnInit() {
    this.fetchData();
  }

  async fetchData() {
    const response = await fetch('/assets/runes.json');
    const data = await response.json();
    this.runeKey = data.runes;
    this.spellKey = data.spells;
    this.carriedRunes = data.runes.filter((rune: Rune) => rune.isCarried);
    this.carvedRunes = data.runes.filter((rune: Rune) => !rune.isCarried);
    this.spells = data.spells;
    this.currentSpell = new Spell();
    this.noSpellsRemaining = false;
  }

  getSpell() {
    if (this.spells.length > 0) {
      try {
        const random = Math.floor(Math.random() * this.spells.length);
        this.currentSpell = this.spells.splice(random, 1)[0];
        this.playSound('confirm');
      } catch (error) {
        console.error('Error choosing spell.');
      }
    } else {
      console.log('No spells remaining.');
      this.noSpellsRemaining = true;
    }
  }

  restart() {
    this.fetchData();
    this.playSound('erase');
  }

  getRuneImageUrl(runeId: number) {
    const rune = this.runeKey.find(r => r.id === runeId);
    return rune && !rune.isCarried ? rune.imageUrl : '/assets/graphics/runes/Unknown.png';
  }

  logRuneLetter(runeId: number) {
    const rune = this.runeKey.find(r => r.id === runeId);
    console.log(rune?.letter);
    this.playSound('rune');
  }

  playSound(soundName: string) {
    const audioObj = this.sounds.find(sound => sound.name === soundName);
    const audioPath = audioObj?.path;
    const audio = new Audio(audioPath);
    audio.play();
  }

  getDelay(index: number): number {
    return index * 0.3; // Adjust the multiplier to control wave speed
  }

}
