import { Pipe, PipeTransform } from '@angular/core';
import { Skill } from '../models/skill';

interface CombinedSkill {
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
}

@Pipe({
  name: 'calculateTotalSP'
})
export class CalculateTotalSPPipe implements PipeTransform {

  transform(combinedSkill: CombinedSkill, allSkills: any[]): number {
    const fullSkill = allSkills.find(skill => skill.skill.name === combinedSkill.name);
    if (!fullSkill) {
      return 0;
    }

    const skillPointsUpToRank = fullSkill.skill.skillDetails
      .filter((detail: { rank: number; }) => detail.rank <= combinedSkill.rank)
      .reduce((acc: any, detail: { requiredSkillPoints: any; }) => acc + detail.requiredSkillPoints, 0);

    return skillPointsUpToRank;
  }
}
