import { SkillDetails } from "./skill-details";

export class Skill {

  id: number;
  name: string;
  description: string;
  cardImageUrl: string;
  isCommon: boolean;
  category: string;
  skillDetails: SkillDetails[];

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    cardImageUrl: string = '',
    isCommon: boolean = false,
    category: string = '',
    skillDetails: SkillDetails[] = [],
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.cardImageUrl = cardImageUrl;
    this.isCommon = isCommon;
    this.category = category;
    this.skillDetails = skillDetails;
  }
}
