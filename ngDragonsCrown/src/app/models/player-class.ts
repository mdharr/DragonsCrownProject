import { ClassStats } from "./class-stats";
import { Recommendation } from "./recommendation";

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
    recommendations: Recommendation[] = []
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
  }
}
