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
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`) VALUES (1, 'Fighter', 'Experts in battle, outfitted with full-plate armor and a sturdy shield. Boasting the stoutest defense of all classes, their shields can protect all allies in the nearby area. Their one-handed weapons have short reach, but they can swing them quickly, allowing them to make short work of nearby foes.', 'https://static.wikia.nocookie.net/dragons-crown/images/a/aa/Walking_animation.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/5/5e/DC_-_Fighter_-_02.png', 'https://atlus.com/dragonscrown/img/character/fighter/fightter_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157823264395346/fighter-portrait.png?ex=65dea054&is=65cc2b54&hm=9017b9edae302163441d1b5f5f855bee9226a0cb1d14e22458e14bb37c1a4d77&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_fighter.jpg', 'https://atlus.com/dragonscrown/img/character/fighter_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/d/d0/FighterT.gif', 'https://atlus.com/dragonscrown/img/character/fighter/fighter_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_001_fighter.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_001_fighter_on.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`) VALUES (2, 'Amazon', 'Dauntless warriors who know no fear as they effortlessly wield their two-handed weapons. Their massive equipment delivers vicious blows that deal lethal damage to multiple foes at once. Lightly armored, they are agile fighters who rely on punishing kicks when unarmed.', 'https://static.wikia.nocookie.net/dragons-crown/images/6/61/Amazon_Sprite_walk.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/c/cb/DC_-_Amazon_-_02.png', 'https://atlus.com/dragonscrown/img/character/amazon/amazon_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157822366818344/amazon-portrait.png?ex=65dea054&is=65cc2b54&hm=7402c1089c13c59871f711d9837ce9cd6ba9f52a63e5f610d3426158d02c2a46&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_amazon.jpg', 'https://atlus.com/dragonscrown/img/character/amazon_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/9/93/AmazonT.gif', 'https://atlus.com/dragonscrown/img/character/amazon/amazon_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_002_amazon.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_002_amazon_on.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`) VALUES (3, 'Elf', 'A long-lived forest race who are often much older than they appear to human eyes. While slight of body, they are deadly masters of the bow and arrow, using their superior athleticism to fight nimbly and fearlessly from a distance.', 'https://static.wikia.nocookie.net/dragons-crown/images/4/4d/Dragon%27s_Crown_Elf_Walk.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/d/d7/DC_-_Elf_-_02.png', 'https://atlus.com/dragonscrown/img/character/elf/elf_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157822995832872/elf-portrait.png?ex=65dea054&is=65cc2b54&hm=9ba3048b2f5671bd705fa8ec1bb29af8fd5af8c32ee67d3a0aa75f6be97ba77c&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_elf.jpg', 'https://atlus.com/dragonscrown/img/character/elf_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/9/91/ElfT2.gif', 'https://atlus.com/dragonscrown/img/character/elf/elf_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_004_elf.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_004_elf_on.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`) VALUES (4, 'Dwarf', 'Stocky fighters whose muscular frames permit them to wield a weapon in each hand. Their strength lets them pick up and throw anything in sight, even heavy foes. Throwing enemies lets them damage multiple foes with one fling, laying waste to an entire horde of adversaries.', 'https://static.wikia.nocookie.net/dragons-crown/images/c/cc/DC_-_Dwarf_Sprite.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/a/a4/DC_-_Dwarf_-_02.png', 'https://atlus.com/dragonscrown/img/character/dwarf/dwarf_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157822685577256/dwarf-portrait.png?ex=65dea054&is=65cc2b54&hm=cfc53cda237847ed4382644d181689efb81e9263e67584dc71e20d0b4de9ff81&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_dwarf.jpg', 'https://atlus.com/dragonscrown/img/character/dwarf_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/8/8a/DwarfT.gif', 'https://atlus.com/dragonscrown/img/character/dwarf/dwarf_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_005_dwarf.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_005_dwarf_on.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`) VALUES (5, 'Sorceress', 'Bewitching women with knowledge of dark magic. They are weak of body, but the great knowledge they wield of the arcane arts cannot be ignored. Sorceresses can create delicious food, control skeletons, and turn foes into harmless frogs. A jack-of-all-trades support class, they can provide aid to their friends in countless ways.', 'https://static.wikia.nocookie.net/dragons-crown/images/8/88/Dragons-crown-sorceress-walking-animation.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/1/1d/Sorceress_lg.png', 'https://atlus.com/dragonscrown/img/character/sorceress/sorceress_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157823558123580/sorceress-portrait.png?ex=65dea055&is=65cc2b55&hm=abe4a99325e573be169a2cf54349416c80d2e1c1ff15647205ee44713ba98841&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_sor.jpg', 'https://atlus.com/dragonscrown/img/character/sorceress_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/6/64/SorceressT.gif', 'https://atlus.com/dragonscrown/img/character/sorceress/sorceress_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_006_sor.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_006_sor_on.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`, `sprite_start_url`, `sprite_end_url`) VALUES (6, 'Wizard', 'Male magicians who have a wealth of magic at their beck and call. Unable to fend off monsters with strength, they instead rely on their spells, and are vital assets for any adventure.', 'https://static.wikia.nocookie.net/dragons-crown/images/9/97/DC_-_Wizard_Sprite.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/e/e9/DC_-_Wizard_-_02.png', 'https://atlus.com/dragonscrown/img/character/wizard/wizard_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157823864049704/wizard-portrait.png?ex=65dea055&is=65cc2b55&hm=f3f55e077ca77cb8afa09db9d0d095ec92c065ba036fb434584af355e723e4c5&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_wiz.jpg', 'https://atlus.com/dragonscrown/img/character/wizard_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/2/27/WizardT.gif', 'https://atlus.com/dragonscrown/img/character/wizard/wizard_lg.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_003_wiz.png', 'https://www.4gamer.net/img/sp_dragonscrown/img_dc_chara_003_wiz_on.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `class_stats`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (1, 1, 300, 16, 4, 14, 7, 12, 10, 0, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (2, 2, 303, 18, 5, 16, 8, 13, 11, 850, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (3, 3, 306, 19, 6, 18, 9, 14, 12, 1060, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (4, 4, 310, 21, 7, 19, 10, 16, 13, 1490, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (5, 5, 313, 23, 8, 21, 11, 17, 14, 1940, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (6, 6, 317, 25, 8, 23, 12, 19, 16, 2400, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (7, 7, 320, 27, 9, 25, 13, 20, 17, 2870, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (8, 8, 324, 29, 10, 27, 15, 22, 18, 3350, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (9, 9, 327, 31, 11, 29, 16, 24, 19, 3850, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (10, 10, 331, 33, 11, 31, 17, 25, 20, 4370, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (11, 11, 335, 35, 12, 33, 18, 27, 22, 4900, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (12, 12, 338, 37, 13, 35, 19, 29, 23, 5450, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (13, 13, 342, 40, 13, 37, 21, 31, 24, 6010, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (14, 14, 346, 42, 14, 40, 22, 33, 26, 6590, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (15, 15, 349, 44, 15, 42, 24, 35, 27, 7190, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (16, 16, 353, 47, 16, 45, 26, 37, 29, 7810, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (17, 17, 357, 50, 17, 47, 27, 39, 31, 8440, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (18, 18, 361, 53, 18, 51, 29, 41, 33, 9340, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (19, 19, 364, 56, 19, 54, 31, 43, 35, 10510, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (20, 20, 368, 59, 20, 56, 33, 45, 37, 11800, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (21, 21, 372, 62, 21, 59, 35, 47, 39, 13200, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (22, 22, 375, 65, 23, 63, 37, 49, 41, 14740, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (23, 23, 379, 69, 24, 66, 39, 51, 43, 16420, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (24, 24, 382, 72, 25, 68, 41, 53, 45, 18260, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (25, 25, 386, 75, 27, 71, 43, 56, 47, 20270, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (26, 26, 389, 78, 27, 75, 45, 58, 49, 22460, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (27, 27, 393, 82, 28, 78, 46, 61, 51, 24850, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (28, 28, 396, 85, 29, 81, 49, 63, 53, 27450, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (29, 29, 399, 88, 31, 84, 50, 66, 55, 30280, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (30, 30, 402, 92, 32, 88, 52, 68, 57, 33370, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (31, 31, 406, 95, 33, 91, 54, 71, 59, 36720, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (32, 32, 409, 99, 34, 94, 55, 73, 62, 40370, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (33, 33, 412, 102, 35, 97, 57, 76, 64, 44340, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (34, 34, 415, 105, 36, 101, 58, 78, 66, 48650, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (35, 35, 418, 109, 38, 104, 60, 81, 68, 53320, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (36, 36, 420, 112, 39, 107, 62, 83, 70, 62950, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (37, 37, 423, 115, 40, 110, 64, 86, 72, 68280, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (38, 38, 426, 119, 40, 113, 66, 88, 74, 74000, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (39, 39, 429, 122, 42, 116, 68, 91, 76, 80140, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (40, 40, 431, 125, 43, 119, 70, 93, 78, 86740, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (41, 41, 434, 128, 44, 122, 72, 95, 80, 93810, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (42, 42, 436, 131, 46, 126, 74, 98, 82, 101390, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (43, 43, 439, 135, 46, 128, 76, 100, 84, 109520, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (44, 44, 441, 138, 47, 131, 78, 102, 86, 118230, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (45, 45, 443, 141, 49, 134, 80, 105, 88, 127570, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (46, 46, 445, 144, 50, 137, 82, 107, 90, 137570, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (47, 47, 447, 147, 50, 140, 83, 109, 92, 148280, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (48, 48, 449, 150, 51, 142, 85, 111, 93, 159740, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (49, 49, 451, 152, 53, 145, 86, 114, 95, 172020, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (50, 50, 453, 155, 54, 148, 88, 116, 97, 190020, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (51, 51, 455, 158, 54, 151, 90, 118, 99, 205480, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (52, 52, 457, 161, 56, 153, 92, 120, 100, 222110, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (53, 53, 459, 163, 57, 156, 94, 122, 102, 239990, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (54, 54, 461, 166, 57, 159, 95, 124, 104, 259200, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (55, 55, 462, 168, 59, 161, 97, 126, 105, 279840, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (56, 56, 464, 171, 59, 163, 99, 127, 107, 302020, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (57, 57, 465, 173, 60, 165, 100, 129, 108, 325850, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (58, 58, 467, 176, 61, 168, 102, 131, 110, 351430, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (59, 59, 468, 178, 62, 171, 103, 133, 111, 378890, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (60, 60, 470, 180, 63, 173, 105, 135, 113, 408380, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (61, 61, 471, 183, 63, 174, 107, 136, 114, 440020, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (62, 62, 472, 185, 65, 177, 108, 138, 115, 473970, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (63, 63, 474, 187, 66, 179, 110, 140, 117, 510380, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (64, 64, 475, 189, 66, 181, 111, 141, 118, 549450, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (65, 65, 476, 191, 68, 183, 113, 143, 119, 591340, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (66, 66, 477, 193, 68, 186, 115, 144, 121, 680460, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (67, 67, 478, 195, 69, 187, 116, 146, 122, 732280, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (68, 68, 479, 197, 69, 189, 117, 147, 123, 787850, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (69, 69, 480, 199, 70, 191, 118, 148, 124, 847430, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (70, 70, 481, 201, 71, 193, 120, 150, 125, 911290, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (71, 71, 482, 202, 71, 195, 122, 151, 126, 979730, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (72, 72, 483, 204, 73, 196, 123, 152, 127, 1053070, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (73, 73, 484, 206, 73, 198, 124, 154, 128, 1131650, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (74, 74, 485, 207, 74, 200, 125, 155, 129, 1215830, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (75, 75, 486, 209, 75, 201, 127, 156, 130, 1305990, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (76, 76, 486, 210, 75, 203, 128, 157, 131, 1402550, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (77, 77, 487, 212, 76, 204, 129, 158, 132, 1505940, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (78, 78, 488, 213, 76, 206, 131, 159, 133, 1616630, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (79, 79, 489, 215, 77, 207, 131, 160, 134, 1735120, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (80, 80, 489, 216, 78, 209, 133, 161, 135, 1876490, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (81, 81, 490, 217, 78, 210, 134, 162, 136, 2008370, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (82, 82, 491, 219, 79, 212, 135, 163, 137, 2149120, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (83, 83, 491, 220, 80, 213, 136, 164, 137, 2299330, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (84, 84, 492, 221, 80, 214, 137, 165, 138, 2459610, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (85, 85, 492, 222, 81, 215, 139, 166, 139, 2630620, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (86, 86, 493, 223, 82, 217, 140, 167, 139, 2813050, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (87, 87, 493, 224, 82, 218, 141, 168, 140, 3007640, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (88, 88, 494, 225, 82, 219, 142, 168, 141, 3215180, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (89, 89, 494, 227, 83, 220, 142, 169, 141, 3436490, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (90, 90, 495, 228, 84, 222, 144, 170, 142, 3672470, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (91, 91, 495, 228, 84, 223, 145, 171, 143, 3924070, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (92, 92, 496, 229, 85, 223, 146, 171, 143, 4192270, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (93, 93, 496, 230, 85, 224, 147, 172, 144, 4478160, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (94, 94, 497, 231, 86, 226, 147, 173, 144, 4782850, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (95, 95, 497, 232, 87, 227, 149, 173, 145, 5107550, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (96, 96, 498, 233, 87, 227, 150, 174, 145, 5453550, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (97, 97, 498, 234, 88, 228, 151, 175, 146, 5822190, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (98, 98, 499, 234, 88, 230, 152, 175, 146, 6214910, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (99, 99, 500, 235, 89, 230, 152, 176, 147, 6736730, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (100, 1, 300, 14, 7, 10, 8, 11, 13, 0, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (101, 2, 303, 15, 8, 11, 9, 12, 14, 850, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (102, 3, 306, 17, 8, 12, 10, 13, 16, 1060, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (103, 4, 310, 18, 9, 13, 11, 15, 17, 1490, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (104, 5, 313, 20, 10, 14, 12, 16, 19, 1940, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (105, 6, 317, 22, 11, 16, 13, 17, 20, 2400, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (106, 7, 320, 24, 12, 17, 16, 19, 22, 2870, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (107, 8, 324, 26, 13, 19, 17, 20, 23, 3350, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (108, 9, 327, 28, 14, 21, 19, 22, 25, 3850, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (109, 10, 331, 30, 15, 23, 20, 23, 27, 4370, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (110, 11, 335, 32, 16, 25, 22, 25, 29, 4900, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (111, 12, 338, 34, 17, 26, 23, 26, 31, 5450, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (112, 13, 342, 36, 18, 29, 26, 28, 33, 6010, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (113, 14, 346, 38, 19, 31, 27, 29, 35, 6590, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (114, 15, 349, 40, 20, 32, 30, 31, 37, 7190, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (115, 16, 353, 42, 21, 35, 31, 32, 39, 7810, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (116, 17, 357, 44, 22, 37, 33, 34, 41, 8440, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (117, 18, 361, 46, 23, 39, 35, 36, 43, 9340, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (118, 19, 364, 49, 25, 42, 37, 38, 45, 10510, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (119, 20, 368, 51, 26, 44, 39, 40, 47, 11800, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (120, 21, 372, 54, 27, 46, 42, 42, 50, 13200, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (121, 22, 375, 57, 29, 49, 43, 44, 52, 14740, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (122, 23, 379, 60, 30, 51, 46, 46, 55, 16420, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (123, 24, 382, 62, 32, 53, 47, 48, 58, 18260, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (124, 25, 386, 65, 33, 56, 50, 51, 60, 20270, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (125, 26, 389, 68, 35, 58, 52, 53, 63, 22460, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (126, 27, 393, 71, 36, 60, 54, 55, 66, 24850, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (127, 28, 396, 74, 38, 63, 56, 58, 69, 27450, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (128, 29, 399, 77, 39, 65, 59, 60, 71, 30280, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (129, 30, 402, 80, 41, 68, 60, 62, 74, 33370, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (130, 31, 406, 83, 42, 70, 63, 65, 77, 36720, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (131, 32, 409, 86, 43, 73, 65, 67, 80, 40370, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (132, 33, 412, 89, 45, 76, 67, 69, 82, 44340, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (133, 34, 415, 92, 46, 78, 69, 71, 85, 48650, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (134, 35, 418, 95, 48, 80, 72, 74, 88, 53320, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (135, 36, 420, 98, 49, 83, 74, 76, 90, 62950, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (136, 37, 423, 101, 51, 85, 76, 78, 93, 68280, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (137, 38, 426, 103, 52, 87, 78, 81, 96, 74000, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (138, 39, 429, 106, 54, 90, 80, 83, 98, 80140, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (139, 40, 431, 109, 55, 92, 82, 85, 101, 86740, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (140, 41, 434, 112, 56, 94, 85, 87, 104, 93810, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (141, 42, 436, 115, 58, 97, 86, 89, 106, 101390, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (142, 43, 439, 117, 59, 99, 89, 92, 109, 109520, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (143, 44, 441, 120, 61, 101, 90, 94, 111, 118230, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (144, 45, 443, 123, 62, 104, 93, 96, 114, 127570, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (145, 46, 445, 125, 63, 106, 94, 98, 116, 137570, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (146, 47, 447, 128, 64, 108, 97, 100, 119, 148280, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (147, 48, 449, 130, 66, 110, 98, 102, 121, 159740, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (148, 49, 451, 133, 67, 112, 101, 104, 123, 172020, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (149, 50, 453, 135, 68, 115, 102, 106, 126, 190020, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (150, 51, 455, 138, 69, 117, 104, 108, 128, 205480, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (151, 52, 457, 140, 71, 118, 106, 110, 130, 222110, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (152, 53, 459, 143, 72, 121, 108, 111, 132, 239990, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (153, 54, 461, 145, 73, 123, 109, 113, 134, 259200, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (154, 55, 462, 147, 74, 124, 112, 115, 136, 279840, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (155, 56, 464, 149, 75, 127, 113, 117, 138, 302020, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (156, 57, 465, 151, 76, 128, 115, 118, 140, 325850, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (157, 58, 467, 153, 77, 130, 116, 120, 142, 351430, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (158, 59, 468, 156, 78, 132, 119, 122, 144, 378890, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (159, 60, 470, 158, 79, 134, 120, 123, 146, 408380, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (160, 61, 471, 159, 80, 135, 122, 125, 148, 440020, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (161, 62, 472, 161, 81, 137, 123, 126, 150, 473970, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (162, 63, 474, 163, 82, 139, 125, 128, 151, 510380, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (163, 64, 475, 165, 83, 140, 126, 129, 153, 549450, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (164, 65, 476, 167, 84, 142, 128, 130, 155, 591340, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (165, 66, 477, 169, 85, 144, 129, 132, 156, 680460, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (166, 67, 478, 170, 86, 145, 131, 133, 158, 732280, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (167, 68, 479, 172, 86, 147, 132, 134, 159, 787850, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (168, 69, 480, 174, 87, 148, 134, 136, 161, 847430, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (169, 70, 481, 175, 88, 150, 135, 137, 162, 911290, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (170, 71, 482, 177, 89, 151, 137, 138, 164, 979730, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (171, 72, 483, 178, 90, 152, 138, 139, 165, 1053070, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (172, 73, 484, 180, 90, 154, 139, 140, 167, 1131650, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (173, 74, 485, 181, 91, 155, 140, 142, 168, 1215830, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (174, 75, 486, 182, 92, 156, 142, 143, 169, 1305990, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (175, 76, 486, 184, 92, 158, 143, 144, 170, 1402550, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (176, 77, 487, 185, 93, 159, 144, 145, 172, 1505940, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (177, 78, 488, 186, 94, 160, 145, 146, 173, 1616630, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (178, 79, 489, 187, 94, 162, 147, 147, 174, 1735120, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (179, 80, 489, 189, 95, 163, 148, 148, 175, 1876490, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (180, 81, 490, 190, 95, 164, 149, 148, 176, 2008370, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (181, 82, 491, 191, 96, 166, 150, 149, 177, 2149120, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (182, 83, 491, 192, 96, 166, 151, 150, 178, 2299330, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (183, 84, 492, 193, 97, 167, 152, 151, 179, 2459610, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (184, 85, 492, 194, 98, 169, 154, 152, 180, 2630620, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (185, 86, 493, 195, 98, 169, 154, 153, 181, 2813050, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (186, 87, 493, 196, 99, 170, 156, 153, 182, 3007640, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (187, 88, 494, 197, 99, 172, 156, 154, 183, 3215180, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (188, 89, 494, 198, 99, 172, 158, 155, 183, 3436490, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (189, 90, 495, 199, 100, 174, 158, 155, 184, 3672470, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (190, 91, 495, 200, 100, 175, 160, 156, 185, 3924070, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (191, 92, 496, 200, 101, 175, 160, 157, 186, 4192270, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (192, 93, 496, 201, 101, 176, 161, 157, 187, 4478160, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (193, 94, 497, 202, 101, 177, 162, 158, 187, 4782850, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (194, 95, 497, 203, 102, 178, 163, 159, 188, 5107550, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (195, 96, 498, 203, 102, 179, 164, 159, 189, 5453550, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (196, 97, 498, 204, 103, 180, 165, 160, 189, 5822190, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (197, 98, 499, 205, 103, 181, 166, 160, 190, 6214910, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (198, 99, 500, 205, 103, 182, 167, 161, 191, 6736730, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (199, 1, 300, 16, 4, 14, 7, 12, 10, 0, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (200, 2, 303, 18, 5, 16, 8, 13, 11, 850, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (201, 3, 306, 19, 6, 18, 9, 14, 12, 1060, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (202, 4, 310, 21, 7, 19, 10, 16, 13, 1490, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (203, 5, 313, 23, 8, 21, 11, 17, 14, 1940, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (204, 6, 317, 25, 8, 23, 12, 19, 16, 2400, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (205, 7, 320, 27, 9, 25, 13, 20, 17, 2870, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (206, 8, 324, 29, 10, 27, 15, 22, 18, 3350, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (207, 9, 327, 31, 11, 29, 16, 24, 19, 3850, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (208, 10, 331, 33, 11, 31, 17, 25, 20, 4370, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (209, 11, 335, 35, 12, 33, 18, 27, 22, 4900, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (210, 12, 338, 37, 13, 35, 19, 29, 23, 5450, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (211, 13, 342, 40, 13, 37, 21, 31, 24, 6010, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (212, 14, 346, 42, 14, 40, 22, 33, 26, 6590, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (213, 15, 349, 44, 15, 42, 24, 35, 27, 7190, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (214, 16, 353, 47, 16, 45, 26, 37, 29, 7810, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (215, 17, 357, 50, 17, 47, 27, 39, 31, 8440, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (216, 18, 361, 53, 18, 51, 29, 41, 33, 9340, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (217, 19, 364, 56, 19, 54, 31, 43, 35, 10510, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (218, 20, 368, 59, 20, 56, 33, 45, 37, 11800, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (219, 21, 372, 62, 21, 59, 35, 47, 39, 13200, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (220, 22, 375, 65, 23, 63, 37, 49, 41, 14740, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (221, 23, 379, 69, 24, 66, 39, 51, 43, 16420, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (222, 24, 382, 72, 25, 68, 41, 53, 45, 18260, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (223, 25, 386, 75, 27, 71, 43, 56, 47, 20270, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (224, 26, 389, 78, 27, 75, 45, 58, 49, 22460, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (225, 27, 393, 82, 28, 78, 46, 61, 51, 24850, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (226, 28, 396, 85, 29, 81, 49, 63, 53, 27450, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (227, 29, 399, 88, 31, 84, 50, 66, 55, 30280, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (228, 30, 402, 92, 32, 88, 52, 68, 57, 33370, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (229, 31, 406, 95, 33, 91, 54, 71, 59, 36720, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (230, 32, 409, 99, 34, 94, 55, 73, 62, 40370, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (231, 33, 412, 102, 35, 97, 57, 76, 64, 44340, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (232, 34, 415, 105, 36, 101, 58, 78, 66, 48650, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (233, 35, 418, 109, 38, 104, 60, 81, 68, 53320, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (234, 36, 420, 112, 39, 107, 62, 83, 70, 62950, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (235, 37, 423, 115, 40, 110, 64, 86, 72, 68280, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (236, 38, 426, 119, 40, 113, 66, 88, 74, 74000, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (237, 39, 429, 122, 42, 116, 68, 91, 76, 80140, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (238, 40, 431, 125, 43, 119, 70, 93, 78, 86740, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (239, 41, 434, 128, 44, 122, 72, 95, 80, 93810, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (240, 42, 436, 131, 46, 126, 74, 98, 82, 101390, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (241, 43, 439, 135, 46, 128, 76, 100, 84, 109520, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (242, 44, 441, 138, 47, 131, 78, 102, 86, 118230, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (243, 45, 443, 141, 49, 134, 80, 105, 88, 127570, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (244, 46, 445, 144, 50, 137, 82, 107, 90, 137570, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (245, 47, 447, 147, 50, 140, 83, 109, 92, 148280, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (246, 48, 449, 150, 51, 142, 85, 111, 93, 159740, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (247, 49, 451, 152, 53, 145, 86, 114, 95, 172020, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (248, 50, 453, 155, 54, 148, 88, 116, 97, 190020, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (249, 51, 455, 158, 54, 151, 90, 118, 99, 205480, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (250, 52, 457, 161, 56, 153, 92, 120, 100, 222110, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (251, 53, 459, 163, 57, 156, 94, 122, 102, 239990, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (252, 54, 461, 166, 57, 159, 95, 124, 104, 259200, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (253, 55, 462, 168, 59, 161, 97, 126, 105, 279840, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (254, 56, 464, 171, 59, 163, 99, 127, 107, 302020, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (255, 57, 465, 173, 60, 165, 100, 129, 108, 325850, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (256, 58, 467, 176, 61, 168, 102, 131, 110, 351430, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (257, 59, 468, 178, 62, 171, 103, 133, 111, 378890, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (258, 60, 470, 180, 63, 173, 105, 135, 113, 408380, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (259, 61, 471, 183, 63, 174, 107, 136, 114, 440020, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (260, 62, 472, 185, 65, 177, 108, 138, 115, 473970, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (261, 63, 474, 187, 66, 179, 110, 140, 117, 510380, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (262, 64, 475, 189, 66, 181, 111, 141, 118, 549450, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (263, 65, 476, 191, 68, 183, 113, 143, 119, 591340, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (264, 66, 477, 193, 68, 186, 115, 144, 121, 680460, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (265, 67, 478, 195, 69, 187, 116, 146, 122, 732280, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (266, 68, 479, 197, 69, 189, 117, 147, 123, 787850, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (267, 69, 480, 199, 70, 191, 118, 148, 124, 847430, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (268, 70, 481, 201, 71, 193, 120, 150, 125, 911290, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (269, 71, 482, 202, 71, 195, 122, 151, 126, 979730, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (270, 72, 483, 204, 73, 196, 123, 152, 127, 1053070, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (271, 73, 484, 206, 73, 198, 124, 154, 128, 1131650, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (272, 74, 485, 207, 74, 200, 125, 155, 129, 1215830, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (273, 75, 486, 209, 75, 201, 127, 156, 130, 1305990, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (274, 76, 486, 210, 75, 203, 128, 157, 131, 1402550, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (275, 77, 487, 212, 76, 204, 129, 158, 132, 1505940, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (276, 78, 488, 213, 76, 206, 131, 159, 133, 1616630, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (277, 79, 489, 215, 77, 207, 131, 160, 134, 1735120, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (278, 80, 489, 216, 78, 209, 133, 161, 135, 1876490, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (279, 81, 490, 217, 78, 210, 134, 162, 136, 2008370, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (280, 82, 491, 219, 79, 212, 135, 163, 137, 2149120, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (281, 83, 491, 220, 80, 213, 136, 164, 137, 2299330, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (282, 84, 492, 221, 80, 214, 137, 165, 138, 2459610, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (283, 85, 492, 222, 81, 215, 139, 166, 139, 2630620, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (284, 86, 493, 223, 82, 217, 140, 167, 139, 2813050, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (285, 87, 493, 224, 82, 218, 141, 168, 140, 3007640, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (286, 88, 494, 225, 82, 219, 142, 168, 141, 3215180, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (287, 89, 494, 227, 83, 220, 142, 169, 141, 3436490, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (288, 90, 495, 228, 84, 222, 144, 170, 142, 3672470, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (289, 91, 495, 228, 84, 223, 145, 171, 143, 3924070, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (290, 92, 496, 229, 85, 223, 146, 171, 143, 4192270, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (291, 93, 496, 230, 85, 224, 147, 172, 144, 4478160, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (292, 94, 497, 231, 86, 226, 147, 173, 144, 4782850, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (293, 95, 497, 232, 87, 227, 149, 173, 145, 5107550, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (294, 96, 498, 233, 87, 227, 150, 174, 145, 5453550, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (295, 97, 498, 234, 88, 228, 151, 175, 146, 5822190, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (296, 98, 499, 234, 88, 230, 152, 175, 146, 6214910, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (297, 99, 500, 235, 89, 230, 152, 176, 147, 6736730, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (298, 1, 300, 16, 4, 14, 7, 12, 10, 0, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (299, 2, 303, 18, 5, 16, 8, 13, 11, 850, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (300, 3, 306, 19, 6, 18, 9, 14, 12, 1060, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (301, 4, 310, 21, 7, 19, 10, 16, 13, 1490, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (302, 5, 313, 23, 8, 21, 11, 17, 14, 1940, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (303, 6, 317, 25, 8, 23, 12, 19, 16, 2400, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (304, 7, 320, 27, 9, 25, 13, 20, 17, 2870, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (305, 8, 324, 29, 10, 27, 15, 22, 18, 3350, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (306, 9, 327, 31, 11, 29, 16, 24, 19, 3850, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (307, 10, 331, 33, 11, 31, 17, 25, 20, 4370, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (308, 11, 335, 35, 12, 33, 18, 27, 22, 4900, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (309, 12, 338, 37, 13, 35, 19, 29, 23, 5450, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (310, 13, 342, 40, 13, 37, 21, 31, 24, 6010, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (311, 14, 346, 42, 14, 40, 22, 33, 26, 6590, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (312, 15, 349, 44, 15, 42, 24, 35, 27, 7190, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (313, 16, 353, 47, 16, 45, 26, 37, 29, 7810, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (314, 17, 357, 50, 17, 47, 27, 39, 31, 8440, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (315, 18, 361, 53, 18, 51, 29, 41, 33, 9340, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (316, 19, 364, 56, 19, 54, 31, 43, 35, 10510, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (317, 20, 368, 59, 20, 56, 33, 45, 37, 11800, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (318, 21, 372, 62, 21, 59, 35, 47, 39, 13200, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (319, 22, 375, 65, 23, 63, 37, 49, 41, 14740, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (320, 23, 379, 69, 24, 66, 39, 51, 43, 16420, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (321, 24, 382, 72, 25, 68, 41, 53, 45, 18260, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (322, 25, 386, 75, 27, 71, 43, 56, 47, 20270, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (323, 26, 389, 78, 27, 75, 45, 58, 49, 22460, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (324, 27, 393, 82, 28, 78, 46, 61, 51, 24850, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (325, 28, 396, 85, 29, 81, 49, 63, 53, 27450, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (326, 29, 399, 88, 31, 84, 50, 66, 55, 30280, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (327, 30, 402, 92, 32, 88, 52, 68, 57, 33370, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (328, 31, 406, 95, 33, 91, 54, 71, 59, 36720, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (329, 32, 409, 99, 34, 94, 55, 73, 62, 40370, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (330, 33, 412, 102, 35, 97, 57, 76, 64, 44340, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (331, 34, 415, 105, 36, 101, 58, 78, 66, 48650, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (332, 35, 418, 109, 38, 104, 60, 81, 68, 53320, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (333, 36, 420, 112, 39, 107, 62, 83, 70, 62950, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (334, 37, 423, 115, 40, 110, 64, 86, 72, 68280, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (335, 38, 426, 119, 40, 113, 66, 88, 74, 74000, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (336, 39, 429, 122, 42, 116, 68, 91, 76, 80140, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (337, 40, 431, 125, 43, 119, 70, 93, 78, 86740, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (338, 41, 434, 128, 44, 122, 72, 95, 80, 93810, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (339, 42, 436, 131, 46, 126, 74, 98, 82, 101390, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (340, 43, 439, 135, 46, 128, 76, 100, 84, 109520, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (341, 44, 441, 138, 47, 131, 78, 102, 86, 118230, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (342, 45, 443, 141, 49, 134, 80, 105, 88, 127570, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (343, 46, 445, 144, 50, 137, 82, 107, 90, 137570, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (344, 47, 447, 147, 50, 140, 83, 109, 92, 148280, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (345, 48, 449, 150, 51, 142, 85, 111, 93, 159740, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (346, 49, 451, 152, 53, 145, 86, 114, 95, 172020, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (347, 50, 453, 155, 54, 148, 88, 116, 97, 190020, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (348, 51, 455, 158, 54, 151, 90, 118, 99, 205480, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (349, 52, 457, 161, 56, 153, 92, 120, 100, 222110, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (350, 53, 459, 163, 57, 156, 94, 122, 102, 239990, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (351, 54, 461, 166, 57, 159, 95, 124, 104, 259200, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (352, 55, 462, 168, 59, 161, 97, 126, 105, 279840, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (353, 56, 464, 171, 59, 163, 99, 127, 107, 302020, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (354, 57, 465, 173, 60, 165, 100, 129, 108, 325850, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (355, 58, 467, 176, 61, 168, 102, 131, 110, 351430, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (356, 59, 468, 178, 62, 171, 103, 133, 111, 378890, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (357, 60, 470, 180, 63, 173, 105, 135, 113, 408380, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (358, 61, 471, 183, 63, 174, 107, 136, 114, 440020, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (359, 62, 472, 185, 65, 177, 108, 138, 115, 473970, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (360, 63, 474, 187, 66, 179, 110, 140, 117, 510380, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (361, 64, 475, 189, 66, 181, 111, 141, 118, 549450, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (362, 65, 476, 191, 68, 183, 113, 143, 119, 591340, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (363, 66, 477, 193, 68, 186, 115, 144, 121, 680460, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (364, 67, 478, 195, 69, 187, 116, 146, 122, 732280, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (365, 68, 479, 197, 69, 189, 117, 147, 123, 787850, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (366, 69, 480, 199, 70, 191, 118, 148, 124, 847430, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (367, 70, 481, 201, 71, 193, 120, 150, 125, 911290, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (368, 71, 482, 202, 71, 195, 122, 151, 126, 979730, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (369, 72, 483, 204, 73, 196, 123, 152, 127, 1053070, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (370, 73, 484, 206, 73, 198, 124, 154, 128, 1131650, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (371, 74, 485, 207, 74, 200, 125, 155, 129, 1215830, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (372, 75, 486, 209, 75, 201, 127, 156, 130, 1305990, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (373, 76, 486, 210, 75, 203, 128, 157, 131, 1402550, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (374, 77, 487, 212, 76, 204, 129, 158, 132, 1505940, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (375, 78, 488, 213, 76, 206, 131, 159, 133, 1616630, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (376, 79, 489, 215, 77, 207, 131, 160, 134, 1735120, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (377, 80, 489, 216, 78, 209, 133, 161, 135, 1876490, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (378, 81, 490, 217, 78, 210, 134, 162, 136, 2008370, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (379, 82, 491, 219, 79, 212, 135, 163, 137, 2149120, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (380, 83, 491, 220, 80, 213, 136, 164, 137, 2299330, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (381, 84, 492, 221, 80, 214, 137, 165, 138, 2459610, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (382, 85, 492, 222, 81, 215, 139, 166, 139, 2630620, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (383, 86, 493, 223, 82, 217, 140, 167, 139, 2813050, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (384, 87, 493, 224, 82, 218, 141, 168, 140, 3007640, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (385, 88, 494, 225, 82, 219, 142, 168, 141, 3215180, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (386, 89, 494, 227, 83, 220, 142, 169, 141, 3436490, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (387, 90, 495, 228, 84, 222, 144, 170, 142, 3672470, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (388, 91, 495, 228, 84, 223, 145, 171, 143, 3924070, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (389, 92, 496, 229, 85, 223, 146, 171, 143, 4192270, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (390, 93, 496, 230, 85, 224, 147, 172, 144, 4478160, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (391, 94, 497, 231, 86, 226, 147, 173, 144, 4782850, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (392, 95, 497, 232, 87, 227, 149, 173, 145, 5107550, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (393, 96, 498, 233, 87, 227, 150, 174, 145, 5453550, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (394, 97, 498, 234, 88, 228, 151, 175, 146, 5822190, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (395, 98, 499, 234, 88, 230, 152, 175, 146, 6214910, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (396, 99, 500, 235, 89, 230, 152, 176, 147, 6736730, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (397, 1, 300, 16, 4, 14, 7, 12, 10, 0, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (398, 2, 303, 18, 5, 16, 8, 13, 11, 850, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (399, 3, 306, 19, 6, 18, 9, 14, 12, 1060, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (400, 4, 310, 21, 7, 19, 10, 16, 13, 1490, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (401, 5, 313, 23, 8, 21, 11, 17, 14, 1940, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (402, 6, 317, 25, 8, 23, 12, 19, 16, 2400, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (403, 7, 320, 27, 9, 25, 13, 20, 17, 2870, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (404, 8, 324, 29, 10, 27, 15, 22, 18, 3350, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (405, 9, 327, 31, 11, 29, 16, 24, 19, 3850, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (406, 10, 331, 33, 11, 31, 17, 25, 20, 4370, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (407, 11, 335, 35, 12, 33, 18, 27, 22, 4900, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (408, 12, 338, 37, 13, 35, 19, 29, 23, 5450, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (409, 13, 342, 40, 13, 37, 21, 31, 24, 6010, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (410, 14, 346, 42, 14, 40, 22, 33, 26, 6590, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (411, 15, 349, 44, 15, 42, 24, 35, 27, 7190, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (412, 16, 353, 47, 16, 45, 26, 37, 29, 7810, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (413, 17, 357, 50, 17, 47, 27, 39, 31, 8440, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (414, 18, 361, 53, 18, 51, 29, 41, 33, 9340, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (415, 19, 364, 56, 19, 54, 31, 43, 35, 10510, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (416, 20, 368, 59, 20, 56, 33, 45, 37, 11800, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (417, 21, 372, 62, 21, 59, 35, 47, 39, 13200, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (418, 22, 375, 65, 23, 63, 37, 49, 41, 14740, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (419, 23, 379, 69, 24, 66, 39, 51, 43, 16420, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (420, 24, 382, 72, 25, 68, 41, 53, 45, 18260, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (421, 25, 386, 75, 27, 71, 43, 56, 47, 20270, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (422, 26, 389, 78, 27, 75, 45, 58, 49, 22460, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (423, 27, 393, 82, 28, 78, 46, 61, 51, 24850, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (424, 28, 396, 85, 29, 81, 49, 63, 53, 27450, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (425, 29, 399, 88, 31, 84, 50, 66, 55, 30280, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (426, 30, 402, 92, 32, 88, 52, 68, 57, 33370, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (427, 31, 406, 95, 33, 91, 54, 71, 59, 36720, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (428, 32, 409, 99, 34, 94, 55, 73, 62, 40370, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (429, 33, 412, 102, 35, 97, 57, 76, 64, 44340, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (430, 34, 415, 105, 36, 101, 58, 78, 66, 48650, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (431, 35, 418, 109, 38, 104, 60, 81, 68, 53320, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (432, 36, 420, 112, 39, 107, 62, 83, 70, 62950, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (433, 37, 423, 115, 40, 110, 64, 86, 72, 68280, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (434, 38, 426, 119, 40, 113, 66, 88, 74, 74000, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (435, 39, 429, 122, 42, 116, 68, 91, 76, 80140, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (436, 40, 431, 125, 43, 119, 70, 93, 78, 86740, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (437, 41, 434, 128, 44, 122, 72, 95, 80, 93810, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (438, 42, 436, 131, 46, 126, 74, 98, 82, 101390, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (439, 43, 439, 135, 46, 128, 76, 100, 84, 109520, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (440, 44, 441, 138, 47, 131, 78, 102, 86, 118230, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (441, 45, 443, 141, 49, 134, 80, 105, 88, 127570, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (442, 46, 445, 144, 50, 137, 82, 107, 90, 137570, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (443, 47, 447, 147, 50, 140, 83, 109, 92, 148280, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (444, 48, 449, 150, 51, 142, 85, 111, 93, 159740, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (445, 49, 451, 152, 53, 145, 86, 114, 95, 172020, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (446, 50, 453, 155, 54, 148, 88, 116, 97, 190020, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (447, 51, 455, 158, 54, 151, 90, 118, 99, 205480, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (448, 52, 457, 161, 56, 153, 92, 120, 100, 222110, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (449, 53, 459, 163, 57, 156, 94, 122, 102, 239990, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (450, 54, 461, 166, 57, 159, 95, 124, 104, 259200, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (451, 55, 462, 168, 59, 161, 97, 126, 105, 279840, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (452, 56, 464, 171, 59, 163, 99, 127, 107, 302020, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (453, 57, 465, 173, 60, 165, 100, 129, 108, 325850, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (454, 58, 467, 176, 61, 168, 102, 131, 110, 351430, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (455, 59, 468, 178, 62, 171, 103, 133, 111, 378890, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (456, 60, 470, 180, 63, 173, 105, 135, 113, 408380, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (457, 61, 471, 183, 63, 174, 107, 136, 114, 440020, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (458, 62, 472, 185, 65, 177, 108, 138, 115, 473970, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (459, 63, 474, 187, 66, 179, 110, 140, 117, 510380, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (460, 64, 475, 189, 66, 181, 111, 141, 118, 549450, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (461, 65, 476, 191, 68, 183, 113, 143, 119, 591340, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (462, 66, 477, 193, 68, 186, 115, 144, 121, 680460, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (463, 67, 478, 195, 69, 187, 116, 146, 122, 732280, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (464, 68, 479, 197, 69, 189, 117, 147, 123, 787850, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (465, 69, 480, 199, 70, 191, 118, 148, 124, 847430, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (466, 70, 481, 201, 71, 193, 120, 150, 125, 911290, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (467, 71, 482, 202, 71, 195, 122, 151, 126, 979730, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (468, 72, 483, 204, 73, 196, 123, 152, 127, 1053070, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (469, 73, 484, 206, 73, 198, 124, 154, 128, 1131650, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (470, 74, 485, 207, 74, 200, 125, 155, 129, 1215830, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (471, 75, 486, 209, 75, 201, 127, 156, 130, 1305990, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (472, 76, 486, 210, 75, 203, 128, 157, 131, 1402550, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (473, 77, 487, 212, 76, 204, 129, 158, 132, 1505940, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (474, 78, 488, 213, 76, 206, 131, 159, 133, 1616630, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (475, 79, 489, 215, 77, 207, 131, 160, 134, 1735120, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (476, 80, 489, 216, 78, 209, 133, 161, 135, 1876490, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (477, 81, 490, 217, 78, 210, 134, 162, 136, 2008370, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (478, 82, 491, 219, 79, 212, 135, 163, 137, 2149120, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (479, 83, 491, 220, 80, 213, 136, 164, 137, 2299330, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (480, 84, 492, 221, 80, 214, 137, 165, 138, 2459610, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (481, 85, 492, 222, 81, 215, 139, 166, 139, 2630620, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (482, 86, 493, 223, 82, 217, 140, 167, 139, 2813050, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (483, 87, 493, 224, 82, 218, 141, 168, 140, 3007640, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (484, 88, 494, 225, 82, 219, 142, 168, 141, 3215180, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (485, 89, 494, 227, 83, 220, 142, 169, 141, 3436490, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (486, 90, 495, 228, 84, 222, 144, 170, 142, 3672470, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (487, 91, 495, 228, 84, 223, 145, 171, 143, 3924070, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (488, 92, 496, 229, 85, 223, 146, 171, 143, 4192270, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (489, 93, 496, 230, 85, 224, 147, 172, 144, 4478160, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (490, 94, 497, 231, 86, 226, 147, 173, 144, 4782850, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (491, 95, 497, 232, 87, 227, 149, 173, 145, 5107550, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (492, 96, 498, 233, 87, 227, 150, 174, 145, 5453550, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (493, 97, 498, 234, 88, 228, 151, 175, 146, 5822190, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (494, 98, 499, 234, 88, 230, 152, 175, 146, 6214910, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (495, 99, 500, 235, 89, 230, 152, 176, 147, 6736730, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (496, 1, 300, 16, 4, 14, 7, 12, 10, 0, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (497, 2, 303, 18, 5, 16, 8, 13, 11, 850, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (498, 3, 306, 19, 6, 18, 9, 14, 12, 1060, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (499, 4, 310, 21, 7, 19, 10, 16, 13, 1490, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (500, 5, 313, 23, 8, 21, 11, 17, 14, 1940, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (501, 6, 317, 25, 8, 23, 12, 19, 16, 2400, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (502, 7, 320, 27, 9, 25, 13, 20, 17, 2870, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (503, 8, 324, 29, 10, 27, 15, 22, 18, 3350, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (504, 9, 327, 31, 11, 29, 16, 24, 19, 3850, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (505, 10, 331, 33, 11, 31, 17, 25, 20, 4370, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (506, 11, 335, 35, 12, 33, 18, 27, 22, 4900, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (507, 12, 338, 37, 13, 35, 19, 29, 23, 5450, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (508, 13, 342, 40, 13, 37, 21, 31, 24, 6010, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (509, 14, 346, 42, 14, 40, 22, 33, 26, 6590, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (510, 15, 349, 44, 15, 42, 24, 35, 27, 7190, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (511, 16, 353, 47, 16, 45, 26, 37, 29, 7810, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (512, 17, 357, 50, 17, 47, 27, 39, 31, 8440, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (513, 18, 361, 53, 18, 51, 29, 41, 33, 9340, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (514, 19, 364, 56, 19, 54, 31, 43, 35, 10510, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (515, 20, 368, 59, 20, 56, 33, 45, 37, 11800, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (516, 21, 372, 62, 21, 59, 35, 47, 39, 13200, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (517, 22, 375, 65, 23, 63, 37, 49, 41, 14740, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (518, 23, 379, 69, 24, 66, 39, 51, 43, 16420, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (519, 24, 382, 72, 25, 68, 41, 53, 45, 18260, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (520, 25, 386, 75, 27, 71, 43, 56, 47, 20270, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (521, 26, 389, 78, 27, 75, 45, 58, 49, 22460, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (522, 27, 393, 82, 28, 78, 46, 61, 51, 24850, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (523, 28, 396, 85, 29, 81, 49, 63, 53, 27450, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (524, 29, 399, 88, 31, 84, 50, 66, 55, 30280, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (525, 30, 402, 92, 32, 88, 52, 68, 57, 33370, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (526, 31, 406, 95, 33, 91, 54, 71, 59, 36720, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (527, 32, 409, 99, 34, 94, 55, 73, 62, 40370, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (528, 33, 412, 102, 35, 97, 57, 76, 64, 44340, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (529, 34, 415, 105, 36, 101, 58, 78, 66, 48650, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (530, 35, 418, 109, 38, 104, 60, 81, 68, 53320, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (531, 36, 420, 112, 39, 107, 62, 83, 70, 62950, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (532, 37, 423, 115, 40, 110, 64, 86, 72, 68280, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (533, 38, 426, 119, 40, 113, 66, 88, 74, 74000, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (534, 39, 429, 122, 42, 116, 68, 91, 76, 80140, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (535, 40, 431, 125, 43, 119, 70, 93, 78, 86740, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (536, 41, 434, 128, 44, 122, 72, 95, 80, 93810, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (537, 42, 436, 131, 46, 126, 74, 98, 82, 101390, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (538, 43, 439, 135, 46, 128, 76, 100, 84, 109520, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (539, 44, 441, 138, 47, 131, 78, 102, 86, 118230, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (540, 45, 443, 141, 49, 134, 80, 105, 88, 127570, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (541, 46, 445, 144, 50, 137, 82, 107, 90, 137570, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (542, 47, 447, 147, 50, 140, 83, 109, 92, 148280, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (543, 48, 449, 150, 51, 142, 85, 111, 93, 159740, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (544, 49, 451, 152, 53, 145, 86, 114, 95, 172020, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (545, 50, 453, 155, 54, 148, 88, 116, 97, 190020, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (546, 51, 455, 158, 54, 151, 90, 118, 99, 205480, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (547, 52, 457, 161, 56, 153, 92, 120, 100, 222110, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (548, 53, 459, 163, 57, 156, 94, 122, 102, 239990, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (549, 54, 461, 166, 57, 159, 95, 124, 104, 259200, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (550, 55, 462, 168, 59, 161, 97, 126, 105, 279840, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (551, 56, 464, 171, 59, 163, 99, 127, 107, 302020, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (552, 57, 465, 173, 60, 165, 100, 129, 108, 325850, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (553, 58, 467, 176, 61, 168, 102, 131, 110, 351430, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (554, 59, 468, 178, 62, 171, 103, 133, 111, 378890, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (555, 60, 470, 180, 63, 173, 105, 135, 113, 408380, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (556, 61, 471, 183, 63, 174, 107, 136, 114, 440020, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (557, 62, 472, 185, 65, 177, 108, 138, 115, 473970, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (558, 63, 474, 187, 66, 179, 110, 140, 117, 510380, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (559, 64, 475, 189, 66, 181, 111, 141, 118, 549450, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (560, 65, 476, 191, 68, 183, 113, 143, 119, 591340, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (561, 66, 477, 193, 68, 186, 115, 144, 121, 680460, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (562, 67, 478, 195, 69, 187, 116, 146, 122, 732280, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (563, 68, 479, 197, 69, 189, 117, 147, 123, 787850, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (564, 69, 480, 199, 70, 191, 118, 148, 124, 847430, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (565, 70, 481, 201, 71, 193, 120, 150, 125, 911290, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (566, 71, 482, 202, 71, 195, 122, 151, 126, 979730, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (567, 72, 483, 204, 73, 196, 123, 152, 127, 1053070, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (568, 73, 484, 206, 73, 198, 124, 154, 128, 1131650, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (569, 74, 485, 207, 74, 200, 125, 155, 129, 1215830, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (570, 75, 486, 209, 75, 201, 127, 156, 130, 1305990, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (571, 76, 486, 210, 75, 203, 128, 157, 131, 1402550, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (572, 77, 487, 212, 76, 204, 129, 158, 132, 1505940, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (573, 78, 488, 213, 76, 206, 131, 159, 133, 1616630, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (574, 79, 489, 215, 77, 207, 131, 160, 134, 1735120, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (575, 80, 489, 216, 78, 209, 133, 161, 135, 1876490, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (576, 81, 490, 217, 78, 210, 134, 162, 136, 2008370, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (577, 82, 491, 219, 79, 212, 135, 163, 137, 2149120, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (578, 83, 491, 220, 80, 213, 136, 164, 137, 2299330, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (579, 84, 492, 221, 80, 214, 137, 165, 138, 2459610, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (580, 85, 492, 222, 81, 215, 139, 166, 139, 2630620, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (581, 86, 493, 223, 82, 217, 140, 167, 139, 2813050, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (582, 87, 493, 224, 82, 218, 141, 168, 140, 3007640, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (583, 88, 494, 225, 82, 219, 142, 168, 141, 3215180, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (584, 89, 494, 227, 83, 220, 142, 169, 141, 3436490, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (585, 90, 495, 228, 84, 222, 144, 170, 142, 3672470, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (586, 91, 495, 228, 84, 223, 145, 171, 143, 3924070, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (587, 92, 496, 229, 85, 223, 146, 171, 143, 4192270, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (588, 93, 496, 230, 85, 224, 147, 172, 144, 4478160, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (589, 94, 497, 231, 86, 226, 147, 173, 144, 4782850, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (590, 95, 497, 232, 87, 227, 149, 173, 145, 5107550, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (591, 96, 498, 233, 87, 227, 150, 174, 145, 5453550, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (592, 97, 498, 234, 88, 228, 151, 175, 146, 5822190, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (593, 98, 499, 234, 88, 230, 152, 175, 146, 6214910, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (594, 99, 500, 235, 89, 230, 152, 176, 147, 6736730, 6);

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

COMMIT;

