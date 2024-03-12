import { Rune } from "./rune";

export class Spell {
  id: number;
  name: string;
  description: string;
  abbreviation: string;
  runes: Rune[];

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    abbreviation: string = '',
    runes: Rune[] = []
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.abbreviation = abbreviation;
    this.runes = runes;
  }
}
