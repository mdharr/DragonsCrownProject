import { Rune } from "./rune";

export interface Spell {
  id: number;
  name: string;
  description: string;
  combination: string;
  runes: Rune[];
}
