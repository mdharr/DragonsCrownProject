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

  // booleans
  classSelected: boolean = false;
  currentClassData: any = null;
  selectedClassIndex: number | null = null;

  // typewriter
  currentTimeoutId: number | null = null;

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

  loadClassData(classIndex: number): void {
    this.resetPortraits();
    this.selectPortrait();
    this.classSelected = true;
    this.currentClassData = this.playerClasses[classIndex];
    console.log(this.currentClassData);
    console.log(this.currentClassData.animationUrl);
    // Assuming typeOutText is adapted to work with Angular's rendering
    this.typeOutText(this.currentClassData.description, 'description-text');
  }

  loadFighterData() {
    this.classSelected = true;
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
    const n3Element = document.querySelector('.n3') as HTMLElement;
    const titleImgElement = document.querySelector('#title-img') as HTMLElement;
    const gifWrapper = document.querySelector('.position-gif') as HTMLElement;
    const gifElement = document.querySelector('.gif-wrapper img') as HTMLElement;
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
    if(n3Element) {
    }
    if(gifWrapper) {
      const styles = gifWrapper.style;
      styles.display = 'flex';
    }
    if(gifElement) {
      gifElement.setAttribute('src', fighterData.animationUrl);
    }
    if(titleImgElement) {
      titleImgElement.setAttribute('src', fighterData.titleUrl);
    }
    this.typeOutText(fighterData.description, 'description-text');
  }

  loadAmazonData() {
    this.classSelected = true;
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
    const n3Element = document.querySelector('.n3') as HTMLElement;
    const titleImgElement = document.querySelector('#title-img') as HTMLElement;
    const gifWrapper = document.querySelector('.position-gif') as HTMLElement;
    const gifElement = document.querySelector('.gif-wrapper img') as HTMLElement;
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
    if(n3Element) {

    }
    if(gifWrapper) {
      const styles = gifWrapper.style;
      styles.display = 'flex';
    }
    if(gifElement) {
      gifElement.setAttribute('src', amazonData.animationUrl);
    }
    if(titleImgElement) {
      titleImgElement.setAttribute('src', amazonData.titleUrl);
    }
    this.typeOutText(amazonData.description, 'description-text');
  }

  loadElfData() {
    this.classSelected = true;
    const elfData = this.playerClasses[2];
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
    const n3Element = document.querySelector('.n3') as HTMLElement;
    const titleImgElement = document.querySelector('#title-img') as HTMLElement;
    const gifWrapper = document.querySelector('.position-gif') as HTMLElement;
    const gifElement = document.querySelector('.gif-wrapper img') as HTMLElement;
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
    if(n3Element) {
    }
    if(gifWrapper) {
      const styles = gifWrapper.style;
      styles.display = 'flex';
    }
    if(gifElement) {
      gifElement.setAttribute('src', elfData.animationUrl);
    }
    if(titleImgElement) {
      titleImgElement.setAttribute('src', elfData.titleUrl);
    }
    this.typeOutText(elfData.description, 'description-text');
  }

  loadDwarfData() {
    this.classSelected = true;
    const dwarfData = this.playerClasses[3];
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
    const n3Element = document.querySelector('.n3') as HTMLElement;
    const titleImgElement = document.querySelector('#title-img') as HTMLElement;
    const gifWrapper = document.querySelector('.position-gif') as HTMLElement;
    const gifElement = document.querySelector('.gif-wrapper img') as HTMLElement;
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
    if(n3Element) {
    }
    if(gifWrapper) {
      const styles = gifWrapper.style;
      styles.display = 'flex';
    }
    if(gifElement) {
      gifElement.setAttribute('src', dwarfData.animationUrl);
    }
    if(titleImgElement) {
      titleImgElement.setAttribute('src', dwarfData.titleUrl);
    }
    this.typeOutText(dwarfData.description, 'description-text');
  }

  loadSorceressData() {
    this.classSelected = true;
    const sorceressData = this.playerClasses[4];
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
    const n3Element = document.querySelector('.n3') as HTMLElement;
    const titleImgElement = document.querySelector('#title-img') as HTMLElement;
    const gifWrapper = document.querySelector('.position-gif') as HTMLElement;
    const gifElement = document.querySelector('.gif-wrapper img') as HTMLElement;
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
    if(n3Element) {
    }
    if(gifWrapper) {
      const styles = gifWrapper.style;
      styles.display = 'flex';
    }
    if(gifElement) {
      gifElement.setAttribute('src', sorceressData.animationUrl);
    }
    if(titleImgElement) {
      titleImgElement.setAttribute('src', sorceressData.titleUrl);
    }
    this.typeOutText(sorceressData.description, 'description-text');
  }

  loadWizardData() {
    this.classSelected = true;
    const wizardData = this.playerClasses[5];
    console.log(wizardData);
    const className = document.querySelector('#class-name');
    const level = document.querySelector('#level');
    const health = document.querySelector('#health');
    const strength = document.querySelector('#strength');
    const intelligence = document.querySelector('#intelligence');
    const constitution = document.querySelector('#constitution');
    const magicResistance = document.querySelector('#magic-resistance');
    const dexterity = document.querySelector('#dexterity');
    const luck = document.querySelector('#luck');
    const n3Element = document.querySelector('.n3') as HTMLElement;
    const titleImgElement = document.querySelector('#title-img') as HTMLElement;
    const gifWrapper = document.querySelector('.position-gif') as HTMLElement;
    const gifElement = document.querySelector('.gif-wrapper img') as HTMLElement;
    console.log(level);
    if(className !== null) {
      className.textContent = wizardData.name;
    }
    if(level !== null) {
      level.setAttribute('value', wizardData.classStats[0].level.toString());
    }
    if(health !== null) {
      health.textContent = wizardData.classStats[0].health.toString();
    }
    if(strength !== null) {
      strength.textContent = wizardData.classStats[0].strength.toString();
    }
    if(intelligence !== null) {
      intelligence.textContent = wizardData.classStats[0].intelligence.toString();
    }
    if(constitution !== null) {
      constitution.textContent = wizardData.classStats[0].constitution.toString();
    }
    if(magicResistance !== null) {
      magicResistance.textContent = wizardData.classStats[0].magicResistance.toString();
    }
    if(dexterity !== null) {
      dexterity.textContent = wizardData.classStats[0].dexterity.toString();
    }
    if(luck !== null) {
      luck.textContent = wizardData.classStats[0].luck.toString();
    }
    if(n3Element) {
    }
    if(gifWrapper) {
      const styles = gifWrapper.style;
      styles.display = 'flex';
    }
    if(gifElement) {
      gifElement.setAttribute('src', wizardData.animationUrl);
    }
    if(titleImgElement) {
      titleImgElement.setAttribute('src', wizardData.titleUrl);
    }
    this.typeOutText(wizardData.description, 'description-text');
  }

  async typeOutText(input: string, elementId: string): Promise<void> {
    const element = document.getElementById(elementId) as HTMLParagraphElement;
    if (!element) {
        console.error('Element not found');
        return;
    }

    // Clear existing text content
    element.textContent = '';

    // If there's an ongoing typing animation, clear the timeout
    if (this.currentTimeoutId !== null) {
        clearTimeout(this.currentTimeoutId);
        this.currentTimeoutId = null;
    }

    for (let i = 0; i < input.length; i++) {
        // Check if we should stop the typing animation
        if (this.currentTimeoutId === null && i !== 0) {
            return;
        }

        // Wait for a bit before typing the next character
        await new Promise<void>((resolve) => {
            this.currentTimeoutId = window.setTimeout(() => {
                element.textContent += input[i];
                resolve();
            }, 10);
        });
    }

    // Reset the timeout ID to allow for new typing animations
    this.currentTimeoutId = null;
  }

}
