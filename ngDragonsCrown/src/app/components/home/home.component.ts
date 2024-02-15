import { PlayerClassService } from './../../services/player-class.service';
import { AuthService } from './../../services/auth.service';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { PlayerClass } from 'src/app/models/player-class';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit, OnDestroy {

  // properties
  playerClasses: PlayerClass[] = [];

  // subscriptions
  private playerClassSubscription: Subscription | undefined;

  // dependencies
  auth = inject(AuthService);
  playerClassService = inject(PlayerClassService);

  ngOnInit() {
    this.subscribeToPlayerClassData();
  }

  ngOnDestroy() {
    if(this.playerClassSubscription) {
      this.playerClassSubscription.unsubscribe();
    }
  }

  subscribeToPlayerClassData() {
    this.playerClassSubscription = this.playerClassService.indexAll().subscribe({
      next: (data) => {
        this.playerClasses = data;
        // console.log(this.playerClasses);
      },
      error: (fail) => {
        console.error('Error retrieving player classes data');
        console.error(fail);
      }
    });
  }

  loadFighterData() {
    const fighterData = this.playerClasses[0];
    console.log(fighterData);
    const className = document.querySelector('#class-name');
    const level = document.querySelector('#level');
    const health = document.querySelector('#health');
    const strength = document.querySelector('#strength');
    const intelligence = document.querySelector('#intelligence');
    const constitution = document.querySelector('#constitution');
    const magicResistance = document.querySelector('#magic-resistance');
    const dexterity = document.querySelector('#dexterity');
    const luck = document.querySelector('#luck');
    console.log(level);
    if(className !== null) {
      className.textContent = fighterData.name;
    }
    if(level !== null) {
      level.setAttribute('value', fighterData.classStats[0].level.toString());
    }
    if(health !== null) {
      health.textContent = fighterData.classStats[0].health.toString();
    }
    if(strength !== null) {
      strength.textContent = fighterData.classStats[0].strength.toString();
    }
    if(intelligence !== null) {
      intelligence.textContent = fighterData.classStats[0].intelligence.toString();
    }
    if(constitution !== null) {
      constitution.textContent = fighterData.classStats[0].constitution.toString();
    }
    if(magicResistance !== null) {
      magicResistance.textContent = fighterData.classStats[0].magicResistance.toString();
    }
    if(dexterity !== null) {
      dexterity.textContent = fighterData.classStats[0].dexterity.toString();
    }
    if(luck !== null) {
      luck.textContent = fighterData.classStats[0].luck.toString();
    }
  }

  loadAmazonData() {
    const amazonData = this.playerClasses[1];
    console.log(amazonData);
    const className = document.querySelector('#class-name');
    const level = document.querySelector('#level');
    const health = document.querySelector('#health');
    const strength = document.querySelector('#strength');
    const intelligence = document.querySelector('#intelligence');
    const constitution = document.querySelector('#constitution');
    const magicResistance = document.querySelector('#magic-resistance');
    const dexterity = document.querySelector('#dexterity');
    const luck = document.querySelector('#luck');
    console.log(level);
    if(className !== null) {
      className.textContent = amazonData.name;
    }
    if(level !== null) {
      level.setAttribute('value', amazonData.classStats[0].level.toString());
    }
    if(health !== null) {
      health.textContent = amazonData.classStats[0].health.toString();
    }
    if(strength !== null) {
      strength.textContent = amazonData.classStats[0].strength.toString();
    }
    if(intelligence !== null) {
      intelligence.textContent = amazonData.classStats[0].intelligence.toString();
    }
    if(constitution !== null) {
      constitution.textContent = amazonData.classStats[0].constitution.toString();
    }
    if(magicResistance !== null) {
      magicResistance.textContent = amazonData.classStats[0].magicResistance.toString();
    }
    if(dexterity !== null) {
      dexterity.textContent = amazonData.classStats[0].dexterity.toString();
    }
    if(luck !== null) {
      luck.textContent = amazonData.classStats[0].luck.toString();
    }
  }

  loadElfData() {
    const elfData = this.playerClasses[1];
    console.log(elfData);
    const className = document.querySelector('#class-name');
    const level = document.querySelector('#level');
    const health = document.querySelector('#health');
    const strength = document.querySelector('#strength');
    const intelligence = document.querySelector('#intelligence');
    const constitution = document.querySelector('#constitution');
    const magicResistance = document.querySelector('#magic-resistance');
    const dexterity = document.querySelector('#dexterity');
    const luck = document.querySelector('#luck');
    console.log(level);
    if(className !== null) {
      className.textContent = elfData.name;
    }
    if(level !== null) {
      level.setAttribute('value', elfData.classStats[0].level.toString());
    }
    if(health !== null) {
      health.textContent = elfData.classStats[0].health.toString();
    }
    if(strength !== null) {
      strength.textContent = elfData.classStats[0].strength.toString();
    }
    if(intelligence !== null) {
      intelligence.textContent = elfData.classStats[0].intelligence.toString();
    }
    if(constitution !== null) {
      constitution.textContent = elfData.classStats[0].constitution.toString();
    }
    if(magicResistance !== null) {
      magicResistance.textContent = elfData.classStats[0].magicResistance.toString();
    }
    if(dexterity !== null) {
      dexterity.textContent = elfData.classStats[0].dexterity.toString();
    }
    if(luck !== null) {
      luck.textContent = elfData.classStats[0].luck.toString();
    }
  }

  loadDwarfData() {
    const dwarfData = this.playerClasses[1];
    console.log(dwarfData);
    const className = document.querySelector('#class-name');
    const level = document.querySelector('#level');
    const health = document.querySelector('#health');
    const strength = document.querySelector('#strength');
    const intelligence = document.querySelector('#intelligence');
    const constitution = document.querySelector('#constitution');
    const magicResistance = document.querySelector('#magic-resistance');
    const dexterity = document.querySelector('#dexterity');
    const luck = document.querySelector('#luck');
    console.log(level);
    if(className !== null) {
      className.textContent = dwarfData.name;
    }
    if(level !== null) {
      level.setAttribute('value', dwarfData.classStats[0].level.toString());
    }
    if(health !== null) {
      health.textContent = dwarfData.classStats[0].health.toString();
    }
    if(strength !== null) {
      strength.textContent = dwarfData.classStats[0].strength.toString();
    }
    if(intelligence !== null) {
      intelligence.textContent = dwarfData.classStats[0].intelligence.toString();
    }
    if(constitution !== null) {
      constitution.textContent = dwarfData.classStats[0].constitution.toString();
    }
    if(magicResistance !== null) {
      magicResistance.textContent = dwarfData.classStats[0].magicResistance.toString();
    }
    if(dexterity !== null) {
      dexterity.textContent = dwarfData.classStats[0].dexterity.toString();
    }
    if(luck !== null) {
      luck.textContent = dwarfData.classStats[0].luck.toString();
    }
  }

  loadSorceressData() {
    const sorceressData = this.playerClasses[1];
    console.log(sorceressData);
    const className = document.querySelector('#class-name');
    const level = document.querySelector('#level');
    const health = document.querySelector('#health');
    const strength = document.querySelector('#strength');
    const intelligence = document.querySelector('#intelligence');
    const constitution = document.querySelector('#constitution');
    const magicResistance = document.querySelector('#magic-resistance');
    const dexterity = document.querySelector('#dexterity');
    const luck = document.querySelector('#luck');
    console.log(level);
    if(className !== null) {
      className.textContent = sorceressData.name;
    }
    if(level !== null) {
      level.setAttribute('value', sorceressData.classStats[0].level.toString());
    }
    if(health !== null) {
      health.textContent = sorceressData.classStats[0].health.toString();
    }
    if(strength !== null) {
      strength.textContent = sorceressData.classStats[0].strength.toString();
    }
    if(intelligence !== null) {
      intelligence.textContent = sorceressData.classStats[0].intelligence.toString();
    }
    if(constitution !== null) {
      constitution.textContent = sorceressData.classStats[0].constitution.toString();
    }
    if(magicResistance !== null) {
      magicResistance.textContent = sorceressData.classStats[0].magicResistance.toString();
    }
    if(dexterity !== null) {
      dexterity.textContent = sorceressData.classStats[0].dexterity.toString();
    }
    if(luck !== null) {
      luck.textContent = sorceressData.classStats[0].luck.toString();
    }
  }
}
