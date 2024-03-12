import { Spell } from "./spell";

export class Rune {
  id: number;
  imageUrl: string;
  letter: string;
  isCarried: boolean;
  spells: Spell[];

  constructor(
    id: number = 0,
    imageUrl: string = '',
    letter: string = '',
    isCarried: boolean = false,
    spells: Spell[] = []
  ) {
    this.id = id;
    this.imageUrl = imageUrl;
    this.letter = letter;
    this.isCarried = isCarried;
    this.spells = spells;
  }
}
