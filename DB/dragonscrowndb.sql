-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dragonscrowndb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `dragonscrowndb` ;

-- -----------------------------------------------------
-- Schema dragonscrowndb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dragonscrowndb` DEFAULT CHARACTER SET utf8 ;
USE `dragonscrowndb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `enabled` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `player_class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `player_class` ;

CREATE TABLE IF NOT EXISTS `player_class` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `animation_url` TEXT NULL,
  `artwork_url` TEXT NULL,
  `title_url` TEXT NULL,
  `portrait_url` TEXT NULL,
  `background_url` TEXT NULL,
  `icon_url` TEXT NULL,
  `streamable_url` TEXT NULL,
  `hq_artwork_url` TEXT NULL,
  `sprite_start_url` TEXT NULL,
  `sprite_end_url` TEXT NULL,
  `select_img_url` TEXT NULL,
  `card_url` TEXT NULL,
  `spritesheet_url` TEXT NULL,
  `spritesheet_json_url` TEXT NULL,
  `paper_url` TEXT NULL,
  `alternate_art_url` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `class_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `class_stats` ;

CREATE TABLE IF NOT EXISTS `class_stats` (
  `id` INT NOT NULL,
  `level` INT NULL,
  `health` INT NULL,
  `strength` INT NULL,
  `intelligence` INT NULL,
  `constitution` INT NULL,
  `magic_resistance` INT NULL,
  `dexterity` INT NULL,
  `luck` INT NULL,
  `required_exp` INT NULL,
  `skill_points` INT NULL,
  `player_class_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_class_stats_player_class_idx` (`player_class_id` ASC),
  CONSTRAINT `fk_class_stats_player_class`
    FOREIGN KEY (`player_class_id`)
    REFERENCES `player_class` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recommendation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recommendation` ;

CREATE TABLE IF NOT EXISTS `recommendation` (
  `id` INT NOT NULL,
  `description` TEXT NULL,
  `player_class_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recommendation_player_class1_idx` (`player_class_id` ASC),
  CONSTRAINT `fk_recommendation_player_class1`
    FOREIGN KEY (`player_class_id`)
    REFERENCES `player_class` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stat_scaling`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stat_scaling` ;

CREATE TABLE IF NOT EXISTS `stat_scaling` (
  `id` INT NOT NULL,
  `strength` VARCHAR(45) NULL,
  `constitution` VARCHAR(45) NULL,
  `intelligence` VARCHAR(45) NULL,
  `magic_resistance` VARCHAR(45) NULL,
  `dexterity` VARCHAR(45) NULL,
  `luck` VARCHAR(45) NULL,
  `player_class_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_stat_scaling_player_class1_idx` (`player_class_id` ASC),
  CONSTRAINT `fk_stat_scaling_player_class1`
    FOREIGN KEY (`player_class_id`)
    REFERENCES `player_class` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `skill` ;

CREATE TABLE IF NOT EXISTS `skill` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `card_image_url` TEXT NULL,
  `is_common` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skill_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `skill_details` ;

CREATE TABLE IF NOT EXISTS `skill_details` (
  `id` INT NOT NULL,
  `rank` INT NULL,
  `required_skill_points` INT NULL,
  `similar_skill_level` INT NULL,
  `required_player_level` INT NULL,
  `effects` TEXT NULL,
  `skill_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_skill_details_skill1_idx` (`skill_id` ASC),
  CONSTRAINT `fk_skill_details_skill1`
    FOREIGN KEY (`skill_id`)
    REFERENCES `skill` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `player_class_has_skill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `player_class_has_skill` ;

CREATE TABLE IF NOT EXISTS `player_class_has_skill` (
  `player_class_id` INT NOT NULL,
  `skill_id` INT NOT NULL,
  PRIMARY KEY (`player_class_id`, `skill_id`),
  INDEX `fk_player_class_has_skill_skill1_idx` (`skill_id` ASC),
  INDEX `fk_player_class_has_skill_player_class1_idx` (`player_class_id` ASC),
  CONSTRAINT `fk_player_class_has_skill_player_class1`
    FOREIGN KEY (`player_class_id`)
    REFERENCES `player_class` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_class_has_skill_skill1`
    FOREIGN KEY (`skill_id`)
    REFERENCES `skill` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `quest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quest` ;

CREATE TABLE IF NOT EXISTS `quest` (
  `id` INT NOT NULL,
  `name` TEXT NULL,
  `skill_points` INT NULL,
  `description` TEXT NULL,
  `location` TEXT NULL,
  `path` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `player_class_has_quest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `player_class_has_quest` ;

CREATE TABLE IF NOT EXISTS `player_class_has_quest` (
  `player_class_id` INT NOT NULL,
  `quest_id` INT NOT NULL,
  PRIMARY KEY (`player_class_id`, `quest_id`),
  INDEX `fk_player_class_has_quests_quests1_idx` (`quest_id` ASC),
  INDEX `fk_player_class_has_quests_player_class1_idx` (`player_class_id` ASC),
  CONSTRAINT `fk_player_class_has_quests_player_class1`
    FOREIGN KEY (`player_class_id`)
    REFERENCES `player_class` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_class_has_quests_quests1`
    FOREIGN KEY (`quest_id`)
    REFERENCES `quest` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS dragonscrown@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'dragonscrown'@'localhost' IDENTIFIED BY 'dragonscrown';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'dragonscrown'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`) VALUES (1, 'admin', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', 1, 'ADMIN');

COMMIT;


-- -----------------------------------------------------
-- Data for table `player_class`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`, `select_img_url`, `card_url`, `spritesheet_url`, `spritesheet_json_url`, `paper_url`, `alternate_art_url`) VALUES (1, 'Fighter', 'Experts in battle, outfitted with full-plate armor and a sturdy shield. Boasting the stoutest defense of all classes, their shields can protect all allies in the nearby area. Their one-handed weapons have short reach, but they can swing them quickly, allowing them to make short work of nearby foes.', 'https://media.tenor.com/N2o-Wi8ZLc0AAAAi/dragons-crown-fighter.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/5/5e/DC_-_Fighter_-_02.png', 'https://atlus.com/dragonscrown/img/character/fighter/fightter_title.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownPortraits/fighter-portrait.png', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_fighter.jpg', 'https://atlus.com/dragonscrown/img/character/fighter_btn_off_en.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownWebp/Fighter_compressed.webp', 'https://atlus.com/dragonscrown/img/character/fighter/fighter_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_001_fighter.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_001_fighter_on.png', 'https://live.staticflickr.com/65535/53559805907_127109d953_k.jpg', 'https://www.4gamer.net/games/134/G013480/FC20130710001/TN/003.jpg', 'https://dragons-crown.com/resources/sprite/character/fighter1.png', 'https://dragons-crown.com/resources/sprite/character/fighter1.json', 'https://live.staticflickr.com/65535/53571190116_a38531dd3d_k.jpg', 'https://live.staticflickr.com/65535/53679274498_a034bc0d7d_b.jpg');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`, `select_img_url`, `card_url`, `spritesheet_url`, `spritesheet_json_url`, `paper_url`, `alternate_art_url`) VALUES (2, 'Amazon', 'Dauntless warriors who know no fear as they effortlessly wield their two-handed weapons. Their massive equipment delivers vicious blows that deal lethal damage to multiple foes at once. Lightly armored, they are agile fighters who rely on punishing kicks when unarmed.', 'https://media.tenor.com/kJTtmhGQBXsAAAAi/amazon-idle-animation.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/c/cb/DC_-_Amazon_-_02.png', 'https://atlus.com/dragonscrown/img/character/amazon/amazon_title.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownPortraits/amazon-portrait.png', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_amazon.jpg', 'https://atlus.com/dragonscrown/img/character/amazon_btn_off_en.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownWebp/Amazon_compressed.webp', 'https://atlus.com/dragonscrown/img/character/amazon/amazon_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_002_amazon.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_002_amazon_on.png', 'https://live.staticflickr.com/65535/53560665141_6892bedb53_k.jpg', 'https://www.4gamer.net/games/134/G013480/FC20130716001/TN/003.jpg', 'https://dragons-crown.com/resources/sprite/character/amazon1.png', 'https://dragons-crown.com/resources/sprite/character/amazon1.json', 'https://live.staticflickr.com/65535/53571627250_4ef4b7fa9d_k.jpg', 'https://live.staticflickr.com/65535/53679409439_453b088da8_b.jpg');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`, `select_img_url`, `card_url`, `spritesheet_url`, `spritesheet_json_url`, `paper_url`, `alternate_art_url`) VALUES (3, 'Elf', 'A long-lived forest race who are often much older than they appear to human eyes. While slight of body, they are deadly masters of the bow and arrow, using their superior athleticism to fight nimbly and fearlessly from a distance.', 'https://static.wikia.nocookie.net/dragons-crown/images/4/4d/Dragon%27s_Crown_Elf_Walk.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/d/d7/DC_-_Elf_-_02.png', 'https://atlus.com/dragonscrown/img/character/elf/elf_title.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownPortraits/elf-portrait.png', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_elf.jpg', 'https://atlus.com/dragonscrown/img/character/elf_btn_off_en.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownWebp/Elf_compressed.webp', 'https://atlus.com/dragonscrown/img/character/elf/elf_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_004_elf.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_004_elf_on.png', 'https://live.staticflickr.com/65535/53561107830_2b00ea5700_k.jpg', 'https://www.4gamer.net/games/134/G013480/FC20130709002/TN/003.jpg', 'https://dragons-crown.com/resources/sprite/character/elf1.png', 'https://dragons-crown.com/resources/sprite/character/elf1.json', 'https://live.staticflickr.com/65535/53571190086_17b1d2cb04_k.jpg', 'https://live.staticflickr.com/65535/53679050631_0300f07c12_b.jpg');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`, `select_img_url`, `card_url`, `spritesheet_url`, `spritesheet_json_url`, `paper_url`, `alternate_art_url`) VALUES (4, 'Dwarf', 'Stocky fighters whose muscular frames permit them to wield a weapon in each hand. Their strength lets them pick up and throw anything in sight, even heavy foes. Throwing enemies lets them damage multiple foes with one fling, laying waste to an entire horde of adversaries.', 'https://media.tenor.com/GyLH0YOlbt8AAAAi/dragons-crown-vanillaware.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/a/a4/DC_-_Dwarf_-_02.png', 'https://atlus.com/dragonscrown/img/character/dwarf/dwarf_title.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownPortraits/dwarf-portrait.png', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_dwarf.jpg', 'https://atlus.com/dragonscrown/img/character/dwarf_btn_off_en.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownWebp/Dwarf_compressed.webp', 'https://atlus.com/dragonscrown/img/character/dwarf/dwarf_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_005_dwarf.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_005_dwarf_on.png', 'https://live.staticflickr.com/65535/53560863783_907aa2abd5_k.jpg', 'https://www.4gamer.net/games/134/G013480/FC20130712001/TN/003.jpg', 'https://dragons-crown.com/resources/sprite/character/dwarf1.png', 'https://dragons-crown.com/resources/sprite/character/dwarf1.json', 'https://live.staticflickr.com/65535/53571190111_b2d73663d9_k.jpg', 'https://live.staticflickr.com/65535/53679274533_bed1e67ce4_b.jpg');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`, `select_img_url`, `card_url`, `spritesheet_url`, `spritesheet_json_url`, `paper_url`, `alternate_art_url`) VALUES (5, 'Sorceress', 'Bewitching women with knowledge of dark magic. They are weak of body, but the great knowledge they wield of the arcane arts cannot be ignored. Sorceresses can create delicious food, control skeletons, and turn foes into harmless frogs. A jack-of-all-trades support class, they can provide aid to their friends in countless ways.', 'https://media.tenor.com/oRdmC7f9MM8AAAAi/sorceress-dragon-crown-sorceress.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/1/1d/Sorceress_lg.png', 'https://atlus.com/dragonscrown/img/character/sorceress/sorceress_title.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownPortraits/sorceress-portrait.png', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_sor.jpg', 'https://atlus.com/dragonscrown/img/character/sorceress_btn_off_en.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownWebp/Sorceress_compressed.webp', 'https://atlus.com/dragonscrown/img/character/sorceress/sorceress_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_006_sor.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_006_sor_on.png', 'https://live.staticflickr.com/65535/53561107835_ae19008670_k.jpg', 'https://www.4gamer.net/games/134/G013480/FC20130717009/TN/003.jpg', 'https://dragons-crown.com/resources/sprite/character/sorceress1.png', 'https://dragons-crown.com/resources/sprite/character/sorceress1.json', 'https://live.staticflickr.com/65535/53571190626_d943f413ba_k.jpg', 'https://live.staticflickr.com/65535/53679050616_d916f4899a_b.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`, `select_img_url`, `card_url`, `spritesheet_url`, `spritesheet_json_url`, `paper_url`, `alternate_art_url`) VALUES (6, 'Wizard', 'Male magicians who have a wealth of magic at their beck and call. Unable to fend off monsters with strength, they instead rely on their spells, and are vital assets for any adventure.', 'https://media.tenor.com/qeeXLLdeSTYAAAAi/dragons-crown-fantasy.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/e/e9/DC_-_Wizard_-_02.png', 'https://atlus.com/dragonscrown/img/character/wizard/wizard_title.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownPortraits/wizard-portrait.png', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_wiz.jpg', 'https://atlus.com/dragonscrown/img/character/wizard_btn_off_en.png', 'https://dragonscrown.s3.amazonaws.com/DragonsCrownWebp/Wizard_compressed.webp', 'https://atlus.com/dragonscrown/img/character/wizard/wizard_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_003_wiz.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_003_wiz_on.png', 'https://live.staticflickr.com/65535/53560665041_a1cc3f5c42_k.jpg', 'https://www.4gamer.net/games/134/G013480/FC20130717010/TN/003.jpg', 'https://dragons-crown.com/resources/sprite/character/wizard1.png', 'https://dragons-crown.com/resources/sprite/character/wizard1.json', 'https://live.staticflickr.com/65535/53571516114_dfb6230d45_k.jpg', 'https://live.staticflickr.com/65535/53678187127_a81e657fc6_b.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `class_stats`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (1, 1, 300, 16, 4, 14, 7, 12, 10, 0, 1, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (2, 2, 303, 18, 5, 16, 8, 13, 11, 850, 2, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (3, 3, 306, 19, 6, 18, 9, 14, 12, 1060, 3, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (4, 4, 310, 21, 7, 19, 10, 16, 13, 1490, 4, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (5, 5, 313, 23, 8, 21, 11, 17, 14, 1940, 5, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (6, 6, 317, 25, 8, 23, 12, 19, 16, 2400, 6, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (7, 7, 320, 27, 9, 25, 13, 20, 17, 2870, 7, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (8, 8, 324, 29, 10, 27, 15, 22, 18, 3350, 8, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (9, 9, 327, 31, 11, 29, 16, 24, 19, 3850, 9, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (10, 10, 331, 33, 11, 31, 17, 25, 20, 4370, 10, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (11, 11, 335, 35, 12, 33, 18, 27, 22, 4900, 11, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (12, 12, 338, 37, 13, 35, 19, 29, 23, 5450, 12, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (13, 13, 342, 40, 13, 37, 21, 31, 24, 6010, 13, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (14, 14, 346, 42, 14, 40, 22, 33, 26, 6590, 14, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (15, 15, 349, 44, 15, 42, 24, 35, 27, 7190, 15, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (16, 16, 353, 47, 16, 45, 26, 37, 29, 7810, 16, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (17, 17, 357, 50, 17, 47, 27, 39, 31, 8440, 17, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (18, 18, 361, 53, 18, 51, 29, 41, 33, 9340, 18, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (19, 19, 364, 56, 19, 54, 31, 43, 35, 10510, 19, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (20, 20, 368, 59, 20, 56, 33, 45, 37, 11800, 20, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (21, 21, 372, 62, 21, 59, 35, 47, 39, 13200, 21, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (22, 22, 375, 65, 23, 63, 37, 49, 41, 14740, 22, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (23, 23, 379, 69, 24, 66, 39, 51, 43, 16420, 23, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (24, 24, 382, 72, 25, 68, 41, 53, 45, 18260, 24, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (25, 25, 386, 75, 27, 71, 43, 56, 47, 20270, 25, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (26, 26, 389, 78, 27, 75, 45, 58, 49, 22460, 26, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (27, 27, 393, 82, 28, 78, 46, 61, 51, 24850, 27, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (28, 28, 396, 85, 29, 81, 49, 63, 53, 27450, 28, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (29, 29, 399, 88, 31, 84, 50, 66, 55, 30280, 29, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (30, 30, 402, 92, 32, 88, 52, 68, 57, 33370, 30, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (31, 31, 406, 95, 33, 91, 54, 71, 59, 36720, 31, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (32, 32, 409, 99, 34, 94, 55, 73, 62, 40370, 32, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (33, 33, 412, 102, 35, 97, 57, 76, 64, 44340, 33, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (34, 34, 415, 105, 36, 101, 58, 78, 66, 48650, 34, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (35, 35, 418, 109, 38, 104, 60, 81, 68, 53320, 35, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (36, 36, 420, 112, 39, 107, 62, 83, 70, 62950, 36, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (37, 37, 423, 115, 40, 110, 64, 86, 72, 68280, 37, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (38, 38, 426, 119, 40, 113, 66, 88, 74, 74000, 38, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (39, 39, 429, 122, 42, 116, 68, 91, 76, 80140, 39, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (40, 40, 431, 125, 43, 119, 70, 93, 78, 86740, 40, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (41, 41, 434, 128, 44, 122, 72, 95, 80, 93810, 41, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (42, 42, 436, 131, 46, 126, 74, 98, 82, 101390, 42, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (43, 43, 439, 135, 46, 128, 76, 100, 84, 109520, 43, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (44, 44, 441, 138, 47, 131, 78, 102, 86, 118230, 44, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (45, 45, 443, 141, 49, 134, 80, 105, 88, 127570, 45, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (46, 46, 445, 144, 50, 137, 82, 107, 90, 137570, 46, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (47, 47, 447, 147, 50, 140, 83, 109, 92, 148280, 47, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (48, 48, 449, 150, 51, 142, 85, 111, 93, 159740, 48, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (49, 49, 451, 152, 53, 145, 86, 114, 95, 172020, 49, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (50, 50, 453, 155, 54, 148, 88, 116, 97, 190020, 50, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (51, 51, 455, 158, 54, 151, 90, 118, 99, 205480, 51, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (52, 52, 457, 161, 56, 153, 92, 120, 100, 222110, 52, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (53, 53, 459, 163, 57, 156, 94, 122, 102, 239990, 53, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (54, 54, 461, 166, 57, 159, 95, 124, 104, 259200, 54, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (55, 55, 462, 168, 59, 161, 97, 126, 105, 279840, 55, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (56, 56, 464, 171, 59, 163, 99, 127, 107, 302020, 56, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (57, 57, 465, 173, 60, 165, 100, 129, 108, 325850, 57, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (58, 58, 467, 176, 61, 168, 102, 131, 110, 351430, 58, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (59, 59, 468, 178, 62, 171, 103, 133, 111, 378890, 59, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (60, 60, 470, 180, 63, 173, 105, 135, 113, 408380, 60, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (61, 61, 471, 183, 63, 174, 107, 136, 114, 440020, 61, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (62, 62, 472, 185, 65, 177, 108, 138, 115, 473970, 62, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (63, 63, 474, 187, 66, 179, 110, 140, 117, 510380, 63, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (64, 64, 475, 189, 66, 181, 111, 141, 118, 549450, 64, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (65, 65, 476, 191, 68, 183, 113, 143, 119, 591340, 65, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (66, 66, 477, 193, 68, 186, 115, 144, 121, 680460, 66, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (67, 67, 478, 195, 69, 187, 116, 146, 122, 732280, 67, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (68, 68, 479, 197, 69, 189, 117, 147, 123, 787850, 68, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (69, 69, 480, 199, 70, 191, 118, 148, 124, 847430, 69, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (70, 70, 481, 201, 71, 193, 120, 150, 125, 911290, 70, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (71, 71, 482, 202, 71, 195, 122, 151, 126, 979730, 71, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (72, 72, 483, 204, 73, 196, 123, 152, 127, 1053070, 72, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (73, 73, 484, 206, 73, 198, 124, 154, 128, 1131650, 73, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (74, 74, 485, 207, 74, 200, 125, 155, 129, 1215830, 74, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (75, 75, 486, 209, 75, 201, 127, 156, 130, 1305990, 75, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (76, 76, 486, 210, 75, 203, 128, 157, 131, 1402550, 76, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (77, 77, 487, 212, 76, 204, 129, 158, 132, 1505940, 77, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (78, 78, 488, 213, 76, 206, 131, 159, 133, 1616630, 78, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (79, 79, 489, 215, 77, 207, 131, 160, 134, 1735120, 79, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (80, 80, 489, 216, 78, 209, 133, 161, 135, 1876490, 80, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (81, 81, 490, 217, 78, 210, 134, 162, 136, 2008370, 81, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (82, 82, 491, 219, 79, 212, 135, 163, 137, 2149120, 82, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (83, 83, 491, 220, 80, 213, 136, 164, 137, 2299330, 83, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (84, 84, 492, 221, 80, 214, 137, 165, 138, 2459610, 84, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (85, 85, 492, 222, 81, 215, 139, 166, 139, 2630620, 85, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (86, 86, 493, 223, 82, 217, 140, 167, 139, 2813050, 86, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (87, 87, 493, 224, 82, 218, 141, 168, 140, 3007640, 87, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (88, 88, 494, 225, 82, 219, 142, 168, 141, 3215180, 88, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (89, 89, 494, 227, 83, 220, 142, 169, 141, 3436490, 89, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (90, 90, 495, 228, 84, 222, 144, 170, 142, 3672470, 90, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (91, 91, 495, 228, 84, 223, 145, 171, 143, 3924070, 91, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (92, 92, 496, 229, 85, 223, 146, 171, 143, 4192270, 92, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (93, 93, 496, 230, 85, 224, 147, 172, 144, 4478160, 93, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (94, 94, 497, 231, 86, 226, 147, 173, 144, 4782850, 94, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (95, 95, 497, 232, 87, 227, 149, 173, 145, 5107550, 95, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (96, 96, 498, 233, 87, 227, 150, 174, 145, 5453550, 96, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (97, 97, 498, 234, 88, 228, 151, 175, 146, 5822190, 97, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (98, 98, 499, 234, 88, 230, 152, 175, 146, 6214910, 98, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (99, 99, 500, 235, 89, 230, 152, 176, 147, 6736730, 99, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (100, 1, 300, 14, 7, 10, 8, 11, 13, 0, 1, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (101, 2, 303, 15, 8, 11, 9, 12, 14, 850, 2, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (102, 3, 306, 17, 8, 12, 10, 13, 16, 1060, 3, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (103, 4, 310, 18, 9, 13, 11, 15, 17, 1490, 4, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (104, 5, 313, 20, 10, 14, 12, 16, 19, 1940, 5, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (105, 6, 317, 22, 11, 16, 13, 17, 20, 2400, 6, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (106, 7, 320, 24, 12, 17, 16, 19, 22, 2870, 7, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (107, 8, 324, 26, 13, 19, 17, 20, 23, 3350, 8, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (108, 9, 327, 28, 14, 21, 19, 22, 25, 3850, 9, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (109, 10, 331, 30, 15, 23, 20, 23, 27, 4370, 10, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (110, 11, 335, 32, 16, 25, 22, 25, 29, 4900, 11, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (111, 12, 338, 34, 17, 26, 23, 26, 31, 5450, 12, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (112, 13, 342, 36, 18, 29, 26, 28, 33, 6010, 13, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (113, 14, 346, 38, 19, 31, 27, 29, 35, 6590, 14, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (114, 15, 349, 40, 20, 32, 30, 31, 37, 7190, 15, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (115, 16, 353, 42, 21, 35, 31, 32, 39, 7810, 16, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (116, 17, 357, 44, 22, 37, 33, 34, 41, 8440, 17, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (117, 18, 361, 46, 23, 39, 35, 36, 43, 9340, 18, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (118, 19, 364, 49, 25, 42, 37, 38, 45, 10510, 19, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (119, 20, 368, 51, 26, 44, 39, 40, 47, 11800, 20, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (120, 21, 372, 54, 27, 46, 42, 42, 50, 13200, 21, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (121, 22, 375, 57, 29, 49, 43, 44, 52, 14740, 22, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (122, 23, 379, 60, 30, 51, 46, 46, 55, 16420, 23, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (123, 24, 382, 62, 32, 53, 47, 48, 58, 18260, 24, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (124, 25, 386, 65, 33, 56, 50, 51, 60, 20270, 25, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (125, 26, 389, 68, 35, 58, 52, 53, 63, 22460, 26, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (126, 27, 393, 71, 36, 60, 54, 55, 66, 24850, 27, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (127, 28, 396, 74, 38, 63, 56, 58, 69, 27450, 28, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (128, 29, 399, 77, 39, 65, 59, 60, 71, 30280, 29, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (129, 30, 402, 80, 41, 68, 60, 62, 74, 33370, 30, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (130, 31, 406, 83, 42, 70, 63, 65, 77, 36720, 31, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (131, 32, 409, 86, 43, 73, 65, 67, 80, 40370, 32, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (132, 33, 412, 89, 45, 76, 67, 69, 82, 44340, 33, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (133, 34, 415, 92, 46, 78, 69, 71, 85, 48650, 34, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (134, 35, 418, 95, 48, 80, 72, 74, 88, 53320, 35, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (135, 36, 420, 98, 49, 83, 74, 76, 90, 62950, 36, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (136, 37, 423, 101, 51, 85, 76, 78, 93, 68280, 37, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (137, 38, 426, 103, 52, 87, 78, 81, 96, 74000, 38, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (138, 39, 429, 106, 54, 90, 80, 83, 98, 80140, 39, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (139, 40, 431, 109, 55, 92, 82, 85, 101, 86740, 40, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (140, 41, 434, 112, 56, 94, 85, 87, 104, 93810, 41, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (141, 42, 436, 115, 58, 97, 86, 89, 106, 101390, 42, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (142, 43, 439, 117, 59, 99, 89, 92, 109, 109520, 43, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (143, 44, 441, 120, 61, 101, 90, 94, 111, 118230, 44, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (144, 45, 443, 123, 62, 104, 93, 96, 114, 127570, 45, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (145, 46, 445, 125, 63, 106, 94, 98, 116, 137570, 46, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (146, 47, 447, 128, 64, 108, 97, 100, 119, 148280, 47, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (147, 48, 449, 130, 66, 110, 98, 102, 121, 159740, 48, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (148, 49, 451, 133, 67, 112, 101, 104, 123, 172020, 49, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (149, 50, 453, 135, 68, 115, 102, 106, 126, 190020, 50, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (150, 51, 455, 138, 69, 117, 104, 108, 128, 205480, 51, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (151, 52, 457, 140, 71, 118, 106, 110, 130, 222110, 52, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (152, 53, 459, 143, 72, 121, 108, 111, 132, 239990, 53, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (153, 54, 461, 145, 73, 123, 109, 113, 134, 259200, 54, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (154, 55, 462, 147, 74, 124, 112, 115, 136, 279840, 55, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (155, 56, 464, 149, 75, 127, 113, 117, 138, 302020, 56, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (156, 57, 465, 151, 76, 128, 115, 118, 140, 325850, 57, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (157, 58, 467, 153, 77, 130, 116, 120, 142, 351430, 58, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (158, 59, 468, 156, 78, 132, 119, 122, 144, 378890, 59, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (159, 60, 470, 158, 79, 134, 120, 123, 146, 408380, 60, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (160, 61, 471, 159, 80, 135, 122, 125, 148, 440020, 61, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (161, 62, 472, 161, 81, 137, 123, 126, 150, 473970, 62, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (162, 63, 474, 163, 82, 139, 125, 128, 151, 510380, 63, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (163, 64, 475, 165, 83, 140, 126, 129, 153, 549450, 64, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (164, 65, 476, 167, 84, 142, 128, 130, 155, 591340, 65, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (165, 66, 477, 169, 85, 144, 129, 132, 156, 680460, 66, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (166, 67, 478, 170, 86, 145, 131, 133, 158, 732280, 67, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (167, 68, 479, 172, 86, 147, 132, 134, 159, 787850, 68, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (168, 69, 480, 174, 87, 148, 134, 136, 161, 847430, 69, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (169, 70, 481, 175, 88, 150, 135, 137, 162, 911290, 70, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (170, 71, 482, 177, 89, 151, 137, 138, 164, 979730, 71, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (171, 72, 483, 178, 90, 152, 138, 139, 165, 1053070, 72, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (172, 73, 484, 180, 90, 154, 139, 140, 167, 1131650, 73, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (173, 74, 485, 181, 91, 155, 140, 142, 168, 1215830, 74, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (174, 75, 486, 182, 92, 156, 142, 143, 169, 1305990, 75, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (175, 76, 486, 184, 92, 158, 143, 144, 170, 1402550, 76, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (176, 77, 487, 185, 93, 159, 144, 145, 172, 1505940, 77, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (177, 78, 488, 186, 94, 160, 145, 146, 173, 1616630, 78, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (178, 79, 489, 187, 94, 162, 147, 147, 174, 1735120, 79, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (179, 80, 489, 189, 95, 163, 148, 148, 175, 1876490, 80, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (180, 81, 490, 190, 95, 164, 149, 148, 176, 2008370, 81, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (181, 82, 491, 191, 96, 166, 150, 149, 177, 2149120, 82, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (182, 83, 491, 192, 96, 166, 151, 150, 178, 2299330, 83, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (183, 84, 492, 193, 97, 167, 152, 151, 179, 2459610, 84, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (184, 85, 492, 194, 98, 169, 154, 152, 180, 2630620, 85, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (185, 86, 493, 195, 98, 169, 154, 153, 181, 2813050, 86, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (186, 87, 493, 196, 99, 170, 156, 153, 182, 3007640, 87, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (187, 88, 494, 197, 99, 172, 156, 154, 183, 3215180, 88, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (188, 89, 494, 198, 99, 172, 158, 155, 183, 3436490, 89, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (189, 90, 495, 199, 100, 174, 158, 155, 184, 3672470, 90, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (190, 91, 495, 200, 100, 175, 160, 156, 185, 3924070, 91, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (191, 92, 496, 200, 101, 175, 160, 157, 186, 4192270, 92, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (192, 93, 496, 201, 101, 176, 161, 157, 187, 4478160, 93, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (193, 94, 497, 202, 101, 177, 162, 158, 187, 4782850, 94, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (194, 95, 497, 203, 102, 178, 163, 159, 188, 5107550, 95, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (195, 96, 498, 203, 102, 179, 164, 159, 189, 5453550, 96, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (196, 97, 498, 204, 103, 180, 165, 160, 189, 5822190, 97, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (197, 98, 499, 205, 103, 181, 166, 160, 190, 6214910, 98, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (198, 99, 500, 205, 103, 182, 167, 161, 191, 6736730, 99, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (199, 1, 300, 11, 8, 7, 8, 13, 15, 0, 1, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (200, 2, 303, 12, 10, 8, 10, 14, 16, 850, 2, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (201, 3, 306, 13, 12, 9, 12, 17, 18, 1060, 3, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (202, 4, 310, 15, 13, 10, 14, 18, 19, 1490, 4, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (203, 5, 313, 17, 15, 12, 15, 20, 21, 1940, 5, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (204, 6, 317, 18, 17, 14, 16, 21, 23, 2400, 6, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (205, 7, 320, 20, 19, 15, 18, 23, 25, 2870, 7, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (206, 8, 324, 21, 20, 17, 20, 26, 27, 3350, 8, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (207, 9, 327, 23, 23, 18, 21, 28, 30, 3850, 9, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (208, 10, 331, 24, 24, 20, 23, 30, 32, 4370, 10, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (209, 11, 335, 26, 27, 22, 25, 32, 35, 4900, 11, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (210, 12, 338, 28, 28, 23, 26, 34, 37, 5450, 12, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (211, 13, 342, 30, 31, 25, 28, 37, 40, 6010, 13, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (212, 14, 346, 31, 33, 26, 30, 39, 43, 6590, 14, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (213, 15, 349, 34, 35, 29, 33, 41, 46, 7190, 15, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (214, 16, 353, 36, 37, 31, 34, 44, 49, 7810, 16, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (215, 17, 357, 38, 40, 32, 36, 46, 52, 8440, 17, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (216, 18, 361, 40, 42, 34, 39, 49, 55, 9340, 18, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (217, 19, 364, 43, 45, 36, 40, 52, 59, 10510, 19, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (218, 20, 368, 46, 47, 38, 43, 54, 61, 11800, 20, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (219, 21, 372, 48, 50, 40, 46, 57, 65, 13200, 21, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (220, 22, 375, 51, 52, 42, 47, 59, 68, 14740, 22, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (221, 23, 379, 53, 55, 44, 50, 63, 72, 16420, 23, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (222, 24, 382, 55, 57, 46, 52, 66, 74, 18260, 24, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (223, 25, 386, 59, 60, 48, 55, 68, 78, 20270, 25, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (224, 26, 389, 61, 62, 51, 57, 71, 81, 22460, 26, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (225, 27, 393, 63, 65, 52, 59, 74, 85, 24850, 27, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (226, 28, 396, 66, 67, 55, 62, 78, 88, 27450, 28, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (227, 29, 399, 69, 70, 56, 64, 80, 92, 30280, 29, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (228, 30, 402, 71, 72, 59, 66, 83, 95, 33370, 30, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (229, 31, 406, 74, 75, 61, 69, 86, 99, 36720, 31, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (230, 32, 409, 77, 78, 62, 71, 89, 102, 40370, 32, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (231, 33, 412, 79, 81, 65, 73, 92, 106, 44340, 33, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (232, 34, 415, 81, 83, 66, 76, 95, 109, 48650, 34, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (233, 35, 418, 85, 86, 69, 79, 98, 113, 53320, 35, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (234, 36, 420, 87, 88, 71, 81, 100, 116, 62950, 36, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (235, 37, 423, 89, 91, 73, 83, 103, 120, 68280, 37, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (236, 38, 426, 92, 93, 75, 86, 107, 122, 74000, 38, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (237, 39, 429, 95, 96, 77, 87, 109, 126, 80140, 39, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (238, 40, 431, 97, 98, 79, 90, 112, 129, 86740, 40, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (239, 41, 434, 99, 101, 81, 93, 115, 133, 93810, 41, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (240, 42, 436, 102, 103, 83, 94, 117, 136, 101390, 42, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (241, 43, 439, 105, 106, 85, 97, 121, 139, 109520, 43, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (242, 44, 441, 107, 108, 87, 99, 123, 142, 118230, 44, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (243, 45, 443, 110, 111, 89, 102, 126, 146, 127570, 45, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (244, 46, 445, 112, 113, 91, 103, 128, 148, 137570, 46, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (245, 47, 447, 114, 116, 92, 106, 131, 152, 148280, 47, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (246, 48, 449, 116, 117, 95, 108, 134, 154, 159740, 48, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (247, 49, 451, 119, 120, 96, 110, 136, 158, 172020, 49, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (248, 50, 453, 121, 122, 98, 112, 139, 160, 190020, 50, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (249, 51, 455, 123, 125, 100, 114, 141, 164, 205480, 51, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (250, 52, 457, 126, 126, 102, 116, 143, 166, 222110, 52, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (251, 53, 459, 127, 129, 104, 118, 146, 170, 239990, 53, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (252, 54, 461, 129, 131, 105, 120, 148, 172, 259200, 54, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (253, 55, 462, 132, 133, 107, 123, 150, 175, 279840, 55, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (254, 56, 464, 134, 135, 109, 124, 152, 177, 302020, 56, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (255, 57, 465, 135, 137, 110, 126, 154, 180, 325850, 57, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (256, 58, 467, 137, 139, 112, 128, 157, 182, 351430, 58, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (257, 59, 468, 140, 141, 113, 130, 159, 186, 378890, 59, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (258, 60, 470, 141, 143, 115, 132, 161, 188, 408380, 60, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (259, 61, 471, 143, 145, 117, 134, 163, 190, 440020, 61, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (260, 62, 472, 145, 146, 118, 135, 165, 192, 473970, 62, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (261, 63, 474, 147, 149, 120, 137, 167, 195, 510380, 63, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (262, 64, 475, 148, 150, 121, 139, 169, 197, 549450, 64, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (263, 65, 476, 150, 152, 123, 141, 171, 200, 591340, 65, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (264, 66, 477, 152, 154, 125, 142, 172, 202, 680460, 66, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (265, 67, 478, 153, 156, 126, 144, 174, 204, 732280, 67, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (266, 68, 479, 154, 157, 127, 146, 176, 206, 787850, 68, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (267, 69, 480, 157, 159, 128, 147, 178, 209, 847430, 69, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (268, 70, 481, 158, 160, 130, 149, 179, 210, 911290, 70, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (269, 71, 482, 159, 162, 132, 151, 181, 213, 979730, 71, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (270, 72, 483, 161, 163, 133, 152, 182, 214, 1053070, 72, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (271, 73, 484, 162, 165, 134, 153, 185, 217, 1131650, 73, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (272, 74, 485, 164, 166, 135, 155, 186, 218, 1215830, 74, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (273, 75, 486, 166, 168, 137, 157, 187, 220, 1305990, 75, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (274, 76, 486, 167, 169, 138, 158, 188, 222, 1402550, 76, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (275, 77, 487, 168, 171, 139, 159, 190, 224, 1505940, 77, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (276, 78, 488, 169, 172, 141, 161, 192, 225, 1616630, 78, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (277, 79, 489, 171, 174, 141, 162, 193, 227, 1735120, 79, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (278, 80, 489, 172, 175, 143, 164, 194, 229, 1876490, 80, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (279, 81, 490, 172, 177, 144, 165, 195, 231, 2008370, 81, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (280, 82, 491, 174, 178, 145, 166, 196, 232, 2149120, 82, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (281, 83, 491, 175, 179, 146, 167, 198, 234, 2299330, 83, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (282, 84, 492, 176, 180, 147, 169, 199, 235, 2459610, 84, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (283, 85, 492, 178, 182, 149, 171, 200, 237, 2630620, 85, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (284, 86, 493, 179, 182, 150, 171, 201, 238, 2813050, 86, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (285, 87, 493, 179, 184, 151, 173, 202, 240, 3007640, 87, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (286, 88, 494, 180, 185, 152, 174, 204, 241, 3215180, 88, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (287, 89, 494, 182, 186, 152, 175, 204, 243, 3436490, 89, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (288, 90, 495, 182, 187, 154, 176, 205, 244, 3672470, 90, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (289, 91, 495, 183, 189, 155, 178, 206, 246, 3924070, 91, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (290, 92, 496, 185, 189, 156, 178, 207, 246, 4192270, 92, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (291, 93, 496, 185, 191, 157, 180, 209, 248, 4478160, 93, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (292, 94, 497, 186, 191, 157, 181, 209, 249, 4782850, 94, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (293, 95, 497, 188, 193, 159, 183, 210, 251, 5107550, 95, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (294, 96, 498, 188, 193, 160, 183, 211, 251, 5453550, 96, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (295, 97, 498, 189, 195, 161, 184, 211, 253, 5822190, 97, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (296, 98, 499, 190, 196, 162, 185, 213, 254, 6214910, 98, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (297, 99, 500, 191, 197, 162, 186, 214, 255, 6736730, 99, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (298, 1, 300, 18, 3, 16, 6, 8, 12, 0, 1, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (299, 2, 303, 20, 3, 18, 7, 9, 13, 850, 2, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (300, 3, 306, 22, 4, 19, 8, 10, 14, 1060, 3, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (301, 4, 310, 24, 4, 21, 9, 11, 15, 1490, 4, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (302, 5, 313, 26, 4, 23, 10, 12, 16, 1940, 5, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (303, 6, 317, 28, 5, 25, 11, 13, 18, 2400, 6, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (304, 7, 320, 30, 5, 27, 13, 15, 19, 2870, 7, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (305, 8, 324, 32, 5, 29, 14, 16, 21, 3350, 8, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (306, 9, 327, 34, 6, 31, 16, 18, 23, 3850, 9, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (307, 10, 331, 36, 6, 33, 17, 19, 24, 4370, 10, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (308, 11, 335, 38, 7, 35, 19, 20, 26, 4900, 11, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (309, 12, 338, 41, 7, 37, 20, 22, 28, 5450, 12, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (310, 13, 342, 43, 8, 40, 22, 24, 30, 6010, 13, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (311, 14, 346, 46, 8, 42, 23, 25, 32, 6590, 14, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (312, 15, 349, 48, 9, 45, 25, 27, 34, 7190, 15, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (313, 16, 353, 51, 9, 47, 26, 28, 36, 7810, 16, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (314, 17, 357, 53, 10, 50, 28, 29, 38, 8440, 17, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (315, 18, 361, 56, 10, 53, 29, 31, 40, 9340, 18, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (316, 19, 364, 59, 11, 56, 31, 33, 42, 10510, 19, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (317, 20, 368, 62, 12, 59, 32, 35, 44, 11800, 20, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (318, 21, 372, 65, 12, 62, 34, 37, 46, 13200, 21, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (319, 22, 375, 68, 13, 65, 36, 39, 48, 14740, 22, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (320, 23, 379, 71, 13, 69, 38, 41, 51, 16420, 23, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (321, 24, 382, 74, 14, 72, 39, 42, 53, 18260, 24, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (322, 25, 386, 78, 15, 75, 41, 45, 56, 20270, 25, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (323, 26, 389, 82, 15, 78, 43, 47, 58, 22460, 26, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (324, 27, 393, 85, 16, 82, 45, 48, 61, 24850, 27, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (325, 28, 396, 88, 17, 85, 46, 50, 63, 27450, 28, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (326, 29, 399, 92, 17, 88, 48, 53, 66, 30280, 29, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (327, 30, 402, 95, 18, 92, 50, 54, 68, 33370, 30, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (328, 31, 406, 99, 18, 95, 52, 56, 71, 36720, 31, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (329, 32, 409, 102, 19, 99, 53, 59, 73, 40370, 32, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (330, 33, 412, 106, 20, 102, 55, 60, 76, 44340, 33, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (331, 34, 415, 110, 20, 105, 57, 62, 78, 48650, 34, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (332, 35, 418, 114, 21, 109, 59, 65, 81, 53320, 35, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (333, 36, 420, 117, 22, 112, 60, 67, 83, 62950, 36, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (334, 37, 423, 121, 22, 115, 62, 68, 86, 68280, 37, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (335, 38, 426, 125, 23, 119, 64, 70, 88, 74000, 38, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (336, 39, 429, 128, 23, 122, 66, 72, 91, 80140, 39, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (337, 40, 431, 132, 24, 125, 67, 74, 93, 86740, 40, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (338, 41, 434, 136, 25, 128, 69, 76, 95, 93810, 41, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (339, 42, 436, 139, 25, 131, 70, 78, 98, 101390, 42, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (340, 43, 439, 143, 26, 135, 73, 80, 100, 109520, 43, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (341, 44, 441, 146, 26, 138, 74, 81, 102, 118230, 44, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (342, 45, 443, 150, 27, 141, 76, 84, 105, 127570, 45, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (343, 46, 445, 153, 27, 144, 77, 85, 107, 137570, 46, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (344, 47, 447, 156, 28, 147, 79, 87, 109, 148280, 47, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (345, 48, 449, 160, 29, 150, 80, 88, 111, 159740, 48, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (346, 49, 451, 163, 29, 152, 82, 91, 114, 172020, 49, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (347, 50, 453, 166, 30, 155, 83, 92, 116, 190020, 50, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (348, 51, 455, 169, 30, 158, 85, 93, 118, 205480, 51, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (349, 52, 457, 172, 31, 161, 86, 96, 120, 222110, 52, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (350, 53, 459, 175, 31, 163, 88, 97, 122, 239990, 53, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (351, 54, 461, 178, 32, 166, 89, 98, 124, 259200, 54, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (352, 55, 462, 181, 32, 168, 91, 101, 126, 279840, 55, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (353, 56, 464, 184, 33, 171, 92, 102, 127, 302020, 56, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (354, 57, 465, 186, 33, 173, 94, 103, 129, 325850, 57, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (355, 58, 467, 189, 34, 176, 95, 104, 131, 351430, 58, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (356, 59, 468, 192, 34, 178, 97, 107, 133, 378890, 59, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (357, 60, 470, 194, 34, 180, 98, 108, 135, 408380, 60, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (358, 61, 471, 197, 35, 183, 100, 109, 136, 440020, 61, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (359, 62, 472, 199, 35, 185, 100, 111, 138, 473970, 62, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (360, 63, 474, 202, 36, 187, 102, 112, 140, 510380, 63, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (361, 64, 475, 204, 36, 189, 103, 113, 141, 549450, 64, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (362, 65, 476, 206, 36, 191, 105, 115, 143, 591340, 65, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (363, 66, 477, 209, 37, 193, 106, 116, 144, 680460, 66, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (364, 67, 478, 211, 37, 195, 107, 117, 146, 732280, 67, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (365, 68, 479, 213, 37, 197, 108, 118, 147, 787850, 68, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (366, 69, 480, 215, 38, 199, 110, 120, 148, 847430, 69, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (367, 70, 481, 217, 38, 201, 110, 121, 150, 911290, 70, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (368, 71, 482, 219, 39, 202, 112, 122, 151, 979730, 71, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (369, 72, 483, 221, 39, 204, 113, 124, 152, 1053070, 72, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (370, 73, 484, 223, 39, 206, 114, 124, 154, 1131650, 73, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (371, 74, 485, 225, 39, 207, 115, 125, 155, 1215830, 74, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (372, 75, 486, 226, 40, 209, 116, 127, 156, 1305990, 75, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (373, 76, 486, 228, 40, 210, 117, 128, 157, 1402550, 76, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (374, 77, 487, 230, 40, 212, 119, 128, 158, 1505940, 77, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (375, 78, 488, 231, 41, 213, 119, 129, 159, 1616630, 78, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (376, 79, 489, 233, 41, 215, 121, 131, 160, 1735120, 79, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (377, 80, 489, 234, 41, 216, 121, 132, 161, 1876490, 80, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (378, 81, 490, 236, 41, 217, 123, 132, 162, 2008370, 81, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (379, 82, 491, 237, 42, 219, 123, 134, 163, 2149120, 82, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (380, 83, 491, 239, 42, 220, 125, 134, 164, 2299330, 83, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (381, 84, 492, 240, 42, 221, 125, 135, 165, 2459610, 84, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (382, 85, 492, 241, 42, 222, 126, 137, 166, 2630620, 85, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (383, 86, 493, 243, 42, 223, 127, 137, 167, 2813050, 86, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (384, 87, 493, 244, 43, 224, 128, 138, 168, 3007640, 87, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (385, 88, 494, 245, 43, 225, 129, 138, 168, 3215180, 88, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (386, 89, 494, 246, 43, 227, 130, 140, 169, 3436490, 89, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (387, 90, 495, 247, 43, 228, 130, 140, 170, 3672470, 90, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (388, 91, 495, 248, 43, 228, 132, 141, 171, 3924070, 91, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (389, 92, 496, 249, 44, 229, 132, 142, 171, 4192270, 92, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (390, 93, 496, 251, 44, 230, 133, 143, 172, 4478160, 93, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (391, 94, 497, 251, 44, 231, 134, 143, 173, 4782850, 94, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (392, 95, 497, 252, 44, 232, 135, 144, 173, 5107550, 95, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (393, 96, 498, 253, 44, 233, 135, 145, 174, 5453550, 96, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (394, 97, 498, 254, 44, 234, 136, 145, 175, 5822190, 97, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (395, 98, 499, 255, 45, 234, 137, 146, 175, 6214910, 98, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (396, 99, 500, 255, 45, 235, 138, 147, 176, 6736730, 99, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (397, 1, 300, 3, 14, 5, 18, 10, 13, 0, 1, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (398, 2, 303, 3, 16, 6, 20, 11, 14, 850, 2, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (399, 3, 306, 4, 18, 7, 22, 12, 15, 1060, 3, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (400, 4, 310, 4, 20, 9, 24, 13, 16, 1490, 4, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (401, 5, 313, 5, 22, 10, 26, 15, 18, 1940, 5, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (402, 6, 317, 6, 24, 11, 28, 16, 19, 2400, 6, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (403, 7, 320, 6, 26, 12, 30, 17, 21, 2870, 7, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (404, 8, 324, 6, 28, 14, 32, 18, 23, 3350, 8, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (405, 9, 327, 7, 30, 15, 34, 20, 25, 3850, 9, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (406, 10, 331, 7, 32, 17, 36, 21, 27, 4370, 10, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (407, 11, 335, 8, 34, 18, 38, 22, 29, 4900, 11, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (408, 12, 338, 8, 36, 19, 40, 23, 31, 5450, 12, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (409, 13, 342, 9, 38, 21, 42, 25, 33, 6010, 13, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (410, 14, 346, 9, 41, 22, 45, 27, 35, 6590, 14, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (411, 15, 349, 10, 43, 24, 47, 29, 37, 7190, 15, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (412, 16, 353, 10, 45, 25, 50, 31, 40, 7810, 16, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (413, 17, 357, 11, 47, 27, 52, 33, 42, 8440, 17, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (414, 18, 361, 11, 50, 28, 55, 35, 44, 9340, 18, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (415, 19, 364, 12, 52, 29, 58, 37, 46, 10510, 19, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (416, 20, 368, 13, 54, 31, 61, 39, 48, 11800, 20, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (417, 21, 372, 13, 57, 33, 64, 41, 51, 13200, 21, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (418, 22, 375, 14, 59, 34, 67, 43, 53, 14740, 22, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (419, 23, 379, 14, 62, 36, 70, 45, 55, 16420, 23, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (420, 24, 382, 15, 64, 38, 74, 47, 58, 18260, 24, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (421, 25, 386, 17, 67, 40, 77, 50, 60, 20270, 25, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (422, 26, 389, 17, 70, 41, 81, 52, 63, 22460, 26, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (423, 27, 393, 18, 73, 43, 84, 54, 66, 24850, 27, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (424, 28, 396, 19, 76, 46, 88, 56, 69, 27450, 28, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (425, 29, 399, 19, 79, 47, 91, 58, 71, 30280, 29, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (426, 30, 402, 20, 82, 49, 95, 60, 74, 33370, 30, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (427, 31, 406, 20, 85, 51, 99, 62, 77, 36720, 31, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (428, 32, 409, 21, 88, 52, 102, 65, 80, 40370, 32, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (429, 33, 412, 22, 92, 54, 106, 67, 82, 44340, 33, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (430, 34, 415, 22, 95, 56, 110, 69, 85, 48650, 34, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (431, 35, 418, 24, 98, 58, 114, 72, 88, 53320, 35, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (432, 36, 420, 25, 101, 59, 117, 74, 90, 62950, 36, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (433, 37, 423, 25, 104, 61, 121, 76, 93, 68280, 37, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (434, 38, 426, 26, 107, 63, 125, 78, 96, 74000, 38, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (435, 39, 429, 26, 110, 64, 128, 80, 98, 80140, 39, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (436, 40, 431, 27, 113, 66, 132, 82, 101, 86740, 40, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (437, 41, 434, 28, 116, 68, 136, 84, 104, 93810, 41, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (438, 42, 436, 28, 119, 69, 139, 86, 106, 101390, 42, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (439, 43, 439, 29, 122, 71, 143, 88, 109, 109520, 43, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (440, 44, 441, 29, 125, 73, 146, 90, 111, 118230, 44, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (441, 45, 443, 31, 128, 75, 150, 93, 114, 127570, 45, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (442, 46, 445, 31, 131, 76, 153, 95, 116, 137570, 46, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (443, 47, 447, 32, 134, 78, 156, 97, 119, 148280, 47, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (444, 48, 449, 33, 137, 80, 160, 98, 121, 159740, 48, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (445, 49, 451, 33, 140, 81, 163, 100, 123, 172020, 49, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (446, 50, 453, 34, 143, 82, 166, 102, 126, 190020, 50, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (447, 51, 455, 34, 146, 84, 169, 104, 128, 205480, 51, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (448, 52, 457, 35, 148, 85, 172, 105, 130, 222110, 52, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (449, 53, 459, 35, 151, 87, 175, 107, 132, 239990, 53, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (450, 54, 461, 36, 153, 89, 178, 109, 134, 259200, 54, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (451, 55, 462, 37, 156, 91, 181, 111, 136, 279840, 55, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (452, 56, 464, 38, 158, 91, 184, 113, 138, 302020, 56, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (453, 57, 465, 38, 160, 93, 186, 114, 140, 325850, 57, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (454, 58, 467, 39, 163, 95, 189, 116, 142, 351430, 58, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (455, 59, 468, 39, 166, 96, 192, 117, 144, 378890, 59, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (456, 60, 470, 39, 168, 97, 194, 119, 146, 408380, 60, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (457, 61, 471, 40, 170, 99, 197, 120, 148, 440020, 61, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (458, 62, 472, 40, 172, 100, 199, 121, 150, 473970, 62, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (459, 63, 474, 41, 175, 101, 202, 123, 151, 510380, 63, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (460, 64, 475, 41, 177, 103, 204, 124, 153, 549450, 64, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (461, 65, 476, 42, 179, 105, 206, 126, 155, 591340, 65, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (462, 66, 477, 43, 181, 105, 209, 128, 156, 680460, 66, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (463, 67, 478, 43, 182, 107, 211, 129, 158, 732280, 67, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (464, 68, 479, 43, 185, 108, 213, 130, 159, 787850, 68, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (465, 69, 480, 44, 187, 109, 214, 131, 161, 847430, 69, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (466, 70, 481, 44, 188, 111, 217, 132, 162, 911290, 70, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (467, 71, 482, 45, 190, 112, 219, 133, 164, 979730, 71, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (468, 72, 483, 45, 192, 113, 221, 134, 165, 1053070, 72, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (469, 73, 484, 45, 195, 114, 223, 135, 167, 1131650, 73, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (470, 74, 485, 45, 196, 116, 225, 136, 168, 1215830, 74, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (471, 75, 486, 47, 197, 117, 226, 138, 169, 1305990, 75, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (472, 76, 486, 47, 199, 118, 228, 139, 170, 1402550, 76, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (473, 77, 487, 47, 200, 119, 230, 140, 172, 1505940, 77, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (474, 78, 488, 48, 202, 121, 231, 141, 173, 1616630, 78, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (475, 79, 489, 48, 203, 121, 233, 142, 174, 1735120, 79, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (476, 80, 489, 48, 205, 122, 234, 143, 175, 1876490, 80, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (477, 81, 490, 48, 206, 124, 236, 144, 176, 2008370, 81, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (478, 82, 491, 49, 207, 124, 237, 145, 177, 2149120, 82, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (479, 83, 491, 49, 209, 126, 239, 145, 178, 2299330, 83, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (480, 84, 492, 49, 210, 127, 240, 146, 179, 2459610, 84, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (481, 85, 492, 50, 211, 128, 241, 148, 180, 2630620, 85, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (482, 86, 493, 50, 212, 129, 243, 148, 181, 2813050, 86, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (483, 87, 493, 51, 213, 130, 244, 149, 182, 3007640, 87, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (484, 88, 494, 51, 215, 131, 245, 150, 183, 3215180, 88, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (485, 89, 494, 51, 216, 132, 246, 150, 183, 3436490, 89, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (486, 90, 495, 51, 217, 133, 247, 151, 184, 3672470, 90, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (487, 91, 495, 51, 218, 134, 248, 152, 185, 3924070, 91, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (488, 92, 496, 52, 218, 135, 249, 152, 186, 4192270, 92, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (489, 93, 496, 52, 220, 136, 251, 153, 187, 4478160, 93, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (490, 94, 497, 52, 221, 137, 251, 153, 187, 4782850, 94, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (491, 95, 497, 53, 222, 138, 252, 155, 188, 5107550, 95, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (492, 96, 498, 53, 222, 139, 253, 155, 189, 5453550, 96, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (493, 97, 498, 53, 223, 140, 254, 156, 189, 5822190, 97, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (494, 98, 499, 54, 224, 141, 255, 156, 190, 6214910, 98, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (495, 99, 500, 54, 225, 142, 255, 157, 191, 6736730, 99, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (496, 1, 300, 6, 18, 8, 13, 12, 6, 0, 1, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (497, 2, 303, 7, 20, 9, 14, 13, 7, 850, 2, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (498, 3, 306, 8, 22, 11, 16, 14, 7, 1060, 3, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (499, 4, 310, 9, 24, 12, 17, 16, 8, 1490, 4, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (500, 5, 313, 10, 26, 13, 19, 17, 9, 1940, 5, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (501, 6, 317, 10, 28, 15, 20, 19, 9, 2400, 6, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (502, 7, 320, 11, 30, 16, 22, 20, 10, 2870, 7, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (503, 8, 324, 12, 33, 18, 24, 22, 11, 3350, 8, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (504, 9, 327, 13, 35, 20, 26, 24, 12, 3850, 9, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (505, 10, 331, 14, 38, 22, 28, 25, 13, 4370, 10, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (506, 11, 335, 15, 40, 24, 30, 27, 14, 4900, 11, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (507, 12, 338, 16, 43, 25, 32, 29, 15, 5450, 12, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (508, 13, 342, 18, 45, 27, 34, 31, 16, 6010, 13, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (509, 14, 346, 19, 48, 29, 36, 33, 17, 6590, 14, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (510, 15, 349, 20, 50, 31, 38, 35, 18, 7190, 15, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (511, 16, 353, 21, 53, 33, 41, 37, 19, 7810, 16, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (512, 17, 357, 22, 55, 35, 43, 39, 20, 8440, 17, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (513, 18, 361, 24, 59, 37, 46, 41, 21, 9340, 18, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (514, 19, 364, 25, 62, 39, 49, 43, 22, 10510, 19, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (515, 20, 368, 26, 65, 41, 51, 45, 23, 11800, 20, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (516, 21, 372, 27, 68, 43, 54, 47, 24, 13200, 21, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (517, 22, 375, 29, 71, 45, 56, 49, 25, 14740, 22, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (518, 23, 379, 31, 74, 47, 60, 51, 26, 16420, 23, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (519, 24, 382, 32, 77, 49, 63, 53, 27, 18260, 24, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (520, 25, 386, 33, 80, 52, 65, 56, 28, 20270, 25, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (521, 26, 389, 35, 83, 55, 68, 58, 30, 22460, 26, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (522, 27, 393, 36, 86, 56, 71, 61, 31, 24850, 27, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (523, 28, 396, 38, 90, 59, 75, 63, 32, 27450, 28, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (524, 29, 399, 39, 93, 61, 77, 66, 33, 30280, 29, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (525, 30, 402, 41, 97, 63, 80, 68, 35, 33370, 30, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (526, 31, 406, 42, 100, 66, 83, 71, 36, 36720, 31, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (527, 32, 409, 43, 103, 68, 86, 73, 37, 40370, 32, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (528, 33, 412, 45, 107, 70, 89, 76, 38, 44340, 33, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (529, 34, 415, 47, 110, 72, 92, 78, 40, 48650, 34, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (530, 35, 418, 48, 114, 75, 95, 81, 41, 53320, 35, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (531, 36, 420, 49, 117, 78, 97, 83, 42, 62950, 36, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (532, 37, 423, 50, 121, 79, 100, 86, 43, 68280, 37, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (533, 38, 426, 53, 125, 82, 104, 88, 45, 74000, 38, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (534, 39, 429, 54, 128, 83, 106, 91, 46, 80140, 39, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (535, 40, 431, 55, 132, 86, 109, 93, 47, 86740, 40, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (536, 41, 434, 56, 136, 89, 112, 95, 48, 93810, 41, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (537, 42, 436, 57, 139, 90, 114, 98, 49, 101390, 42, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (538, 43, 439, 60, 143, 93, 118, 100, 51, 109520, 43, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (539, 44, 441, 61, 146, 94, 120, 102, 52, 118230, 44, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (540, 45, 443, 62, 150, 97, 123, 105, 53, 127570, 45, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (541, 46, 445, 63, 153, 99, 125, 107, 54, 137570, 46, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (542, 47, 447, 64, 156, 101, 128, 109, 55, 148280, 47, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (543, 48, 449, 66, 160, 103, 131, 111, 56, 159740, 48, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (544, 49, 451, 67, 163, 105, 133, 114, 57, 172020, 49, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (545, 50, 453, 68, 166, 107, 136, 116, 58, 190020, 50, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (546, 51, 455, 69, 169, 109, 138, 118, 59, 205480, 51, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (547, 52, 457, 70, 172, 111, 140, 120, 60, 222110, 52, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (548, 53, 459, 72, 175, 113, 143, 122, 61, 239990, 53, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (549, 54, 461, 73, 178, 114, 145, 124, 62, 259200, 54, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (550, 55, 462, 74, 181, 117, 147, 126, 63, 279840, 55, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (551, 56, 464, 75, 184, 119, 149, 127, 64, 302020, 56, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (552, 57, 465, 76, 186, 120, 151, 129, 65, 325850, 57, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (553, 58, 467, 78, 189, 122, 154, 131, 66, 351430, 58, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (554, 59, 468, 79, 192, 124, 156, 133, 67, 378890, 59, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (555, 60, 470, 80, 194, 126, 158, 135, 68, 408380, 60, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (556, 61, 471, 81, 197, 128, 160, 136, 69, 440020, 61, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (557, 62, 472, 81, 199, 129, 162, 138, 69, 473970, 62, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (558, 63, 474, 83, 202, 131, 164, 140, 70, 510380, 63, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (559, 64, 475, 84, 204, 132, 166, 141, 71, 549450, 64, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (560, 65, 476, 85, 206, 134, 168, 143, 72, 591340, 65, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (561, 66, 477, 86, 209, 136, 169, 144, 73, 680460, 66, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (562, 67, 478, 86, 211, 137, 171, 146, 73, 732280, 67, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (563, 68, 479, 88, 213, 139, 173, 147, 74, 787850, 68, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (564, 69, 480, 89, 215, 140, 175, 148, 75, 847430, 69, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (565, 70, 481, 89, 217, 142, 176, 150, 75, 911290, 70, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (566, 71, 482, 90, 219, 144, 178, 151, 76, 979730, 71, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (567, 72, 483, 91, 221, 145, 179, 152, 77, 1053070, 72, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (568, 73, 484, 92, 223, 146, 182, 154, 77, 1131650, 73, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (569, 74, 485, 93, 225, 147, 183, 155, 78, 1215830, 74, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (570, 75, 486, 93, 226, 149, 184, 156, 78, 1305990, 75, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (571, 76, 486, 94, 228, 151, 185, 157, 79, 1402550, 76, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (572, 77, 487, 95, 230, 151, 187, 158, 80, 1505940, 77, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (573, 78, 488, 96, 231, 153, 189, 159, 80, 1616630, 78, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (574, 79, 489, 97, 233, 154, 190, 160, 81, 1735120, 79, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (575, 80, 489, 97, 234, 156, 191, 161, 81, 1876490, 80, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (576, 81, 490, 98, 236, 157, 192, 162, 82, 2008370, 81, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (577, 82, 491, 98, 237, 158, 193, 163, 82, 2149120, 82, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (578, 83, 491, 100, 239, 159, 195, 164, 83, 2299330, 83, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (579, 84, 492, 100, 240, 160, 196, 165, 83, 2459610, 84, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (580, 85, 492, 100, 241, 162, 197, 166, 83, 2630620, 85, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (581, 86, 493, 101, 243, 163, 198, 167, 84, 2813050, 86, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (582, 87, 493, 101, 244, 164, 199, 168, 84, 3007640, 87, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (583, 88, 494, 103, 245, 165, 201, 168, 85, 3215180, 88, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (584, 89, 494, 103, 246, 166, 201, 169, 85, 3436490, 89, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (585, 90, 495, 103, 247, 167, 202, 170, 85, 3672470, 90, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (586, 91, 495, 104, 248, 169, 203, 171, 86, 3924070, 91, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (587, 92, 496, 104, 249, 169, 204, 171, 86, 4192270, 92, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (588, 93, 496, 106, 251, 171, 206, 172, 87, 4478160, 93, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (589, 94, 497, 106, 251, 171, 206, 173, 87, 4782850, 94, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (590, 95, 497, 106, 252, 173, 207, 173, 87, 5107550, 95, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (591, 96, 498, 106, 253, 174, 208, 174, 87, 5453550, 96, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (592, 97, 498, 107, 254, 174, 208, 175, 88, 5822190, 97, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (593, 98, 499, 108, 255, 175, 210, 175, 88, 6214910, 98, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `skill_points`, `player_class_id`) VALUES (594, 99, 500, 108, 255, 176, 211, 176, 88, 6736730, 99, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recommendation`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (1, 'I want to play as an orthodox warrior who wields a sword.', 1);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (2, 'I feel a sense of pleasure in cutting into the enemy\'s territory and attacking.', 1);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (3, 'I want to be a shield for my friends and protect the party.', 1);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (4, 'I don\'t like difficult controls, so I want to play easily.', 1);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (5, 'I like fighting close to my enemies.', 2);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (6, 'I want to wield a weapon on the front lines.', 2);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (7, 'I want to emphasize not only destructive power but also speed.', 2);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (8, 'Likes to attack constantly.', 2);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (9, 'I want to attack safely from a distance.', 3);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (10, 'I like characters that can move quickly.', 3);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (11, 'I want to support my allies.', 3);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (12, 'I want to technically use various attack methods.', 3);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (13, 'I want to use a character with high attack power.', 4);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (14, 'I want to perform flashy aerial combos involving throws.', 4);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (15, 'I want to stand on the front lines and defeat the enemy.', 4);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (16, 'I want to attack a wide range of enemies all at once.', 4);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (17, 'I want to attack safely from a distance.', 5);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (18, 'I want to support my allies.', 5);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (19, 'I want to play as a technical character.', 5);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (20, 'I want to defeat enemies all at once with a wide area attack.', 5);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (21, 'I like magic attacks more than weapons.', 6);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (22, 'Good at following allies fighting on the front lines.', 6);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (23, 'I like wide range attacks that involve many enemies.', 6);
INSERT INTO `recommendation` (`id`, `description`, `player_class_id`) VALUES (24, 'I find the technical character rewarding.', 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `stat_scaling`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `stat_scaling` (`id`, `strength`, `constitution`, `intelligence`, `magic_resistance`, `dexterity`, `luck`, `player_class_id`) VALUES (1, 'S', 'A', 'D', 'C', 'B', 'B', 1);
INSERT INTO `stat_scaling` (`id`, `strength`, `constitution`, `intelligence`, `magic_resistance`, `dexterity`, `luck`, `player_class_id`) VALUES (2, 'A', 'C', 'C', 'C', 'B', 'A', 2);
INSERT INTO `stat_scaling` (`id`, `strength`, `constitution`, `intelligence`, `magic_resistance`, `dexterity`, `luck`, `player_class_id`) VALUES (3, 'B', 'C', 'B', 'C', 'A', 'A', 3);
INSERT INTO `stat_scaling` (`id`, `strength`, `constitution`, `intelligence`, `magic_resistance`, `dexterity`, `luck`, `player_class_id`) VALUES (4, 'S', 'S', 'E', 'D', 'C', 'B', 4);
INSERT INTO `stat_scaling` (`id`, `strength`, `constitution`, `intelligence`, `magic_resistance`, `dexterity`, `luck`, `player_class_id`) VALUES (5, 'E', 'D', 'A', 'S', 'B', 'A', 5);
INSERT INTO `stat_scaling` (`id`, `strength`, `constitution`, `intelligence`, `magic_resistance`, `dexterity`, `luck`, `player_class_id`) VALUES (6, 'D', 'C', 'S', 'A', 'B', 'D', 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `skill`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (1, 'Slide Attack', 'Increased chance of taking enemy down\nwhen sliding (Down + Square).', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/003.jpg', 1);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (2, 'Wealth to Health', 'Recover HP when picking up coins.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/004.jpg', 1);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (3, 'Money is Power', 'Picking up coins adds to your score.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/005.jpg', 1);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (4, 'Vitality Boost', 'Increases your max HP.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/006.jpg', 1);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (5, 'Nutritionist', 'Increases the healing effectiveness of food.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/007.jpg', 1);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (6, 'Maintenance', 'Grants a chance that using a temporary weapon won\'t decrease its number of uses.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/008.jpg', 1);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (7, 'Adroit Hands', 'Reduces cooldown time in between using items.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/009.jpg', 1);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (8, 'Evasion', 'Increases the number of times you can evade.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/010.jpg', 1);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (9, 'Deep Pockets', 'Increases the number of slots in Bags.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/011.jpg', 1);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (10, 'Cyclone Masher', 'Increases duration of aerial attacks. Rapidly press square to activate.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/013.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (11, 'Shockwave', 'Pound the ground to ripple it with shocks. Activate with down＋square.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/014.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (12, 'Judgement', 'Add a shockwave to your downward stab attack. Press down＋square midair to activate.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/015.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (13, 'Rebuke', 'Power Smash and shockwave are strengthened. Press O on the ground.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/016.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (14, 'Tempest Edge', 'Creates a powerful storm of sword attacks by rapidly pressing square.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/017.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (15, 'Cover Allies', 'Hold square on the ground to use your shield to protect allies and temporarily increases your attack power', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/018.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (16, 'Reflex Guard', 'Grants a chance to automatically guard when attacked.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/019.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (17, 'Bash', 'Press square after blocking an attack to counterattack and stun with your shield.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/020.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (18, 'Reflect Missile', 'Grants a chance to reflect projectile weapons when guarding with your shield.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/021.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (19, 'Distraction', 'Calls enemies\' attention to yourself. Use the Skill Item Distraction.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/022.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (20, 'Sacrifice', 'Take damage inflicted on your allies. Use the Skill Item Sacrifice.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/023.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (21, 'Shield Tactics', 'Boost your shield\'s effectiveness and make it harder to be moved.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/024.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (22, 'Stun Wave', 'An aerial attack which combines a knockdown attack with a shockwave. down + square in midair to use.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/029.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (23, 'Neck Splitter', 'Double jump + down + square for a powerful downward strike.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/027.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (24, 'Deadly Revolution', 'Allows you to change direction in midair while spinning with □ (square) and then → (right) or ← (left) in midair.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/028.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (25, 'Brutal Drive', 'Power Smash and shockwaves are strengthened. Activate with ◯. ', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/026.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (26, 'Parry', 'Parry enemy attacks and add temporary invincibility. Hold square right before parrying.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/030.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (27, 'Punisher', 'Deal multiple four-hit combos on the ground. Will increase damage and chance of Berserk.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/031.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (28, 'Brandish', 'A spinning attack with invincibility. Press right or left+ square after a four-hit combo on the ground.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/032.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (29, 'Berserk', 'Attack an enemy multiple times consecutively for increased attack power and speed.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/033.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (30, 'Adrenaline', 'Strength increases as HP decreases', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/034.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (31, 'War Paint', 'Summon clones that unleash multiple attacks. (Uses War Paint item)', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/035.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (32, 'Incite Rage', 'Go into Berserker mode in exchange for HP. (Use Incite Rage item)', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/036.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (33, 'Iron Will', 'Ignores knockback temporarily in exchange for HP and only take 10 damage from all attacks. (Uses Iron Will item) ', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/037.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (34, 'Power Shot', 'Charge an arrow to unleash a powerful wind shot. Charge by Holding the special attack button and then release.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/052.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (35, 'Rapid Fire', 'Quickly release a volley of arrows. Number of arrows increases with skill level.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/053.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (36, 'Spacious Quiver', 'Increases Arrow Capacity', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/054.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (37, 'Impact Arrow', 'Fire an arrow that produces a shockwave. Higher skill levels boost range and power.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/055.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (38, 'Clone Strikes', 'Shoot more arrows when using crouched charge attacks and when shooting while dashing.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/056.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (39, 'Toxic Extract', 'Use the Toxic Extract tool to grant poison properties to arrow and dagger attacks. (Use again to deactivate)', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/057.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (40, 'Holdout Dagger', 'Use the Holdout Dagger tool to produce a dagger to attack with.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/057.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (41, 'Salamander Oil', 'Use the Salamander Oil tool  to grant fire properties to arrow and dagger attacks. (Use again to deactivate.)', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/059.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (42, 'Elemental Lore', 'Use spirit magic to attack. Activate by holding melee attack.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/060.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (43, 'Deadly Boots', 'Add your boots\' DEF to kick attack power. Higher Skill levels increase this boost.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/061.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (44, 'Backstab', 'Increase damage when attacking an enemy from behind with a dagger.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/062.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (45, 'Battle Hardened', 'Reduce knockdown chance and damage taken while charging arrows.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/063.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (46, 'Power Bomb', 'Adds shockwaves to throwing attacks.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/039.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (47, 'Lethal Fists', 'Increases the damage dealt for all bare-fisted attacks', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/040.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (48, 'Eagle Dive', 'A mid-air glide attack. (Double jump and x)', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/041.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (49, 'Grand Smash', 'A powerful attack which requires the temporary loss of your weapon. Activate with Power Smash O.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/042.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (50, 'Frenzy', 'A powerful rush attack. Activate by rapidly pressing square.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/043.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (51, 'Bomb Sachel', 'Use a Bomb Satchel item to carry around and use bombs.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/044.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (52, 'Fire Barrel', 'Use a Fire Barrel item to produce an exploding barrel that can be picked up and hurled.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/045.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (53, 'Magma Infusion', 'Use a Lava Bracer item to add fire properties to any attack.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/046.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (54, 'Powder Mastery', 'Increases explosive damage.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/047.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (55, 'Trinket Maniac', 'Heal HP and equipment durabiliy when picking up score items.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/048.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (56, 'Rock Skin', 'Increases defense while pumped up. Activate by holding square.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/049.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (57, 'Toughness', 'Smaller attacks won\'t cause you to flinch.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/050.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (58, 'Mental Absorb', 'Gain MP with every enemy you defeat.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/080.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (59, 'Extract', 'If your magic shot hits an enemy, you will recover MP.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/081.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (60, 'Concentrate', 'Increase MP charge speed when holding square.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/082.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (61, 'Spirit Up', 'Increase maximum MP.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/083.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (62, 'Ice Prison', 'Cast to encase your enemies in ice.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/084.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (63, 'Protection', 'Cast to magically shield all your allies.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/085.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (64, 'Gravity', 'Cast to create a gravity field that pulls in enemies.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/086.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (65, 'Thunderhead', 'Cast to summon a small cloud that will attack foes with lightning.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/087.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (66, 'Rock Press', 'Cast to create a boulder to crush foes and stun nearby enemies.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/088.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (67, 'Blizzard', 'Cast to call forth a blizzard which will freeze enemies.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/089.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (68, 'Animate Skeleton', 'Create skeletal allies. (Press square near bones.）No more than 4 skeletons per party can be active at any time regardless of skill levels.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/090.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (69, 'Levitation', 'Enable witch flight. (Double jump and press ×.）', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/091.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (70, 'Create Food', 'Cast to create nutritious food, expendable weapons , and bones. ', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/092.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (71, 'Curse', 'Cast to curse your enemies to live as frogs.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/093.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (72, 'Petrification', 'Cast to turn your enemies to stone.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/094.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (73, 'Mental Absorb', 'Gain MP with every enemy you defeat.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/080.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (74, 'Extract', 'If your magic shot hits an enemy, you will recover MP.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/081.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (75, 'Concentrate', 'Increase MP charge speed when holding square.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/082.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (76, 'Magic Point Up', 'Increase maximum MP.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/083.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (77, 'Levitation', 'Enable witch flight. (Double jump and press ×)', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/091.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (78, 'Fire Gate', 'Cast to create a magic circle which grants fire protection.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/069.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (79, 'Blaze', 'Cast to create long-burning flames. Small AoE, devastating to stationary enemies.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/070.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (80, 'Storm', 'Cast to summon a tornado which will slash enemies. Very large AoE.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/071.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (81, 'Flame Burst', 'Cast to raze everything in front of you.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/072.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (82, 'Thunder Struck', 'Cast to summon lightning and stun enemies.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/073.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (83, 'Meteor Swarm', 'Cast a grand magic that calls down meteors from the heavens. Long cast time, heavy damage.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/074.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (84, 'Create Golem', 'Create Golems. (Press square near wooden boxes/barrels)', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/075.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (85, 'Slow', 'Cast to create a magic circle that slows enemy movements.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/077.jpg', 0);
INSERT INTO `skill` (`id`, `name`, `description`, `card_image_url`, `is_common`) VALUES (86, 'Extinction', 'Cast to make one enemy cease to exist. Ineffective on bosses. If used carefully, it can catch multiple enemies.', 'https://www.4gamer.net/games/134/G013480/FC20130711001/TN/078.jpg', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `skill_details`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (1, 1, 1, 0, 1, 'Power 30, Knockback + 30%', 1);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (2, 2, 1, 0, 10, 'Power 34, Knockback + 40%', 1);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (3, 3, 2, 3, 20, 'Power 40, Knockback + 55%', 1);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (4, 4, 3, 3, 31, 'Power 46, Knockback + 70%', 1);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (5, 5, 4, 6, 40, 'Power 60, Knockback + 100%', 1);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (6, 1, 1, 0, 1, 'HP Recovered Per Coin: 2', 2);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (7, 2, 1, 0, 5, 'HP Recovered Per Coin: 3', 2);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (8, 3, 2, 3, 14, 'HP Recovered Per Coin: 5', 2);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (9, 4, 3, 3, 27, 'HP Recovered Per Coin: 7', 2);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (10, 5, 4, 6, 42, 'HP Recovered Per Coin: 10', 2);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (11, 1, 1, 0, 1, '+10 Per Coin', 3);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (12, 2, 1, 0, 8, '+20 Per Coin', 3);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (13, 3, 2, 3, 17, '+40 Per Coin', 3);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (14, 4, 3, 3, 29, '+60 Per Coin', 3);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (15, 5, 4, 6, 43, '+100 Per Coin', 3);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (16, 1, 1, 0, 1, 'Max HP + 20', 4);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (17, 2, 1, 0, 7, 'Max HP + 35', 4);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (18, 3, 1, 3, 13, 'Max HP + 50', 4);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (19, 4, 2, 3, 19, 'Max HP + 65', 4);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (20, 5, 2, 6, 25, 'Max HP + 80', 4);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (21, 6, 3, 6, 31, 'Max HP + 100', 4);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (22, 7, 3, 9, 38, 'Max HP + 120', 4);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (23, 8, 4, 9, 45, 'Max HP + 145', 4);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (24, 9, 4, 12, 52, 'Max HP + 170', 4);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (25, 10, 6, 12, 59, 'Max HP + 200', 4);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (26, 1, 1, 0, 3, 'Recovery + 20%', 5);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (27, 2, 1, 0, 11, 'Recovery + 25%', 5);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (28, 3, 2, 3, 24, 'Recovery + 30%', 5);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (29, 4, 3, 3, 37, 'Recovery + 35%', 5);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (30, 5, 4, 6, 51, 'Recovery + 50%', 5);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (31, 1, 1, 0, 6, '20% Chance of Not Depleting', 6);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (32, 2, 1, 0, 13, '25% Chance of Not Depleting', 6);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (33, 3, 2, 3, 23, '30% Chance of Not Depleting', 6);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (34, 4, 3, 3, 34, '35% Chance of Not Depleting', 6);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (35, 5, 4, 6, 47, '50% Chance of Not Depleting', 6);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (36, 1, 1, 0, 9, '-10% Cooldown Time', 7);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (37, 2, 1, 0, 16, '-15% Cooldown Time', 7);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (38, 3, 2, 3, 22, '-20% Cooldown Time', 7);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (39, 4, 2, 3, 29, '-25% Cooldown Time', 7);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (40, 5, 3, 6, 36, '-30% Cooldown Time', 7);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (41, 6, 3, 6, 44, '-35% Cooldown Time', 7);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (42, 7, 5, 9, 53, '-50% Cooldown Time', 7);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (43, 1, 2, 0, 12, 'Continous Evade +1', 8);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (44, 2, 3, 3, 32, 'Continous Evade +2', 8);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (45, 3, 4, 6, 52, 'Continous Evade +3', 8);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (46, 1, 2, 0, 15, 'Total Bag Slots = 8', 9);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (47, 2, 4, 3, 30, 'Total Bag Slots = 9', 9);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (48, 3, 6, 6, 50, 'Total Bag Slots = 10', 9);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (49, 1, 1, 0, 1, 'Damage 20, Fall Speed - 30%', 10);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (50, 2, 1, 0, 10, 'Damage 22, Fall Speed - 40%, AoE 105%', 10);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (51, 3, 2, 3, 19, 'Damage 23, Fall Speed - 60%, AoE 110%', 10);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (52, 4, 3, 3, 30, 'Damage 25, Fall Speed - 75%, AoE 115%', 10);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (53, 5, 5, 6, 45, 'Damage 30, Fall Speed - 95%, AoE 125%', 10);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (54, 1, 1, 0, 1, 'Damage 15, two Shockwaves', 11);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (55, 2, 1, 0, 8, 'Damage 18, two Shockwaves', 11);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (56, 3, 2, 3, 16, 'Damage 23, three Shockwaves', 11);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (57, 4, 3, 3, 26, 'Damage 30, three Shockwaves', 11);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (58, 5, 5, 6, 40, 'Damage 45, three Shockwaves', 11);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (59, 1, 1, 0, 3, 'Damage 40', 12);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (60, 2, 1, 0, 12, 'Damage 44, Wave AoE 120%', 12);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (61, 3, 2, 3, 21, 'Damage 46, Wave AoE 140%', 12);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (62, 4, 2, 3, 30, 'Damage 48, Wave AoE 160%', 12);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (63, 5, 3, 6, 39, 'Damage 50, Wave AoE 180%', 12);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (64, 6, 3, 6, 48, 'Damage 52, Wave AoE 200%', 12);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (65, 7, 5, 9, 57, 'Damage 60, Wave AoE 300%', 12);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (66, 1, 1, 0, 6, 'Damage 440, Impact Damage 165', 13);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (67, 2, 1, 0, 14, 'Damage 480, Impact Damage 180, Wave AoE 115%', 13);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (68, 3, 2, 3, 22, 'Damage 520, Impact Damage 195, Wave AoE 130%', 13);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (69, 4, 2, 3, 31, 'Damage 560, Impact Damage 210, Wave AoE 145%', 13);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (70, 5, 3, 6, 40, 'Damage 600, Impact Damage 225, Wave AoE 160%', 13);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (71, 6, 3, 6, 49, 'Damage 640, Impact Damage 240, Wave AoE 185%', 13);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (72, 7, 5, 9, 58, 'Damage 800, Impact Damage 300, Wave AoE 285%', 13);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (73, 1, 3, 0, 15, 'Damage 30, Duration 1.5 seconds', 14);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (74, 2, 1, 0, 20, 'Damage 33, Duration 1.9 seconds, AoE 103%', 14);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (75, 3, 1, 3, 25, 'Damage 36, Duration 2.2 seconds, AoE 106%', 14);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (76, 4, 2, 3, 30, 'Damage 41, Duration 2.4 seconds, AoE 110%\n', 14);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (77, 5, 2, 6, 35, 'Damage 45, Duration 2.7 seconds, AoE 114%', 14);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (78, 6, 3, 6, 40, 'Damage 50, Duration 2.9 seconds, AoE 119%', 14);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (79, 7, 3, 9, 45, 'Damage 54, Duration 3.2 seconds, AoE 124%', 14);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (80, 8, 4, 9, 50, 'Damage 60, Duration 3.4 seconds, AoE 130%', 14);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (81, 9, 4, 12, 55, 'Damage 66, Duration 3.7 seconds, AoE 136%', 14);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (82, 10, 6, 12, 60, 'Damage 75, Duration 4.2 seconds, AoE 150%', 14);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (83, 1, 1, 0, 1, 'Damage + 40% ', 15);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (84, 2, 2, 0, 17, 'Effect Range 125%, Damage + 70% ', 15);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (85, 3, 3, 3, 36, 'Effect Range 200%, Damage + 100% ', 15);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (86, 1, 1, 0, 1, '25% to Guard', 16);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (87, 2, 1, 0, 7, '30% to Guard', 16);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (88, 3, 2, 3, 16, '35% to Guard', 16);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (89, 4, 2, 3, 27, '40% to Guard', 16);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (90, 5, 3, 6, 35, '50% to Guard', 16);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (91, 1, 1, 0, 4, 'Damage 20, Stun 20% Chance', 17);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (92, 2, 1, 0, 9, 'Damage 24, Stun 25% Chance', 17);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (93, 3, 1, 3, 14, 'Damage 28, Stun 30% Chance', 17);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (94, 4, 2, 3, 19, 'Damage 32, Stun 35% Chance', 17);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (95, 5, 2, 6, 24, 'Damage 36, Stun 40% Chance', 17);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (96, 6, 2, 6, 29, 'Damage 40, Stun 45% Chance', 17);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (97, 7, 3, 9, 34, 'Damage 44, Stun 50% Chance', 17);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (98, 8, 3, 9, 40, 'Damage 48, Stun 55% Chance', 17);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (99, 9, 4, 12, 47, 'Damage 52, Stun 60% Chance', 17);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (100, 10, 6, 12, 54, 'Damage 60, Stun 80% Chance', 17);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (101, 1, 1, 0, 11, '30% Chance', 18);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (102, 2, 1, 0, 16, '35% Chance, Reflected shot Dealt damage +20%', 18);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (103, 3, 1, 3, 21, '40% Chance, Reflected shot Dealt damage +40%', 18);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (104, 4, 2, 3, 27, '45% Chance, Reflected shot Dealt damage +65%', 18);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (105, 5, 2, 6, 32, '50% Chance, Reflected shot Dealt damage +90%', 18);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (106, 6, 2, 6, 37, '55% Chance, Reflected shot Dealt damage +115%', 18);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (107, 7, 3, 9, 43, '65% Chance, Reflected shot Dealt damage +140%', 18);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (108, 8, 3, 9, 48, '75% Chance, Reflected shot Dealt damage +165%', 18);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (109, 9, 4, 12, 53, '90% Chance, Reflected shot Dealt damage +200%', 18);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (110, 10, 6, 12, 58, '100% Chance, Reflected shot Dealt damage +250%', 18);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (111, 1, 1, 0, 1, 'Uses 5, Attracts 5 foes, Damage +10% ', 19);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (112, 2, 2, 0, 12, 'Uses 5, Attracts 6 foes, Damage +20%', 19);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (113, 3, 3, 3, 24, 'Uses 5, Attracts 9 foes, Damage +30%', 19);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (114, 1, 1, 0, 5, 'Uses 3, - 30% Damage received', 20);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (115, 2, 1, 0, 11, 'Uses 3, - 40% Damage received', 20);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (116, 3, 2, 3, 19, 'Uses 3, - 50% Damage received', 20);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (117, 4, 3, 3, 29, 'Uses 3, - 60% Damage received', 20);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (118, 5, 4, 6, 42, 'Uses 3, -70% Damage received', 20);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (119, 1, 1, 0, 9, 'Guard Holding + 20%, shield durability Loss -5', 21);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (120, 2, 1, 0, 13, 'Guard Holding + 30%, shield durability Loss -7', 21);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (121, 3, 2, 3, 18, 'Guard Holding + 40%, shield durability Loss -10', 21);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (122, 4, 2, 3, 23, 'Guard Holding + 50%, shield durability Loss -13', 21);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (123, 5, 3, 6, 28, 'Guard Holding + 60%, shield durability Loss -16', 21);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (124, 6, 3, 6, 33, 'Guard Holding + 70%, shield durability Loss -19', 21);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (125, 7, 4, 9, 38, 'Guard Holding + 85%, shield durability Loss -25', 21);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (126, 8, 4, 9, 44, 'Guard Holding + 100%, shield durability Loss -31', 21);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (127, 9, 5, 12, 50, 'Guard Holding + 120%, shield durability Loss -40', 21);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (128, 10, 6, 12, 56, 'Guard Holding + 150%, shield durability Loss -50', 21);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (129, 1, 1, 0, 1, 'Power 20', 22);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (130, 2, 1, 0, 6, 'Power 24, Shockwave distance + 110%', 22);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (131, 3, 2, 3, 12, 'Power 28, Shockwave distance + 120%', 22);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (132, 4, 2, 3, 18, 'Power 32, Shockwave distance + 130%', 22);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (133, 5, 3, 6, 25, 'Power 36, Shockwave distance + 140%', 22);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (134, 6, 3, 6, 33, 'Power 40, Shockwave distance + 150%', 22);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (135, 7, 5, 9, 42, 'Power 60, Shockwave distance + 190%', 22);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (136, 1, 1, 0, 3, 'Power 150, Damage + 100%', 23);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (137, 2, 1, 0, 8, 'Power 155, Damage + 105%', 23);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (138, 3, 1, 3, 14, 'Power 162, Damage + 110%', 23);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (139, 4, 2, 3, 20, 'Power 169, Damage + 115%', 23);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (140, 5, 2, 6, 26, 'Power 176, Damage + 120%', 23);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (141, 6, 3, 6, 32, 'Power 180, Damage + 130%', 23);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (142, 7, 3, 9, 38, 'Power 189, Damage + 140%', 23);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (143, 8, 4, 9, 44, 'Power 196, Damage + 155%', 23);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (144, 9, 4, 12, 50, 'Power 203, Damage + 170%', 23);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (145, 10, 6, 12, 56, 'Power 230, Damage + 200%', 23);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (146, 1, 1, 0, 11, 'Power: 18 Direction changes: 2 Dealt damage: +30%', 24);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (147, 2, 1, 0, 17, 'Power: 20 Direction changes: 2 Dealt damage: +35%', 24);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (148, 3, 2, 3, 23, 'Power: 22 Direction changes: 2 Dealt damage: +45%', 24);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (149, 4, 2, 3, 29, 'Power: 24 Direction changes: 3 Dealt damage: +55%', 24);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (150, 5, 3, 6, 36, 'Power: 26 Direction changes: 3 Dealt damage: +70%', 24);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (151, 6, 3, 6, 45, 'Power: 28 Direction changes: 3 Dealt damage: +85%', 24);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (152, 7, 5, 9, 54, 'Power: 30 Direction changes: 4 Dealt damage: +100%', 24);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (153, 1, 1, 0, 1, 'Power 440, Shockwave Power 165', 25);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (154, 2, 1, 0, 6, 'Power 480, Shockwave Power 180, Shockwave range 105%', 25);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (155, 3, 1, 3, 12, 'Power 520, Shockwave Power 195, Shockwave range 110%', 25);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (156, 4, 2, 3, 18, 'Power 560, Shockwave Power 210, Shockwave range 115%', 25);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (157, 5, 2, 6, 24, 'Power 600, Shockwave Power 225, Shockwave range 120%', 25);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (158, 6, 3, 6, 30, 'Power 640, Shockwave Power 248, Shockwave range 125%', 25);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (159, 7, 3, 9, 37, 'Power 680, Shockwave Power 270, Shockwave range 130%', 25);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (160, 8, 4, 9, 44, 'Power 740, Shockwave Power 300, Shockwave range 135%', 25);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (161, 9, 4, 12, 51, 'Power 800, Shockwave Power 330, Shockwave range 140%', 25);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (162, 10, 6, 12, 60, 'Power 880, Shockwave Power 375, Shockwave range 190%', 25);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (163, 1, 1, 0, 4, 'Power 100, Invincibility Duration 2 Seconds', 26);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (164, 2, 1, 0, 9, 'Power 110, Invincibility Duration 2.3 Seconds', 26);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (165, 3, 1, 3, 14, 'Power 120, Invincibility Duration 2.7 Seconds', 26);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (166, 4, 2, 3, 20, 'Power 130, Invincibility Duration 3 Seconds', 26);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (167, 5, 2, 6, 26, 'Power 140, Invincibility Duration 3.3 Seconds', 26);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (168, 6, 2, 6, 32, 'Power 150, Invincibility Duration 3.7 Seconds', 26);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (169, 7, 3, 9, 38, 'Power 160, Invincibility Duration 4 Seconds', 26);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (170, 8, 3, 9, 45, 'Power 180, Invincibility Duration 4.3 Seconds', 26);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (171, 9, 3, 12, 52, 'Power 190, Invincibility Duration 4.7 Seconds', 26);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (172, 10, 4, 12, 59, 'Power 250, Invincibility Duration 5 Seconds', 26);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (173, 1, 1, 0, 10, 'Power 20', 27);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (174, 2, 2, 0, 21, 'Power 40', 27);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (175, 3, 3, 3, 40, 'Power 60', 27);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (176, 1, 3, 0, 15, 'Power 100, 1 Spin', 28);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (177, 2, 1, 0, 22, 'Power 110, 2 Spins', 28);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (178, 3, 2, 3, 30, 'Power 120,  3 Spins', 28);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (179, 4, 3, 3, 39, 'Power 130, 4 Spins', 28);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (180, 5, 5, 6, 48, 'Power 150, 5 Spins', 28);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (181, 1, 1, 0, 1, 'Damage during Berserk + 10%', 29);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (182, 2, 1, 0, 7, 'Damage during Berserk + 15%', 29);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (183, 3, 1, 3, 13, 'Damage during Berserk + 20%', 29);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (184, 4, 2, 3, 19, 'Damage during Berserk + 25%', 29);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (185, 5, 2, 6, 25, 'Damage during Berserk + 30%', 29);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (186, 6, 3, 6, 31, 'Damage during Berserk + 35%', 29);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (187, 7, 3, 9, 37, 'Damage during Berserk + 40%', 29);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (188, 8, 4, 9, 43, 'Damage during Berserk + 45%', 29);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (189, 9, 4, 12, 49, 'Damage during Berserk + 50%', 29);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (190, 10, 6, 12, 55, 'Damage during Berserk + 60%', 29);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (191, 1, 1, 0, 1, 'Damage 30%', 30);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (192, 2, 1, 0, 6, 'Damage 40%', 30);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (193, 3, 2, 3, 12, 'Damage 50%', 30);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (194, 4, 2, 3, 20, 'Damage 60%', 30);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (195, 5, 3, 6, 28, 'Damage 70%', 30);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (196, 6, 3, 6, 38, 'Damage 80%', 30);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (197, 7, 4, 9, 51, 'Damage 100%', 30);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (198, 1, 2, 0, 5, 'Uses 3, Clones 1, 10 second duration', 31);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (199, 2, 3, 0, 27, 'Uses 3, Clones 1, 15 second duration', 31);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (200, 3, 4, 3, 46, 'Uses 3, Clones 2, 20 second duration', 31);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (201, 1, 1, 0, 9, '3 Uses, 50% Hp loss, Berserk Lvl 3, +3 sec Berserk time', 32);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (202, 2, 2, 0, 20, '4 Uses, 60% Hp loss, Berserk Lvl 3, +6 sec Berserk time', 32);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (203, 3, 3, 3, 34, '5 Uses, 70% Hp loss, Berserk Lvl 3, +9 sec Berserk time', 32);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (204, 1, 1, 0, 13, 'Uses 3, 8 Second Duration', 33);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (205, 2, 1, 0, 21, 'Uses 3, 12 Second Duration', 33);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (206, 3, 2, 3, 29, 'Uses 4, 12 Second Duration', 33);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (207, 4, 3, 3, 40, 'Uses 4, 16 Second Duration', 33);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (208, 5, 5, 6, 52, 'Uses 5, 20 Second Duration', 33);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (209, 1, 1, 0, 1, 'Power 210', 34);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (210, 2, 1, 0, 5, 'Power 220, Shockwave: 105%', 34);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (211, 3, 1, 3, 11, 'Power 230, Shockwave: 110%', 34);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (212, 4, 2, 3, 17, 'Power 240, Shockwave: 115%', 34);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (213, 5, 2, 6, 24, 'Power 250, Shockwave: 120%', 34);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (214, 6, 3, 6, 31, 'Power 260, Shockwave: 125%', 34);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (215, 7, 3, 9, 38, 'Power 270, Shockwave: 130%', 34);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (216, 8, 4, 9, 45, 'Power 280, Shockwave: 135%', 34);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (217, 9, 4, 12, 52, 'Power 290, Shockwave: 140%', 34);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (218, 10, 6, 12, 60, 'Power 320, Shockwave: 170%', 34);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (219, 1, 1, 0, 1, 'Arrows + 1', 35);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (220, 2, 2, 0, 9, 'Arrows + 2', 35);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (221, 3, 3, 3, 18, 'Arrows + 3', 35);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (222, 4, 5, 3, 30, 'Arrows + 4', 35);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (223, 1, 1, 0, 3, 'Arrow Max + 2', 36);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (224, 2, 1, 0, 12, 'Arrow Max + 4', 36);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (225, 3, 2, 3, 23, 'Arrow Max + 7', 36);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (226, 4, 3, 3, 36, 'Arrow Max + 10', 36);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (227, 5, 5, 6, 50, 'Arrow Max + 15', 36);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (228, 1, 1, 0, 8, 'Power 50', 37);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (229, 2, 1, 0, 14, 'Power 65, Shockwave Range: 105%', 37);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (230, 3, 2, 3, 20, 'Power 80, Shockwave Range: 110%', 37);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (231, 4, 2, 3, 27, 'Power 95, Shockwave Range: 115%', 37);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (232, 5, 3, 6, 33, 'Power 110, Shockwave Range: 120%', 37);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (233, 6, 3, 6, 40, 'Power 125, Shockwave Range: 125%', 37);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (234, 7, 5, 9, 49, 'Power 175, Shockwave Range: 145%', 37);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (235, 1, 1, 0, 15, 'Shots + 1', 38);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (236, 2, 2, 0, 26, 'Shots + 2', 38);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (237, 3, 3, 3, 39, 'Shots + 3', 38);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (238, 4, 5, 3, 53, 'Shots + 4', 38);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (239, 1, 1, 0, 1, 'Uses 20', 39);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (240, 2, 1, 0, 7, 'Uses 25', 39);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (241, 3, 2, 3, 16, 'Uses 30', 39);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (242, 4, 3, 3, 25, 'Uses 35', 39);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (243, 5, 5, 6, 35, 'Uses 50', 39);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (244, 1, 1, 0, 4, 'Uses 3', 40);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (245, 2, 1, 0, 10, 'Uses 4', 40);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (246, 3, 2, 3, 19, 'Uses 5', 40);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (247, 4, 2, 3, 30, 'Uses 6', 40);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (248, 5, 3, 6, 46, 'Uses 9', 40);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (249, 1, 1, 0, 13, 'Uses 20', 41);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (250, 2, 1, 0, 22, 'Uses 25', 41);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (251, 3, 2, 3, 33, 'Uses 30', 41);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (252, 4, 3, 3, 44, 'Uses 35', 41);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (253, 5, 5, 6, 57, 'Uses 50', 41);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (254, 1, 1, 0, 1, 'Enables Spirit magic use', 42);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (255, 2, 1, 0, 6, 'Damage + 20', 42);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (256, 3, 1, 3, 11, 'Damage + 30', 42);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (257, 4, 2, 3, 16, 'Damage + 40', 42);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (258, 5, 2, 6, 21, 'Damage + 50', 42);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (259, 6, 2, 6, 26, 'Damage + 60', 42);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (260, 7, 3, 9, 32, 'Damage + 70', 42);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (261, 8, 3, 9, 37, 'Damage + 80', 42);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (262, 9, 4, 12, 43, 'Damage + 90', 42);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (263, 10, 5, 12, 50, 'Damage + 100', 42);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (264, 1, 1, 0, 1, '+ 50% boot defense as damage', 43);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (265, 2, 1, 0, 7, '+75% boot defense as damage', 43);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (266, 3, 1, 3, 12, '+100% boot defense as damage', 43);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (267, 4, 2, 3, 17, '+125% boot defense as damage', 43);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (268, 5, 2, 6, 23, '+150% boot defense as damage', 43);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (269, 6, 3, 6, 29, '+175% boot defense as damage', 43);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (270, 7, 3, 9, 35, '+200% boot defense as damage', 43);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (271, 8, 4, 9, 41, '+230% boot defense as damage', 43);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (272, 9, 4, 12, 47, '+260% boot defense as damage', 43);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (273, 10, 6, 12, 54, '+300% boot defense as damage', 43);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (274, 1, 1, 0, 5, '+80% damage', 44);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (275, 2, 1, 0, 10, '+100% damage', 44);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (276, 3, 1, 3, 15, '+120% damage', 44);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (277, 4, 2, 3, 20, '+135% damage', 44);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (278, 5, 2, 6, 25, '+155% damage', 44);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (279, 6, 3, 6, 30, '+175% damage', 44);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (280, 7, 3, 9, 36, '+195% damage', 44);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (281, 8, 4, 9, 42, '+210% damage', 44);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (282, 9, 4, 12, 48, '+230% damage', 44);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (283, 10, 5, 12, 55, '+300% damage', 44);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (284, 1, 1, 0, 9, '-20% damage taken, Knock down Res: 50', 45);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (285, 2, 1, 0, 18, '-25% damage taken, Knock down Res: 66', 45);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (286, 3, 2, 3, 28, '-30% damage taken, Knock down Res: 75', 45);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (287, 4, 3, 3, 39, '-35% damage taken, Knock down Res: 80', 45);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (288, 5, 5, 6, 51, '-50% damage taken, Knock down Res: 83', 45);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (289, 1, 1, 0, 1, '+20% Damage to throwing attacks', 46);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (290, 2, 1, 0, 6, '+30% Damage to throwing attacks, Shockwave range 105%', 46);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (291, 3, 1, 3, 11, '+40% Damage to throwing attacks, Shockwave range 110%', 46);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (292, 4, 2, 3, 16, '+50% Damage to throwing attacks, Shockwave range 115%', 46);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (293, 5, 2, 6, 22, '+60% Damage to throwing attacks, Shockwave range 120%', 46);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (294, 6, 3, 6, 28, '+75% Damage to throwing attacks, Shockwave range 125%', 46);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (295, 7, 3, 9, 34, '+90% Damage to throwing attacks, Shockwave range 130%', 46);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (296, 8, 4, 9, 40, '+105% Damage to throwing attacks, Shockwave range 135%', 46);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (297, 9, 4, 12, 47, '+120% Damage to throwing attacks, Shockwave range 140%', 46);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (298, 10, 5, 12, 55, '+150% Damage to throwing attacks, Shockwave range 180%', 46);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (299, 1, 1, 0, 1, '+20% Damage to barefisted attacks.', 47);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (300, 2, 1, 0, 7, '+40% Damage to barefisted attacks.', 47);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (301, 3, 1, 3, 12, '+60% Damage to barefisted attacks.', 47);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (302, 4, 2, 3, 18, '+80% Damage to barefisted attacks.', 47);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (303, 5, 2, 6, 23, '+100% Damage to barefisted attacks.', 47);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (304, 6, 3, 6, 29, '+120% Damage to barefisted attacks.', 47);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (305, 7, 3, 9, 35, '+140% Damage to barefisted attacks.', 47);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (306, 8, 4, 9, 41, '+160% Damage to barefisted attacks.', 47);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (307, 9, 4, 12, 48, '+180% Damage to barefisted attacks.', 47);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (308, 10, 5, 12, 56, '+250% Damage to barefisted attacks.', 47);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (309, 1, 1, 0, 3, 'Allows Glide Attacks.', 48);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (310, 2, 1, 0, 10, 'Allows Dropping 3 bombs, 60% bomb power', 48);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (311, 3, 2, 3, 19, 'Allows Dropping 4 bombs, 70% bomb power', 48);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (312, 4, 3, 3, 30, 'Allows Dropping 5 bombs, 80% bomb power', 48);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (313, 5, 5, 6, 42, 'Allows Dropping 6 bombs, 90% bomb power', 48);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (314, 1, 1, 0, 9, 'Power 110, Thunder Power 36, 3 Lightning strikes', 49);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (315, 2, 1, 0, 17, 'Power 120, Thunder Power 39, 5 Lightning strikes', 49);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (316, 3, 2, 3, 27, 'Power 135, Thunder Power 42, 7 Lightning strikes', 49);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (317, 4, 3, 3, 39, 'Power 150, Thunder Power 47, 9 Lightning strikes', 49);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (318, 5, 5, 6, 53, 'Power 170, Thunder Power 55, 12 Lightning strikes', 49);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (319, 1, 3, 0, 15, 'Power 40, Duration 1.5 seconds', 50);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (320, 2, 1, 0, 25, 'Power 45, Duration 2 seconds', 50);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (321, 3, 2, 3, 36, 'Power 50, Duration 2.5 seconds', 50);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (322, 4, 3, 3, 48, 'Power 60, Duration 3 seconds', 50);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (323, 5, 5, 6, 60, 'Power 70, Duration 4 seconds', 50);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (324, 1, 1, 0, 1, 'Uses 4', 51);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (325, 2, 1, 0, 8, 'Uses 6', 51);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (326, 3, 2, 3, 20, 'Uses 8', 51);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (327, 4, 3, 3, 33, 'Uses 10', 51);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (328, 5, 5, 6, 46, 'Uses 15', 51);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (329, 1, 1, 0, 9, 'Uses 3', 52);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (330, 2, 1, 0, 13, 'Uses 4', 52);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (331, 3, 2, 3, 24, 'Uses 5', 52);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (332, 4, 3, 3, 38, 'Uses 6', 52);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (333, 5, 5, 6, 52, 'Uses 9', 52);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (334, 1, 1, 0, 10, 'Uses 3, 15 Seconds, 10% Burn Chance, Explosion frame count interval 20', 53);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (335, 2, 1, 0, 17, 'Uses 4, 15 Seconds, 15% Burn Chance, Explosion frame count interval 19', 53);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (336, 3, 2, 3, 25, 'Uses 5, 15 Seconds, 20% Burn Chance, Explosion frame count interval 18', 53);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (337, 4, 3, 3, 34, 'Uses 6, 15 Seconds, 25% Burn Chance, Explosion frame count interval 17', 53);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (338, 5, 5, 6, 45, 'Uses 12, 15 Seconds, 50% Burn Chance, Explosion frame count interval 12', 53);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (339, 1, 1, 0, 14, '+20% Damage', 54);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (340, 2, 1, 0, 19, '+25% Damage', 54);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (341, 3, 1, 3, 24, '+30% Damage', 54);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (342, 4, 2, 3, 29, '+35% Damage', 54);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (343, 5, 2, 6, 34, '+40% Damage', 54);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (344, 6, 3, 6, 39, '+50% Damage', 54);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (345, 7, 3, 9, 44, '+60% Damage', 54);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (346, 8, 4, 9, 49, '+70% Damage', 54);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (347, 9, 4, 12, 54, '+80% Damage', 54);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (348, 10, 5, 12, 59, '+100% Damage', 54);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (349, 1, 1, 0, 1, '+2 Hp, Durability recovery +1', 55);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (350, 2, 1, 0, 6, '+3 Hp, Durability recovery +1', 55);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (351, 3, 1, 3, 11, '+4 Hp, Durability recovery +1', 55);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (352, 4, 2, 3, 16, '+5 Hp, Durability recovery +2', 55);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (353, 5, 2, 6, 21, '+6 Hp, Durability recovery +2', 55);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (354, 6, 2, 6, 26, '+7 Hp, Durability recovery +2', 55);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (355, 7, 3, 9, 32, '+8 Hp, Durability recovery +3', 55);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (356, 8, 3, 9, 38, '+9 Hp, Durability recovery +3', 55);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (357, 9, 4, 12, 45, '+10 Hp, Durability recovery +3', 55);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (358, 10, 5, 12, 51, '+15 Hp, Durability recovery +5', 55);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (359, 1, 1, 0, 5, 'Damage -20%', 56);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (360, 2, 1, 0, 13, 'Damage -25%', 56);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (361, 3, 2, 3, 22, 'Damage -30%', 56);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (362, 4, 3, 3, 33, 'Damage -35%', 56);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (363, 5, 5, 6, 46, 'Damage -50%', 56);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (364, 1, 1, 0, 12, 'Resist 30 Damage', 57);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (365, 2, 1, 0, 20, 'Resist 45 Damage', 57);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (366, 3, 2, 3, 30, 'Resist 60 Damage', 57);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (367, 4, 3, 3, 41, 'Resist 80 Damage', 57);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (368, 5, 5, 6, 54, 'Resist 120 Damage', 57);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (369, 1, 1, 0, 1, '+15 MP', 58);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (370, 2, 1, 0, 6, '+18 MP', 58);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (371, 3, 1, 3, 11, '+21 MP', 58);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (372, 4, 2, 3, 16, '+24 MP', 58);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (373, 5, 2, 6, 21, '+27 MP', 58);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (374, 6, 3, 6, 27, '+30 MP', 58);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (375, 7, 3, 9, 33, '+34 MP', 58);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (376, 8, 4, 9, 39, '+38 MP', 58);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (377, 9, 4, 12, 45, '+42 MP', 58);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (378, 10, 5, 12, 51, '+50 MP', 58);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (379, 1, 1, 0, 1, '+5 MP', 59);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (380, 2, 1, 0, 7, '+7 MP', 59);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (381, 3, 2, 3, 13, '+9 MP', 59);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (382, 4, 2, 3, 19, '+11 MP', 59);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (383, 5, 3, 6, 26, '+13 MP', 59);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (384, 6, 3, 6, 34, '+15 MP', 59);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (385, 7, 5, 9, 42, '+20 MP', 59);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (386, 1, 1, 0, 4, '+10%', 60);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (387, 2, 1, 0, 10, '+14%', 60);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (388, 3, 2, 3, 17, '+18%', 60);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (389, 4, 3, 3, 25, '+22%', 60);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (390, 5, 5, 6, 35, '+30%', 60);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (391, 1, 1, 0, 9, '+30', 61);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (392, 2, 1, 0, 18, '+50', 61);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (393, 3, 2, 3, 28, '+70', 61);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (394, 4, 3, 3, 38, '+100', 61);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (395, 5, 5, 6, 49, '+150', 61);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (396, 1, 1, 0, 1, 'Uses 5, Power 50, Duration 8 secs', 62);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (397, 2, 3, 3, 14, 'Uses 7, Power 63, Duration 12 secs', 62);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (398, 3, 5, 6, 30, 'Uses 9, Power 75, Duration 20 secs', 62);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (399, 1, 1, 0, 5, 'Uses 3, -25% damage, Duration 20 secs', 63);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (400, 2, 1, 0, 13, 'Uses 3, -30% damage, Duration 24 secs', 63);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (401, 3, 2, 3, 22, 'Uses 4, -35% damage, Duration 28 secs', 63);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (402, 4, 3, 3, 33, 'Uses 4, -40% damage, Duration 32 secs', 63);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (403, 5, 5, 6, 45, 'Uses 5, -50% damage, Duration 40 secs', 63);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (404, 1, 1, 0, 11, 'Uses 3, 5 secs, Power 10', 64);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (405, 2, 3, 0, 24, 'Uses 5, 10 secs, Power 16', 64);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (406, 3, 5, 3, 40, 'Uses 8, 15 secs, Power 25', 64);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (407, 1, 1, 0, 1, 'Uses 3, 20 secs, Power 80', 65);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (408, 2, 1, 0, 6, 'Uses 3, 22 secs, Power 92', 65);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (409, 3, 2, 3, 12, 'Uses 4, 24 secs, Power 104', 65);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (410, 4, 2, 3, 18, 'Uses 4, 26 secs, Power 116', 65);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (411, 5, 3, 6, 25, 'Uses 5, 28 secs, Power 128', 65);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (412, 6, 3, 6, 32, 'Uses 5, 30 secs, Power 140', 65);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (413, 7, 5, 9, 41, 'Uses 7, 32 secs, Power 160', 65);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (414, 1, 1, 0, 7, 'Uses 5, Power 350', 66);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (415, 2, 1, 0, 13, 'Uses 5, Power 420', 66);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (416, 3, 2, 3, 20, 'Uses 6, Power 490', 66);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (417, 4, 2, 3, 27, 'Uses 6, Power 560', 66);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (418, 5, 3, 6, 35, 'Uses 7, Power 665', 66);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (419, 6, 3, 6, 44, 'Uses 7, Power 770', 66);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (420, 7, 5, 9, 53, 'Uses 9, Power 875', 66);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (421, 1, 1, 0, 14, 'Uses 3, 4 secs, Power 35', 67);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (422, 2, 1, 0, 23, 'Uses 3, 5 secs, Power 40', 67);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (423, 3, 2, 3, 32, 'Uses 4, 6 secs, Power 42', 67);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (424, 4, 3, 3, 46, 'Uses 4, 7 secs, Power 44', 67);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (425, 5, 5, 6, 58, 'Uses 5, 10 secs, Power 50', 67);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (426, 1, 1, 0, 1, '1 Skeleton Max, Skeleton Lvl = 50% Player Lvl', 68);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (427, 2, 1, 0, 8, '2 Skeletons Max, Skeleton Lvl = 60% Player Lvl', 68);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (428, 3, 2, 3, 16, '2 Skeleton Max, Skeleton Lvl = 70% Player Lvl', 68);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (429, 4, 3, 3, 25, '3 Skeleton Max, Skeleton Lvl = 80% Player Lvl', 68);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (430, 5, 5, 6, 36, '4 Skeleton Max, Skeleton Lvl = 100% Player Lvl', 68);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (431, 1, 1, 0, 1, 'Damage while levitating +20%', 69);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (432, 2, 3, 0, 14, 'Damage while levitating +35%', 69);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (433, 3, 5, 3, 29, 'Damage while levitating +50%', 69);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (434, 1, 1, 0, 3, 'Uses 5, Food Created +4', 70);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (435, 2, 1, 0, 9, 'Uses 5, Food Created +5', 70);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (436, 3, 2, 3, 17, 'Uses 6, Food Created +6', 70);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (437, 4, 2, 3, 26, 'Uses 7, Food Created +7', 70);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (438, 5, 4, 6, 35, 'Uses 9, Food Created +8', 70);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (439, 1, 1, 0, 6, 'Uses 5, Foes Affected 1', 71);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (440, 2, 3, 0, 16, 'Uses 7, Foes Affected 2', 71);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (441, 3, 5, 3, 31, 'Uses 9, Foes Affected 3', 71);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (442, 1, 1, 0, 15, 'Uses 3, 5 seconds', 72);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (443, 2, 1, 0, 22, 'Uses 3, 6 seconds', 72);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (444, 3, 2, 3, 29, 'Uses 4, 7 seconds', 72);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (445, 4, 2, 3, 36, 'Uses 4, 8 seconds', 72);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (446, 5, 3, 6, 43, 'Uses 5, 9 seconds', 72);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (447, 6, 3, 6, 51, 'Uses 5, 10 seconds', 72);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (448, 7, 5, 9, 60, 'Uses 7, 15 seconds', 72);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (449, 1, 1, 0, 4, '+15 MP Recovered', 73);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (450, 2, 1, 0, 10, '+18 MP Recovered', 73);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (451, 3, 2, 3, 17, '+21 MP Recovered', 73);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (452, 4, 3, 3, 25, '+24 MP Recovered', 73);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (453, 5, 5, 6, 35, '+30 MP Recovered', 73);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (454, 1, 1, 0, 1, '+5 MP Recovered', 74);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (455, 2, 1, 0, 7, '+7 MP Recovered', 74);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (456, 3, 1, 3, 13, '+9 MP Recovered', 74);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (457, 4, 2, 3, 19, '+11 MP Recovered', 74);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (458, 5, 2, 6, 26, '+13 MP Recovered', 74);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (459, 6, 3, 6, 34, '+15 MP Recovered', 74);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (460, 7, 4, 9, 42, '+20 MP Recovered', 74);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (461, 1, 1, 0, 1, 'MP charge speed +10%', 75);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (462, 2, 1, 0, 6, 'MP charge speed +14%', 75);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (463, 3, 1, 3, 11, 'MP charge speed +18%', 75);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (464, 4, 2, 3, 16, 'MP charge speed +22%', 75);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (465, 5, 2, 6, 21, 'MP charge speed +26%', 75);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (466, 6, 3, 6, 27, 'MP charge speed +30%', 75);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (467, 7, 3, 9, 33, 'MP charge speed +34%', 75);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (468, 8, 4, 9, 39, 'MP charge speed +38%', 75);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (469, 9, 4, 12, 45, 'MP charge speed +42%', 75);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (470, 10, 5, 12, 51, 'MP charge speed +50%', 75);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (471, 1, 1, 0, 9, 'Max MP +30', 76);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (472, 2, 1, 0, 18, 'Max MP +50', 76);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (473, 3, 2, 3, 28, 'Max MP +70', 76);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (474, 4, 3, 3, 38, 'Max MP +100', 76);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (475, 5, 5, 6, 49, 'Max MP +150', 76);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (476, 1, 1, 0, 1, 'Magic Dealt damage +20% while in the air', 77);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (477, 2, 3, 0, 14, 'Magic Dealt damage +35% while in the air', 77);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (478, 3, 5, 3, 29, 'Magic Dealt damage +50% while in the air', 77);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (479, 1, 1, 0, 8, '3 Uses, 15 Seconds, Damage Dealt + 20%', 78);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (480, 2, 3, 3, 24, '4 Uses, 20 Seconds, Damage Dealt + 30%, AoE + 50%', 78);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (481, 3, 5, 6, 40, '7 Uses, 30 Seconds, Damage Dealt + 50%, AoE + 100%', 78);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (482, 1, 1, 0, 1, '3 Uses, Power 25', 79);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (483, 2, 1, 0, 6, '4 Uses, Power 30', 79);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (484, 3, 2, 3, 12, '5 Uses, Power 35', 79);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (485, 4, 3, 3, 20, '6 Uses, Power 40', 79);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (486, 5, 5, 6, 29, '9 Uses, Power 50', 79);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (487, 1, 1, 0, 1, '3 Uses, Power 10', 80);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (488, 2, 1, 0, 7, '3 Uses, Power 12', 80);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (489, 3, 2, 3, 14, '4 Uses, Power 14', 80);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (490, 4, 2, 3, 22, '4 Uses, Power 16', 80);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (491, 5, 3, 6, 31, '5 Uses, Power 18', 80);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (492, 6, 3, 6, 41, '6 Uses, Power 20', 80);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (493, 7, 5, 9, 52, '9 Uses, Power 25', 80);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (494, 1, 1, 0, 3, '3 Uses, Power 30', 81);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (495, 2, 1, 0, 9, '3 Uses, Power 35', 81);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (496, 3, 2, 3, 16, '4 Uses, Power 39', 81);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (497, 4, 2, 3, 23, '4 Uses, Power 44', 81);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (498, 5, 3, 6, 32, '5 Uses, Power 45', 81);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (499, 6, 3, 6, 43, '6 Uses, Power 50', 81);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (500, 7, 5, 9, 56, '9 Uses, Power 60', 81);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (501, 1, 1, 0, 7, 'Uses 3, Power 40', 82);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (502, 2, 1, 0, 12, 'Uses 3, Power 46', 82);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (503, 3, 1, 3, 17, 'Uses 3, Power 52', 82);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (504, 4, 2, 3, 22, 'Uses 4, Power 58', 82);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (505, 5, 2, 6, 28, 'Uses 4, Power 64', 82);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (506, 6, 3, 6, 34, 'Uses 4, Power 70', 82);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (507, 7, 3, 9, 40, 'Uses 5, Power 76', 82);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (508, 8, 4, 9, 46, 'Uses 5, Power 82', 82);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (509, 9, 4, 12, 53, 'Uses 5, Power 88', 82);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (510, 10, 5, 12, 60, 'Uses 7, Power 110', 82);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (511, 1, 3, 0, 15, '3 Uses, 3 Meteors, Power 1200', 83);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (512, 2, 4, 3, 30, '3 Uses, 4 Meteors, Power 1350', 83);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (513, 3, 5, 6, 50, '3 Uses, 5 Meteors, Power 1500', 83);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (514, 1, 1, 0, 1, 'Golem 50% of player level', 84);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (515, 2, 1, 0, 8, 'Golem 60% of player level, 1 enhancment through addition wood', 84);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (516, 3, 2, 3, 16, 'Golem 70% of player level, 2 enhancments through addition wood', 84);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (517, 4, 3, 3, 25, 'Golem 80% of player level, 3 enhancments through addition wood', 84);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (518, 5, 5, 6, 36, 'Golem 100% of player level, 3 enhancments through addition wood', 84);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (519, 1, 1, 0, 5, 'Uses 4, Effect Range 100%, Speed Reduction 60%, Duration (frames) 600', 85);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (520, 2, 1, 0, 11, 'Uses 5, Effect Range 105%, Speed Reduction 65%, Duration (frames) 900', 85);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (521, 3, 2, 3, 18, 'Uses 6, Effect Range 110%, Speed Reduction 70%, Duration (frames) 1200', 85);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (522, 4, 2, 3, 26, 'Uses 7, Effect Range 120%, Speed Reduction 75%, Duration (frames) 1500', 85);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (523, 5, 4, 6, 35, 'Uses 9, Effect Range 130%, Speed Reduction 85%, Duration (frames) 1800', 85);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (524, 1, 1, 0, 13, 'Uses 3', 86);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (525, 2, 1, 0, 21, 'Uses 4', 86);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (526, 3, 2, 3, 30, 'Uses 5', 86);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (527, 4, 3, 3, 39, 'Uses 6', 86);
INSERT INTO `skill_details` (`id`, `rank`, `required_skill_points`, `similar_skill_level`, `required_player_level`, `effects`, `skill_id`) VALUES (528, 5, 5, 6, 48, 'Uses 9', 86);

COMMIT;


-- -----------------------------------------------------
-- Data for table `player_class_has_skill`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 1);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 1);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 1);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 1);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 1);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 1);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 2);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 2);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 2);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 2);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 2);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 2);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 3);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 3);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 3);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 3);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 3);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 3);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 4);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 4);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 4);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 4);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 4);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 4);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 5);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 5);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 5);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 5);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 5);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 5);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 6);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 6);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 6);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 6);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 6);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 6);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 7);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 7);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 7);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 7);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 7);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 7);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 8);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 8);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 8);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 8);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 8);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 8);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 9);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 9);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 9);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 9);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 9);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 9);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 10);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 11);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 12);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 13);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 14);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 15);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 16);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 17);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 18);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 19);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 20);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (1, 21);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 22);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 23);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 24);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 25);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 26);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 27);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 28);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 29);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 30);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 31);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 32);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (2, 33);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 34);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 35);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 36);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 37);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 38);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 39);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 40);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 41);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 42);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 43);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 44);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (3, 45);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 46);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 47);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 48);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 49);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 50);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 51);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 52);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 53);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 54);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 55);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 56);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (4, 57);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 58);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 59);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 60);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 61);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 62);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 63);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 64);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 65);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 66);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 67);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 68);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 69);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 70);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 71);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (5, 72);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 73);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 74);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 75);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 76);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 77);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 78);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 79);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 80);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 81);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 82);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 83);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 84);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 85);
INSERT INTO `player_class_has_skill` (`player_class_id`, `skill_id`) VALUES (6, 86);

COMMIT;


-- -----------------------------------------------------
-- Data for table `quest`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (1, 'Help the Honey Buzzards', 1, 'At Ancient Temple Ruins, destroy the orcs\' cargo found at the harbor.', 'Ancient Temple Ruins', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (2, 'Beastmaster', 1, 'Kill 10 enemies while riding atop a dragonlisk or sabertooth.', 'Old Capital / Lost Woods', 'Any');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (3, 'Delicacy Delivery', 1, 'Collect 10 spores from the myconids.', 'Wallace\'s Underground Labyrinth', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (4, 'Reclamation of Honor', 1, 'At Bilbaron Subterranean Fortress, open the treasure chests without waking the sleeping orcs.', 'Bilbaron Subterranean Fortress', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (5, 'Morgan\'s Web', 1, 'Slay giant spiders and gather 5 strands of spider silk.', 'Ancient Temple Ruins / Old Capital / Castle of the Dead: Catacombs', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (6, 'Ship Sleuthing', 1, 'Search for clues aboard the famed Elliot at Ghost Ship Cove.', 'Ghost Ship Cove', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (7, 'Must Love Hellhounds', 1, 'Withstand 5 attacks from a hellhound.', 'Forgotten Sanctuary / Mage\'s Tower', 'A (also B in Forgotten Sanctuary)');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (8, 'Henritta\'s Automatic Doll', 1, 'On the first floor of Mage\'s Tower, deflect magic with a giant shield and look for a doll in the opened room.', 'Mage\'s Tower', 'Any');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (9, 'Forest Clearing', 1, 'At Lost Woods, destroy 30 wood golems.', 'Lost Woods', 'Any');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (10, 'The Owlbear Menace', 1, 'Slay 10 owlbears.', 'Ancient Temple Ruins / Lost Woods / Mage\'s Tower', 'Any');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (11, 'Search and Resurrection', 2, 'Resurrect 30 sets of bones at the Canaan Temple.', 'Canaan Temple', 'N/A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (12, 'Harpy Adoption', 1, 'At the Ancient Temple Ruins, defeat the harpy without destroying the nest.', 'Ancient Temple Ruins', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (13, 'Steal Wyvern Eggs', 1, 'At Old Capital, collect 12 eggs dropped by female wyverns.', 'Old Capital', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (14, 'Doom Cocoons', 1, 'At Wallace\'s Underground Labyrinth, smash 5 doom beetle cocoons.', 'Wallace\'s Underground Labyrinth', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (15, 'Rescue the Children', 1, 'At Bilbaron Subterranean Fortress, defeat the minotaur within two minutes.', 'Bilbaron Subterranean Fortress', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (16, 'Save the Seamstresses', 1, 'At Castle of the Dead: Catacombs, save the girls and protect them from the vampires.', 'Castle of the Dead: Catacombs', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (17, 'Release the Genie', 1, 'At Ghost Ship Cove, use the magic lamp to call the genie 3 times.', 'Ghost Ship Cove', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (18, 'Decipher Golem Runes', 1, 'At Forgotten Sanctuary, destroy the enemy golem without activating the runes.', 'Forgotten Sanctuary', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (19, 'Peer into the Past', 1, 'At Mage\'s Tower, defeat the warlock leader of the underground organization alone.', 'Mage\'s Tower', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (20, 'Soul Gazing', 1, 'At Lost Woods, equip the urn and defeat a gazer alone.', 'Lost Woods\n', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (21, 'Crush Hydeland\'s Enemies', 1, 'Defeat 10 gladiators.', 'Forgotten Sanctuary / Mage\'s Tower / Lost Woods', 'Any');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (22, 'A Midsummer Day\'s Request', 3, 'Free 10 fairies trapped in cages in various locations.', 'Any', 'Any');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (23, 'Rite of Passage', 1, 'Wear the Amazons\' ritual armor and slay 50 orcs.', 'Ancient Temple Ruins / Old Capital / Bilbaron Subterranean Fortress', 'Any');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (24, 'Draconic History', 2, 'Investigate the room behind the wall painting within Ancient Temple Ruins.', 'Ancient Temple Ruins', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (25, 'Kill Killer Fish', 1, 'Slay 10 killer fish.', 'Old Capital / Lost Woods', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (26, 'Reacquire Research', 1, 'In a lab of Wallace\'s Underground Labyrinth, step on the floor switches in the proper order to open the chest.', 'Wallace\'s Underground Labyrinth', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (27, 'Flying Fortress Blueprints', 1, 'Find the treasure chest hidden in Bilbaron Subterranean Fortress that contains the blueprint.', 'Bilbaron Subterranean Fortress', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (28, 'Best of the Dead', 1, 'Defeat 5 dark skeleton swordsmen wights.', 'Ancient Temple Ruins / Old Capital / Wallace\'s Underground Labyrinth / Castle of the Dead: Catacombs / Ghost Ship Cove / Forgotten Sanctuary / Lost Woods', 'Any');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (29, 'Open Sesame', 2, 'Open the stone entrance somewhere in Ghost Ship Cove with rune magic.', 'Ghost Ship Cove', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (30, 'Harpy Problems', 1, 'Investigate Ancient Temple Ruins alone and defeat the harpy.', 'Ancient Temple Ruins', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (31, 'Mysterious Whispers', 1, 'Investigate the hidden room at Old Capital and obtain treasure.', 'Old Capital', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (32, 'Lima Ray\'s Resurrection', 2, 'Snuff the candles in the room with the magic circle at Wallace\'s Underground Labyrinth and search the statue of the false god.', 'Wallace\'s Underground Labyrinth', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (33, 'Church Cover-up', 1, 'At Castle of the Dead: Catacombs, defeat all vampires within two minutes.', 'Castle of the Dead: Catacombs', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (34, 'Hunt for the Forbidden Text', 1, 'At Mage\'s Tower, search the bookcase of the official and knock to open the hidden library.', 'Mage\'s Tower', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (35, 'Dead Master\'s Party', 1, 'At Castle of the Dead: Catacombs, turn three times clockwise in front of the ghost and dance.', 'Castle of the Dead: Catacombs', 'Any');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (36, 'Crystal Collection', 1, 'Obtain 20 amethysts from the crystal outcropping.', 'Lost Woods', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (37, 'Informer', 1, 'At Forgotten Sanctuary in the room with the blue door, show \"death\" with the runes to obtain information.', 'Forgotten Sanctuary', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (38, 'A Monk\'s Struggle', 1, 'At Forgotten Sanctuary, destroy the false god statue.', 'Forgotten Sanctuary', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (39, 'Magic Carpet Secrets', 1, 'At Mage\'s Tower, look for a tool used in magic carpet construction.', 'Mage\'s Tower', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (40, 'Submerged Memories', 1, 'At Lost Woods, steer a small boat into the vortex.', 'Lost Woods', 'A');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (41, 'Living Fossil', 1, 'Look for a young great sea serpent in the shallow waters of Ghost Ship Cove.', 'Ghost Ship Cove', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (42, 'Looks Can Kill', 1, 'At Ancient Temple Ruins, challenge Medusa alone and defeat her.', 'Ancient Temple Ruins', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (43, 'Cyclops Problems', 1, 'At Wallace\'s Underground Labyrinth, close the door to the cyclopes\' prison alone.', 'Wallace\'s Underground Labyrinth', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (44, 'Breach Gargoyle Gate', 1, 'Go to Gargoyle Gate at Bilbaron Subterranean Fortress alone and destroy it without anyone\'s help.', 'Bilbaron Subterranean Fortress', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (45, 'Family Matters', 1, 'At Castle of the Dead: Catacombs, defeat the wraith within two minutes.', 'Castle of the Dead: Catacombs', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (46, 'A Beast Most Foul', 1, 'Without anyone else\'s assistance, defeat the Killer Rabbit at Lost Woods.', 'Mage\'s Tower', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (47, 'Unnatural Life', 1, 'At Mage\'s Tower, defeat a chimera alone.', 'Mage\'s Tower', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (48, 'Myth Buster', 1, 'Go alone to Ghost Ship Cove and defeat the kraken.', 'Ghost Ship Cove', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (49, 'Contract Renegotiations', 1, 'At Forgotten Sanctuary, defeat the Arch Demon alone.', 'Forgotten Sanctuary', 'B');
INSERT INTO `quest` (`id`, `name`, `skill_points`, `description`, `location`, `path`) VALUES (50, 'Bear Witness', 1, 'At Old Capital, challenge the red dragon alone and defeat it within the treasure room.', 'Old Capital', 'B');

COMMIT;


-- -----------------------------------------------------
-- Data for table `player_class_has_quest`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 1);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 2);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 3);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 4);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 5);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 6);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 7);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 8);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 9);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 10);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 11);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 12);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 13);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 14);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 15);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 16);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 17);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 18);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 19);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 20);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 21);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 22);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 23);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 24);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 25);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 26);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 27);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 28);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 29);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 30);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 31);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 32);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 33);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 34);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 35);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 36);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 37);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 38);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 39);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 40);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 41);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 42);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 43);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 44);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 45);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 46);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 47);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 48);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 49);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (1, 50);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 1);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 2);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 3);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 4);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 5);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 6);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 7);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 8);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 9);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 10);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 11);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 12);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 13);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 14);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 15);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 16);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 17);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 18);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 19);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 20);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 21);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 22);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 23);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 24);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 25);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 26);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 27);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 28);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 29);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 30);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 31);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 32);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 33);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 34);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 35);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 36);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 37);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 38);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 39);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 40);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 41);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 42);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 43);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 44);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 45);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 46);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 47);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 48);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 49);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (2, 50);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 1);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 2);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 3);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 4);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 5);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 6);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 7);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 8);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 9);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 10);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 11);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 12);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 13);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 14);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 15);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 16);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 17);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 18);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 19);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 20);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 21);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 22);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 23);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 24);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 25);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 26);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 27);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 28);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 29);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 30);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 31);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 32);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 33);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 34);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 35);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 36);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 37);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 38);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 39);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 40);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 41);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 42);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 43);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 44);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 45);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 46);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 47);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 48);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 49);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (3, 50);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 1);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 2);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 3);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 4);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 5);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 6);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 7);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 8);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 9);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 10);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 11);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 12);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 13);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 14);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 15);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 16);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 17);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 18);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 19);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 20);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 21);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 22);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 23);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 24);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 25);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 26);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 27);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 28);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 29);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 30);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 31);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 32);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 33);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 34);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 35);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 36);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 37);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 38);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 39);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 40);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 41);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 42);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 43);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 44);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 45);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 46);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 47);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 48);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 49);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (4, 50);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 1);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 2);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 3);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 4);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 5);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 6);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 7);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 8);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 9);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 10);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 11);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 12);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 13);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 14);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 15);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 16);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 17);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 18);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 19);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 20);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 21);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 22);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 23);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 24);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 25);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 26);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 27);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 28);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 29);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 30);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 31);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 32);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 33);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 34);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 35);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 36);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 37);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 38);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 39);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 40);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 41);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 42);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 43);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 44);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 45);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 46);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 47);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 48);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 49);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (5, 50);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 1);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 2);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 3);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 4);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 5);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 6);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 7);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 8);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 9);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 10);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 11);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 12);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 13);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 14);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 15);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 16);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 17);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 18);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 19);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 20);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 21);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 22);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 23);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 24);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 25);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 26);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 27);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 28);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 29);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 30);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 31);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 32);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 33);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 34);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 35);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 36);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 37);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 38);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 39);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 40);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 41);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 42);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 43);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 44);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 45);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 46);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 47);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 48);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 49);
INSERT INTO `player_class_has_quest` (`player_class_id`, `quest_id`) VALUES (6, 50);

COMMIT;

