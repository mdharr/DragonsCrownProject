import { Component, OnInit } from '@angular/core';
import { Rune } from 'src/app/models/rune';
import { Spell } from 'src/app/models/spell';

@Component({
  selector: 'app-rune-matcher',
  templateUrl: './rune-matcher.component.html',
  styleUrls: ['./rune-matcher.component.css']
})
export class RuneMatcherComponent implements OnInit {

  carriedRunes: Rune[] = [];
  carvedRunes: Rune[] = [];
  spells: Spell[] = [];

  ngOnInit() {
    this.fetchData();
  }

  async fetchData() {
    const response = await fetch('/assets/runes.json');
    const data = await response.json();
    this.carriedRunes = data.runes.filter((rune: Rune) => rune.isCarried);
    this.carvedRunes = data.runes.filter((rune: Rune) => !rune.isCarried);
    this.spells = data.spells;
    console.log(this.carriedRunes);
    console.log(this.carvedRunes);
    console.log(this.spells);
  }

}
