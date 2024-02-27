export class Quest {

  id: number;
  name: string;
  skillPoints: number;
  description: string;
  location: string;
  path: string;
  isComplete: boolean

  constructor(
    id: number = 0,
    name: string = '',
    skillPoints: number = 0,
    description: string = '',
    location: string = '',
    path: string = '',
    isComplete: boolean = false
  ) {
    this.id = id;
    this.name = name;
    this.skillPoints = skillPoints;
    this.description = description;
    this.location = location;
    this.path = path;
    this.isComplete = isComplete;
  }
}
