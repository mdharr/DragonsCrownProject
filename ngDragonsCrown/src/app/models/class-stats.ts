import { PlayerClass } from "./player-class";

export class ClassStats {

  id: number;
  level: number;
  health: number;
  strength: number;
  intelligence: number;
  constitution: number;
  magicResistance: number;
  dexterity: number;
  luck: number;
  requiredExp: number;
  skillPoints: number;
  playerClass: PlayerClass;

  constructor(
    id: number = 0,
    level: number = 0,
    health: number = 0,
    strength: number = 0,
    intelligence: number = 0,
    constitution: number = 0,
    magicResistance: number = 0,
    dexterity: number = 0,
    luck: number = 0,
    requiredExp: number = 0,
    skillPoints: number = 0,
    playerClass: PlayerClass = new PlayerClass(),
  ) {
    this.id = id;
    this.level = level;
    this.health = health;
    this.strength = strength;
    this.intelligence = intelligence;
    this.constitution = constitution;
    this.magicResistance = magicResistance;
    this.dexterity = dexterity;
    this.luck = luck;
    this.requiredExp = requiredExp;
    this.skillPoints = skillPoints;
    this.playerClass = playerClass;
  }
}
