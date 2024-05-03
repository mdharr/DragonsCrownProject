import { Component, ElementRef, Input, ViewChild, OnInit, OnChanges, SimpleChanges, OnDestroy, inject, Renderer2 } from '@angular/core';
import { AudioEntity } from 'src/app/models/audio-entity';

// createjs declaration
declare var createjs: any;

interface ClassTitles {
  [key: string]: string;
}

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
  spriteSheetMap: any;
  private tickerListener: Function | null = null;
  private animation: any;
  colorVariants: string[] = [];
  currentAudio: HTMLAudioElement | null = null;

  isStageReady: boolean = false;
  showLoader: boolean = false;

  sounds: AudioEntity[] = [
    { name: 'confirm', path: 'assets/audio/dc_confirm_se.mp3' },
  ];

  classTitles: ClassTitles = {
    "fighter": "https://atlus.com/dragonscrown/img/character/fighter/fightter_title.png",
    "amazon": "https://atlus.com/dragonscrown/img/character/amazon/amazon_title.png",
    "elf": "https://atlus.com/dragonscrown/img/character/elf/elf_title.png",
    "dwarf": "https://atlus.com/dragonscrown/img/character/dwarf/dwarf_title.png",
    "sorceress": "https://atlus.com/dragonscrown/img/character/sorceress/sorceress_title.png",
    "wizard": "https://atlus.com/dragonscrown/img/character/wizard/wizard_title.png"
  }

  // The frames array within your fighterSpriteSheetData contains a series of arrays, each representing a single frame of the sprite sheet. Each inner array specifies details about how a particular image (or part of an image) should be rendered. Here's what each index in these inner arrays represents:
  // X Position: The horizontal position of the frame's top-left corner within the sprite sheet image. This tells the renderer where to start cutting the frame from the sprite sheet.
  // Y Position: The vertical position of the frame's top-left corner within the sprite sheet image. Along with the X position, this defines the starting point for the frame.
  // Width: The width of the frame. This determines how wide the cut from the sprite sheet will be.
  // Height: The height of the frame. This determines the height of the cut from the sprite sheet.
  // Image Index (optional): In sprite sheets that contain multiple images, this index refers to the specific image in the images array. If your sprite sheet consists of a single image, this value is typically 0 or omitted.
  // RegX (Registration Point X): The X coordinate of the frame's registration point. This is often used to offset the drawing of the frame. For example, if you want the frame to be drawn centered around a particular point, you might set RegX to half the frame's width.
  // RegY (Registration Point Y): The Y coordinate of the frame's registration point, similar to RegX but for the vertical axis.

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
      // [starting frame index, ending frame index, looping: true/false, speed multiplier]
      "do": [0, 38, true, 1.2]
    },
    // spritesheet url
    // "images": ["https://dragons-crown.com/resources/sprite/character/fighter1.png"],
    'colors': ['#bdbdbd', '#ff787d', '#ffc162', '#32231F', '#ac8c71'],
    'images': [
      'https://dragons-crown.com/resources/sprite/character/fighter1.png',
      'https://dragons-crown.com/resources/sprite/character/fighter2.png',
      'https://dragons-crown.com/resources/sprite/character/fighter3.png',
      'https://dragons-crown.com/resources/sprite/character/fighter4.png',
      'https://dragons-crown.com/resources/sprite/character/fighter5.png'
    ],
    "loader": ["https://dragons-crown.com/resources/img/character/c1_loader.png"]
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
    // "images": ["https://dragons-crown.com/resources/sprite/character/amazon1.png"],
    'colors': ['#ffc162', '#bdbdbd', '#ffc162', '#ff787d', '#a00087'],
    'images': [
      'https://dragons-crown.com/resources/sprite/character/amazon1.png',
      'https://dragons-crown.com/resources/sprite/character/amazon2.png',
      'https://dragons-crown.com/resources/sprite/character/amazon3.png',
      'https://dragons-crown.com/resources/sprite/character/amazon4.png',
      'https://dragons-crown.com/resources/sprite/character/amazon5.png'
    ],
    "loader": ["https://dragons-crown.com/resources/img/character/c2_loader.png"]
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
    // "images": ["https://dragons-crown.com/resources/sprite/character/elf1.png"],
    'colors': ['#9ac871', '#ff6a6e', '#32231F', '#ac8c71', '#004e00'],
    'images': [
      'https://dragons-crown.com/resources/sprite/character/elf1.png',
      'https://dragons-crown.com/resources/sprite/character/elf2.png',
      'https://dragons-crown.com/resources/sprite/character/elf3.png',
      'https://dragons-crown.com/resources/sprite/character/elf4.png',
      'https://dragons-crown.com/resources/sprite/character/elf5.png'
    ],
    "loader": ["https://dragons-crown.com/resources/img/character/c4_loader.png"]
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
    // "images": ["https://dragons-crown.com/resources/sprite/character/dwarf1.png"],
    'colors': ['#ac8c71', '#ff6a6e', '#646956', '#c57534', '#9ac871'],
    'images': [
      'https://dragons-crown.com/resources/sprite/character/dwarf1.png',
      'https://dragons-crown.com/resources/sprite/character/dwarf2.png',
      'https://dragons-crown.com/resources/sprite/character/dwarf3.png',
      'https://dragons-crown.com/resources/sprite/character/dwarf4.png',
      'https://dragons-crown.com/resources/sprite/character/dwarf5.png'
    ],
    "loader": ["https://dragons-crown.com/resources/img/character/c5_loader.png"]
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
    // "images": ["https://dragons-crown.com/resources/sprite/character/sorceress1.png"],
    'colors': ['#6d184a', '#44433f', '#9a893e', '#4a9a89', '#773238'],
    'images': [
      'https://dragons-crown.com/resources/sprite/character/sorceress1.png',
      'https://dragons-crown.com/resources/sprite/character/sorceress2.png',
      'https://dragons-crown.com/resources/sprite/character/sorceress3.png',
      'https://dragons-crown.com/resources/sprite/character/sorceress4.png',
      'https://dragons-crown.com/resources/sprite/character/sorceress5.png'
    ],
    "loader": ["https://dragons-crown.com/resources/img/character/c6_loader.png"]
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
    // "images": ["https://dragons-crown.com/resources/sprite/character/wizard1.png"],
    'colors': ['#996d9b', '#ff6a6e', '#646956', '#6d184a', '#315d7a'],
    'images': [
      'https://dragons-crown.com/resources/sprite/character/wizard1.png',
      'https://dragons-crown.com/resources/sprite/character/wizard2.png',
      'https://dragons-crown.com/resources/sprite/character/wizard3.png',
      'https://dragons-crown.com/resources/sprite/character/wizard4.png',
      'https://dragons-crown.com/resources/sprite/character/wizard5.png'
    ],
    "loader": ["https://dragons-crown.com/resources/img/character/c3_loader.png"]
  };

  private el = inject(ElementRef);
  private renderer = inject(Renderer2);

  constructor() {
    this.initializeSpriteSheetMap();
  }

  ngOnInit() {
    // this.flickerEffect();
    this.initCanvas();
  }

  initializeSpriteSheetMap() {
    this.spriteSheetMap = {
      'fighter': this.fighterSpriteSheetData,
      'amazon': this.amazonSpriteSheetData,
      'elf': this.elfSpriteSheetData,
      'dwarf': this.dwarfSpriteSheetData,
      'sorceress': this.sorceressSpriteSheetData,
      'wizard': this.wizardSpriteSheetData
    };
  }

  ngOnDestroy() {
    if (this.tickerListener) {
      createjs.Ticker.off("tick", this.tickerListener);
    }
  }

  ngOnChanges(changes: SimpleChanges): void {
    console.log('Current className:', this.className);  // Debugging current class name
    console.log('Available classes in map:', Object.keys(this.spriteSheetMap));  // Check what keys are in the spriteSheetMap
    if (changes['className'] && changes['className'].currentValue) {
      const newClass = changes['className'].currentValue;
      console.log('New class received:', newClass);  // Debugging output for newClass
      if (this.spriteSheetMap[newClass]) {  // Ensure it's a valid class name
        this.colorVariants = this.spriteSheetMap[newClass].colors;
        this.loadSpriteSheet(newClass);
        // this.applyBackgroundImage();
      } else {
        console.error('Invalid class name:', newClass);  // Error log if class name is invalid
      }
    }
  }

  private initCanvas(): void {
    if (!this.canvasRef.nativeElement) {
      console.error('Canvas element is not available');
      return;
    }

    this.stage = new createjs.Stage(this.canvasRef.nativeElement);
    this.isStageReady = true; // Indicate that the stage is now ready
    this.showLoader = true;
    this.tickerListener = (event: any) => this.stage.update(event);
    createjs.Ticker.reset();
    createjs.Ticker.framerate = 30;
    createjs.Ticker.on("tick", this.tickerListener);

    // If a class name has already been set, attempt to load its sprite sheet
    if (this.className) {
      this.loadSpriteSheet(this.className);
    }
  }

  private loadSpriteSheet(className: string): void {
    if (!this.isStageReady) {
        console.warn('Attempted to load sprite sheet before stage was initialized.');
        return;
    }

    this.showLoader = true; // Ensure loader is shown while loading

    this.stage.removeAllChildren();
    this.stage.clear();

    const spriteSheetData = this.spriteSheetMap[className];
    if (spriteSheetData) {
        this.spriteSheet = new createjs.SpriteSheet(spriteSheetData);
        if (this.spriteSheet.complete) {
            this.startAnimation();
        } else {
            this.spriteSheet.on("complete", () => {
                this.startAnimation();
                this.showLoader = false; // Hide loader when the sprite sheet is ready
            }, this, true); // Use true to run once and avoid potential memory leaks
        }
    }
  }

  private startAnimation = (): void => {
    // First, check if an animation is already present and remove it
    if (this.animation) {
        this.stage.removeChild(this.animation);
    }

    // Create the new sprite animation
    this.animation = new createjs.Sprite(this.spriteSheet, "do");

    // Setting up sprite scaling and positioning
    const scale = 0.5;  // Example scale factor
    this.animation.scaleX = scale;
    this.animation.scaleY = scale;

    const spriteBounds = this.animation.getBounds();
    const scaledSpriteWidth = spriteBounds.width * scale;
    const scaledSpriteHeight = spriteBounds.height * scale;

    const centerX = (this.canvasRef.nativeElement.width - scaledSpriteWidth) / 2;
    const centerY = (this.canvasRef.nativeElement.height - scaledSpriteHeight) / 2;

    this.animation.regX = spriteBounds.x;
    this.animation.regY = spriteBounds.y;
    this.animation.x = centerX;
    this.animation.y = centerY;

    this.stage.addChild(this.animation);
    this.animation.play();
    this.stage.update();

    this.showLoader = false;  // Hide the loader once everything is set
};

  changeSprite(index: number): void {
    this.showLoader = true;  // Enable the loader immediately

    this.playSound('confirm');

    const className = this.className;
    const newImageUrl = this.spriteSheetMap[className].images[index];

    if (newImageUrl) {
        const newSpriteSheetData = {
            ...this.spriteSheetMap[className],
            images: [newImageUrl]
        };

        // Reinitialize the sprite sheet with the new image URL
        this.spriteSheet = new createjs.SpriteSheet(newSpriteSheetData);

        if (this.spriteSheet.complete) {
            // If the sprite sheet is immediately ready, start the animation
            this.startAnimation();
        } else {
            // Listen for the 'complete' event which indicates the sprite sheet has finished loading
            this.spriteSheet.on("complete", () => {
                this.startAnimation();
            }, this, true); // Pass true for the third parameter to ensure this listener is removed after execution
        }
    }
  }

  flickerEffect() {
    const crt = document.querySelector('.crt') as HTMLElement;
    setInterval(() => {
      if (crt) {
        crt.style.opacity = (Math.random() > 0.9) ? '0.8' : '1';
      }
    }, 500);
  }

  applyBackgroundImage() {
    const imageUrl = this.classTitles[this.className];
    const innerElement = this.el.nativeElement.querySelector('.inner');
    if (innerElement) {
      innerElement.style.setProperty('--dynamic-background-image', `url(${imageUrl})`);
    }
  }

  async playSound(soundName: string, volume: number = 1.0): Promise<HTMLAudioElement> {
    const audioObj = this.sounds.find(sound => sound.name === soundName);
    const audioPath = audioObj?.path;
    if (audioPath) {
      const audio = new Audio(audioPath);
      audio.volume = volume;

      return new Promise((resolve, reject) => {
        audio.play().then(() => {
          this.currentAudio = audio;
          resolve(audio);
        }).catch((error) => {
          console.error('Error playing audio:', error);
          reject(error);
        });
      });
    } else {
      return Promise.reject(new Error('Audio path not found'));
    }
  }
}
