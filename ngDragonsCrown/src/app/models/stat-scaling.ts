import { PlayerClass } from "./player-class";

export class StatScaling {

  id: number;
  strength: string;
  constitution: string;
  intelligence: string;
  magicResistance: string;
  dexterity: string;
  luck: string;
  playerClass: PlayerClass;

  constructor(
    id: number = 0,
    strength: string = '',
    constitution: string = '',
    intelligence: string = '',
    magicResistance: string = '',
    dexterity: string = '',
    luck: string = '',
    playerClass: PlayerClass = new PlayerClass(),
  ) {
    this.id = id;
    this.strength = strength;
    this.constitution = constitution;
    this.intelligence = intelligence;
    this.magicResistance = magicResistance;
    this.dexterity = dexterity;
    this.luck = luck;
    this.playerClass = playerClass;
  }
}
