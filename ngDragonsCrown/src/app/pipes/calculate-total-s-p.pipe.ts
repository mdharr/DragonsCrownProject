import { Pipe, PipeTransform } from '@angular/core';
import { Skill } from '../models/skill';

@Pipe({
  name: 'calculateTotalSP'
})
export class CalculateTotalSPPipe implements PipeTransform {

  transform(skillName: string, skills: any[]): number {
    // Filter skills to match the provided skill name
    const matchingSkills = skills.filter(skill => skill.skill.name === skillName);

    // Sum the requiredSkillPoints for each matching skill
    const totalRequiredSP = matchingSkills.reduce((total, skill) => {
      // Sum the requiredSkillPoints for each skillDetail of the current matching skill
      const skillDetailsTotalSP = skill.skill.skillDetails.reduce((detailTotal: any, skillDetail: { requiredSkillPoints: any; }) => {
        return detailTotal + skillDetail.requiredSkillPoints;
      }, 0);

      // Add the current skill's total to the overall total
      return total + skillDetailsTotalSP;
    }, 0);

    return totalRequiredSP;
  }
}
