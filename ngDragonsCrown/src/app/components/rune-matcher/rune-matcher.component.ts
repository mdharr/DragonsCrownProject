import { Component, OnInit } from '@angular/core';
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
  }

  getRuneImageUrl(runeId: number) {
    const rune = this.runeKey.find(r => r.id === runeId);
    return rune ? rune.imageUrl : '/assets/graphics/runes/Unknown.png';
  }

  logRuneLetter(runeId: number) {
    const rune = this.runeKey.find(r => r.id === runeId);
    console.log(rune?.letter);
  }

}
