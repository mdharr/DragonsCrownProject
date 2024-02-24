import { SkillDetails } from "./skill-details";

export class Skill {

  id: number;
  name: string;
  description: string;
  cardImageUrl: string;
  isCommon: boolean;
  skillDetails: SkillDetails[];

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    cardImageUrl: string = '',
    isCommon: boolean = false,
    skillDetails: SkillDetails[] = []
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.cardImageUrl = cardImageUrl;
    this.isCommon = isCommon;
    this.skillDetails = skillDetails;
  }
}
