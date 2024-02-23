import { SkillDetails } from "./skill-details";

export class Skill {

  id: number;
  description: string;
  cardImageUrl: string;
  isCommon: boolean;
  skillDetails: SkillDetails[];

  constructor(
    id: number = 0,
    description: string = '',
    cardImageUrl: string = '',
    isCommon: boolean = false,
    skillDetails: SkillDetails[] = []
  ) {
    this.id = id;
    this.description = description;
    this.cardImageUrl = cardImageUrl;
    this.isCommon = isCommon;
    this.skillDetails = skillDetails;
  }
}
