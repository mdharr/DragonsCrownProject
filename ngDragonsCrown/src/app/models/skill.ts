export class Skill {

  id: number;
  description: string;
  cardImageUrl: string;
  isCommon: boolean;

  constructor(
    id: number = 0,
    description: string = '',
    cardImageUrl: string = '',
    isCommon: boolean = false
  ) {
    this.id = id;
    this.description = description;
    this.cardImageUrl = cardImageUrl;
    this.isCommon = isCommon;
  }
}
