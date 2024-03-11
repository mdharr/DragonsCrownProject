import { Spell } from "./spell";

export interface Rune {
  id: number;
  imageUrl: string;
  letter: string;
  isCarried: boolean;
  spells: Spell[];
}
