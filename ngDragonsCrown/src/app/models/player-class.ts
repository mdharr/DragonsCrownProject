import { ClassStats } from "./class-stats";
import { Quest } from "./quest";
import { Recommendation } from "./recommendation";
import { Skill } from "./skill";
import { StatScaling } from "./stat-scaling";

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
  streamableUrl: string;
  hqArtworkUrl: string;
  spriteStartUrl: string;
  spriteEndUrl: string;
  selectImgUrl: string;
  cardUrl: string;
  spritesheetUrl: string;
  paperUrl: string;
  classStats: ClassStats[];
  recommendations: Recommendation[];
  statScaling: StatScaling;
  skills: Skill[];
  quests: Quest[];

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
    streamableUrl: string = '',
    hqArtworkUrl: string = '',
    spriteStartUrl: string = '',
    spriteEndUrl: string = '',
    selectImgUrl: string = '',
    cardUrl: string = '',
    spritesheetUrl: string = '',
    paperUrl: string = '',
    classStats: ClassStats[] = [],
    recommendations: Recommendation[] = [],
    statScaling: StatScaling = new StatScaling(),
    skills: Skill[] = [],
    quests: Quest[] = []
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
    this.streamableUrl = streamableUrl;
    this.hqArtworkUrl = hqArtworkUrl;
    this.spriteStartUrl = spriteStartUrl;
    this.spriteEndUrl = spriteEndUrl;
    this.selectImgUrl = selectImgUrl;
    this.cardUrl = cardUrl;
    this.spritesheetUrl = spritesheetUrl;
    this.paperUrl = paperUrl;
    this.classStats = classStats;
    this.recommendations = recommendations;
    this.statScaling = statScaling;
    this.skills = skills;
    this.quests = quests;
  }
}
