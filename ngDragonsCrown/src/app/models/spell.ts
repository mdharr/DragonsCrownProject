import { Rune } from "./rune";

export class Spell {
  id: number;
  name: string;
  description: string;
  abbreviation: string;
  runes: number[];

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    abbreviation: string = '',
    runes: number[] = []
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.abbreviation = abbreviation;
    this.runes = runes;
  }
}
