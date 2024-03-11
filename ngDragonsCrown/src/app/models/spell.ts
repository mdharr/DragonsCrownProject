import { Rune } from "./rune";

export interface Spell {
  id: number;
  name: string;
  description: string;
  abbreviation: string;
  runes: Rune[];
}
