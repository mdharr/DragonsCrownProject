import { Component, ElementRef, Input, ViewChild, OnInit, OnChanges, SimpleChanges, OnDestroy } from '@angular/core';

// createjs declaration
declare var createjs: any;

@Component({
  selector: 'app-sprite-animation',
  templateUrl: './sprite-animation.component.html',
  styleUrls: ['./sprite-animation.component.css']
})
export class SpriteAnimationComponent implements OnInit, OnChanges, OnDestroy {
  @ViewChild('canvas', { static: true }) canvasRef!: ElementRef<HTMLCanvasElement>;
  @Input() className: string = '';

  private stage: any;
  private spriteSheet: any;
  private spriteSheetMap: any;
  private tickerListener: Function | null = null;
  private animation: any;

  private isStageReady: boolean = false;

  // Raw JSON data for the fighter spritesheet
  private fighterSpriteSheetData = {
    "frames": [
      [0,0,369,535,0,-33,-87],
      [369,0,369,535,0,-33,-87],
      [738,0,370,536,0,-32,-86],
      [1108,0,371,536,0,-31,-85],
      [1479,0,372,538,0,-30,-83],
      [1851,0,374,539,0,-29,-82],
      [0,539,374,541,0,-29,-80],
      [374,539,375,542,0,-28,-79],
      [749,539,376,543,0,-27,-78],
      [1125,539,377,544,0,-26,-77],
      [1502,539,378,544,0,-25,-77],
      [1880,539,379,545,0,-25,-76],
      [0,1084,380,545,0,-24,-76],
      [380,1084,381,546,0,-23,-75],
      [761,1084,382,546,0,-22,-75],
      [1143,1084,384,546,0,-21,-75],
      [1527,1084,384,547,0,-21,-74],
      [1911,1084,385,547,0,-20,-74],
      [0,1631,386,547,0,-19,-74],
      [386,1631,388,548,0,-18,-73],
      [774,1631,388,548,0,-18,-73],
      [1162,1631,388,548,0,-18,-73],
      [1550,1631,388,548,0,-18,-73],
      [0,2179,388,548,0,-18,-73],
      [388,2179,386,548,0,-20,-73],
      [774,2179,383,547,0,-23,-74],
      [1157,2179,378,547,0,-27,-74],
      [1535,2179,374,546,0,-31,-75],
      [1909,2179,371,546,0,-34,-75],
      [0,2727,367,546,0,-37,-75],
      [367,2727,365,547,0,-39,-75],
      [732,2727,366,547,0,-38,-75],
      [1098,2727,366,547,0,-38,-75],
      [1464,2727,366,547,0,-38,-75],
      [1830,2727,367,546,0,-37,-76],
      [0,3274,367,544,0,-37,-78],
      [367,3274,367,540,0,-36,-82],
      [734,3274,367,537,0,-35,-85],
      [1101,3274,368,534,0,-34,-88]
    ],
    "animations": {
      "do": [0, 38, true, 1.2]
    },
    "images": ["https://dragons-crown.com/resources/sprite/character/fighter1.png"]
  };

  // Raw JSON data for the amazon spritesheet
  private amazonSpriteSheetData = {
    "frames": [
      [0,0,290,484,0,-79,-49],
      [290,0,297,484,0,-76,-49],
      [587,0,301,485,0,-74,-48],
      [888,0,305,486,0,-72,-47],
      [1193,0,307,486,0,-71,-47],
      [1500,0,310,486,0,-70,-47],
      [1810,0,312,487,0,-69,-46],
      [0,487,312,487,0,-69,-46],
      [312,487,311,487,0,-70,-46],
      [623,487,307,487,0,-73,-46],
      [930,487,303,487,0,-75,-46],
      [1233,487,300,487,0,-77,-46],
      [1533,487,297,487,0,-79,-46],
      [1830,487,292,489,0,-82,-44],
      [0,976,287,489,0,-84,-44],
      [287,976,280,490,0,-87,-43],
      [567,976,270,490,0,-93,-43],
      [837,976,264,489,0,-95,-44],
      [1101,976,259,488,0,-97,-45],
      [1360,976,258,487,0,-97,-46],
      [1618,976,260,486,0,-96,-47],
      [1878,976,269,485,0,-89,-48],
      [0,1466,276,484,0,-86,-49],
      [276,1466,282,485,0,-83,-48]
    ],
    "animations": {
      "do": [0, 23, true, 0.45]
    },
    "images": ["https://dragons-crown.com/resources/sprite/character/amazon1.png"]
  };

  // Raw JSON data for the elf spritesheet
  private elfSpriteSheetData = {
    "frames": [
      [0,0,300,430,0,-54,-11],
      [300,0,313,426,0,-45,-15],
      [613,0,332,420,0,-32,-21],
      [945,0,344,417,0,-25,-24],
      [1289,0,352,414,0,-21,-27],
      [1641,0,356,412,0,-20,-29],
      [0,430,347,415,0,-26,-26],
      [347,430,321,423,0,-41,-18],
      [668,430,300,431,0,-54,-11],
      [968,430,294,433,0,-58,-9],
      [1262,430,297,432,0,-56,-10],
      [1559,430,306,428,0,-50,-13],
      [1865,430,323,423,0,-38,-18],
      [0,863,338,418,0,-28,-23],
      [338,863,349,415,0,-22,-26],
      [687,863,355,413,0,-20,-28],
      [1042,863,354,413,0,-21,-28],
      [1396,863,335,419,0,-33,-22],
      [1731,863,308,427,0,-49,-14],
      [0,1290,295,433,0,-57,-9],
      [295,1290,295,433,0,-57,-9]
    ],
    "animations": {
      "do": [0, 20, true, 0.3]
    },
    "images": ["https://dragons-crown.com/resources/sprite/character/elf1.png"]
  };

  // Raw JSON data for the dwarf spritesheet
  private dwarfSpriteSheetData = {
    "frames":[
      [0,0,413,358,0,-44,-77],
      [413,0,413,358,0,-44,-77],
      [826,0,410,358,0,-45,-77],
      [1236,0,406,357,0,-47,-78],
      [1642,0,403,356,0,-48,-79],
      [0,358,404,355,0,-44,-80],
      [404,358,402,354,0,-43,-81],
      [806,358,401,353,0,-42,-82],
      [1207,358,400,352,0,-42,-83],
      [1607,358,397,352,0,-46,-83],
      [0,713,403,353,0,-42,-82],
      [403,713,398,354,0,-50,-81],
      [801,713,400,355,0,-50,-80],
      [1201,713,404,356,0,-48,-79],
      [1605,713,409,357,0,-46,-78],
      [0,1070,413,357,0,-44,-78]
    ],
    "animations": {
      "do": [0, 15, true, 0.45]
    },
    "images": ["https://dragons-crown.com/resources/sprite/character/dwarf1.png"]
  };

  // Raw JSON data for the sorceress spritesheet
  private sorceressSpriteSheetData = {
    "frames": [
      [0,0,319,424,0,-38,-46],
      [319,0,318,423,0,-38,-47],
      [637,0,318,423,0,-38,-47],
      [955,0,318,422,0,-37,-48],
      [1273,0,318,421,0,-37,-49],
      [1591,0,318,420,0,-37,-50],
      [1909,0,317,419,0,-37,-51],
      [0,424,317,418,0,-37,-52],
      [317,424,316,417,0,-37,-53],
      [633,424,315,416,0,-37,-54],
      [948,424,315,416,0,-37,-54],
      [1263,424,314,416,0,-37,-54],
      [1577,424,315,415,0,-36,-55],
      [1892,424,314,416,0,-36,-54],
      [0,842,315,416,0,-35,-54],
      [315,842,314,416,0,-35,-54],
      [629,842,314,416,0,-35,-54],
      [943,842,314,417,0,-36,-53],
      [1257,842,314,417,0,-36,-53],
      [1571,842,314,417,0,-37,-53],
      [1885,842,314,418,0,-37,-52],
      [0,1260,315,418,0,-37,-52],
      [315,1260,315,419,0,-38,-51],
      [630,1260,316,420,0,-38,-50],
      [946,1260,316,422,0,-38,-48],
      [1262,1260,317,424,0,-38,-46],
      [1579,1260,318,426,0,-38,-44],
      [1897,1260,318,425,0,-38,-45],
      [0,1686,319,424,0,-39,-46],
      [319,1686,319,423,0,-39,-47],
      [638,1686,319,423,0,-39,-47],
      [957,1686,319,424,0,-38,-46]
    ],
    "animations": {
      "do": [0, 31, true, 0.45]
    },
    "images": ["https://dragons-crown.com/resources/sprite/character/sorceress1.png"]
  };

  // Raw JSON data for the wizard spritesheet
  private wizardSpriteSheetData = {
    "frames":[
      [0,0,258,427,0,-22,-13],
      [258,0,254,427,0,-25,-13],
      [512,0,248,427,0,-30,-13],
      [760,0,240,427,0,-36,-13],
      [1000,0,233,427,0,-41,-13],
      [1233,0,229,427,0,-46,-13],
      [1462,0,226,427,0,-50,-13],
      [1688,0,226,427,0,-51,-13],
      [1914,0,226,427,0,-52,-13],
      [0,427,226,427,0,-53,-13],
      [226,427,227,427,0,-53,-13],
      [453,427,229,427,0,-52,-13],
      [682,427,240,427,0,-42,-13],
      [922,427,247,427,0,-36,-13],
      [1169,427,249,427,0,-34,-13],
      [1418,427,244,427,0,-39,-13],
      [1662,427,238,427,0,-45,-13],
      [1900,427,241,427,0,-42,-13],
      [0,854,245,427,0,-37,-13],
      [245,854,247,427,0,-34,-13],
      [492,854,249,427,0,-31,-13],
      [741,854,253,427,0,-27,-13],
      [994,854,254,428,0,-25,-12],
      [1248,854,255,427,0,-23,-13],
      [1503,854,257,427,0,-21,-13],
      [1760,854,259,427,0,-20,-13],
      [2019,854,260,427,0,-19,-13],
      [0,1282,262,427,0,-18,-13],
      [262,1282,261,427,0,-19,-13],
      [523,1282,260,427,0,-20,-13]
    ],
    "animations": {
      "do": [0, 29, true, 0.3]
    },
    "images": ["https://dragons-crown.com/resources/sprite/character/wizard1.png"]
  };

  ngOnInit() {
    this.spriteSheetMap = {
      'fighter': this.fighterSpriteSheetData,
      'amazon': this.amazonSpriteSheetData,
      'elf': this.elfSpriteSheetData,
      'dwarf': this.dwarfSpriteSheetData,
      'sorceress': this.sorceressSpriteSheetData,
      'wizard': this.wizardSpriteSheetData
    };

    this.initCanvas();
    // Add the ticker listener once
    createjs.Ticker.on("tick", this.tickerListener);
  }

  ngOnDestroy() {
    console.log('Destroying component and removing ticker listener.');
    if (this.tickerListener) {
      createjs.Ticker.off("tick", this.tickerListener);
    }
  }

  ngOnChanges(changes: SimpleChanges) {
    console.log("OnChanges Triggered");
    if (this.tickerListener) {
      createjs.Ticker.off("tick", this.tickerListener);
      createjs.Ticker.reset();
    }
    if (changes['className'] && changes['className'].currentValue) {
      this.loadSpriteSheet(changes['className'].currentValue);
    }
  }

  private initCanvas(): void {
    if (!this.canvasRef.nativeElement) {
      console.error('Canvas element is not available');
      return;
    }

    this.stage = new createjs.Stage(this.canvasRef.nativeElement);
    this.isStageReady = true; // Indicate that the stage is now ready

    this.tickerListener = (event: any) => this.stage.update(event);
    createjs.Ticker.framerate = 30;
    createjs.Ticker.on("tick", this.tickerListener);
    console.log('Ticker listener added.');

    // If a class name has already been set, attempt to load its sprite sheet
    if (this.className) {
      this.loadSpriteSheet(this.className);
    }
  }

  private loadSpriteSheet(className: string): void {
    if (!this.isStageReady) {
      console.warn('Attempted to load sprite sheet before stage was initialized.');
      // Optionally, you could retry after a delay or set up an event/listener pattern
      return;
    }

    this.stage.removeAllChildren();
    this.stage.clear();

    // No need to off and on the ticker listener here if it's managed globally

    const spriteSheetData = this.spriteSheetMap[className];
    if (spriteSheetData) {
      this.spriteSheet = new createjs.SpriteSheet(spriteSheetData);
      if (this.spriteSheet.complete) {
        this.startAnimation();
      } else {
        this.spriteSheet.on("complete", this.startAnimation, this);
      }
    }
  }

  private startAnimation = (): void => {

    // Check if an animation already exists and remove it
    if (this.animation) {
      this.stage.removeChild(this.animation);
    }
    const animation = new createjs.Sprite(this.spriteSheet, "do");

    // Manually set a scale factor
    const scale = 0.5; // Adjust this value as needed to fit the sprite within the canvas

    // Apply the scale factor
    animation.scaleX = scale;
    animation.scaleY = scale;

    // Get the bounds of the sprite after scaling
    const spriteBounds = animation.getBounds();
    const scaledSpriteWidth = spriteBounds.width * scale;
    const scaledSpriteHeight = spriteBounds.height * scale;

    // Calculate the centered position
    const centerX = (this.canvasRef.nativeElement.width - scaledSpriteWidth) / 2;
    const centerY = (this.canvasRef.nativeElement.height - scaledSpriteHeight) / 2;

    // Set the sprite's registration point to the top-left
    animation.regX = spriteBounds.x;
    animation.regY = spriteBounds.y;

    // Position the sprite in the center of the canvas
    animation.x = centerX;
    animation.y = centerY;

    this.stage.addChild(animation);
    animation.play();

    // Explicitly update the stage after adding the sprite and starting the animation
    this.stage.update();

    // Update the stage on each tick, using a stored reference
    this.tickerListener = this.stage.update.bind(this.stage);
    createjs.Ticker.reset();
    createjs.Ticker.on("tick", this.tickerListener);
  }

}
