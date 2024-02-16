import { ClassStats } from "./class-stats";

export class PlayerClass {

  id: number;
  name: string;
  description: string;
  animationUrl: string;
  artworkUrl: string;
  titleUrl: string;
  portraitUrl: string;
  backgroundUrl: string;
  iconUrl: string;
  classStats: ClassStats[];

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    animationUrl: string = '',
    artworkUrl: string = '',
    titleUrl: string = '',
    portraitUrl: string = '',
    backgroundUrl: string = '',
    iconUrl: string = '',
    classStats: ClassStats[] = []
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.animationUrl = animationUrl;
    this.artworkUrl = artworkUrl;
    this.titleUrl = titleUrl;
    this.portraitUrl = portraitUrl;
    this.backgroundUrl = backgroundUrl;
    this.iconUrl = iconUrl;
    this.classStats = classStats;
  }
}
