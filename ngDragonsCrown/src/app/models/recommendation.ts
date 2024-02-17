import { PlayerClass } from "./player-class";

export class Recommendation {

  id: number;
  description: string;
  playerClass: PlayerClass;

  constructor(
    id: number = 0,
    description: string = '',
    playerClass: PlayerClass = new PlayerClass(),
  ) {
    this.id = id;
    this.description = description;
    this.playerClass = playerClass;
  }
}
