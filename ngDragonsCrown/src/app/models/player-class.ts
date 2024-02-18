import { ClassStats } from "./class-stats";
import { Recommendation } from "./recommendation";
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
  classStats: ClassStats[];
  recommendations: Recommendation[];
  statScaling: StatScaling;

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
    classStats: ClassStats[] = [],
    recommendations: Recommendation[] = [],
    statScaling: StatScaling = new StatScaling()
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
    this.classStats = classStats;
    this.recommendations = recommendations;
    this.statScaling = statScaling;
  }
}
