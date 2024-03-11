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
    const runesData = await response.json();
    this.carriedRunes = runesData.runes.filter((rune: Rune) => rune.isCarried);
    this.carvedRunes = runesData.runes.filter((rune: Rune) => !rune.isCarried);
    console.log(this.carriedRunes);
    console.log(this.carvedRunes);
  }

}
