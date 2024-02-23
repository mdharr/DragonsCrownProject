import { Skill } from "./skill";

export class SkillDetails {

  id: number;
  rank: number;
  requiredSkillPoints: number;
  similarSkillLevel: number;
  requiredPlayerLevel: number;
  effects: string;
  skill: Skill;

  constructor(
    id: number = 0,
    rank: number = 0,
    requiredSkillPoints: number = 0,
    similarSkillLevel: number = 0,
    requiredPlayerLevel: number = 0,
    effects: string = '',
    skill: Skill = new Skill()
  ) {
    this.id = id;
    this.rank = rank;
    this.requiredSkillPoints = requiredSkillPoints;
    this.similarSkillLevel = similarSkillLevel;
    this.requiredPlayerLevel = requiredPlayerLevel;
    this.effects = effects;
    this.skill = skill;
  }
}
