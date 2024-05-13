export interface CombinedSkill {
  skillId: number;
  name: string;
  description: string;
  cardImageUrl: string;
  isCommon: boolean;
  rankDetailId: number;
  rank: number;
  requiredSkillPoints: number;
  similarSkillLevel: number;
  requiredPlayerLevel: number;
  effects: string;
  category: string;
}
