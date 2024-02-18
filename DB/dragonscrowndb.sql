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
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`) VALUES (1, 'Fighter', 'Experts in battle, outfitted with full-plate armor and a sturdy shield. Boasting the stoutest defense of all classes, their shields can protect all allies in the nearby area. Their one-handed weapons have short reach, but they can swing them quickly, allowing them to make short work of nearby foes.', 'https://static.wikia.nocookie.net/dragons-crown/images/a/aa/Walking_animation.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/5/5e/DC_-_Fighter_-_02.png', 'https://atlus.com/dragonscrown/img/character/fighter/fightter_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157823264395346/fighter-portrait.png?ex=65dea054&is=65cc2b54&hm=9017b9edae302163441d1b5f5f855bee9226a0cb1d14e22458e14bb37c1a4d77&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_fighter.jpg', 'https://atlus.com/dragonscrown/img/character/fighter_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/d/d0/FighterT.gif', 'https://atlus.com/dragonscrown/img/character/fighter/fighter_lg.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`) VALUES (2, 'Amazon', 'Dauntless warriors who know no fear as they effortlessly wield their two-handed weapons. Their massive equipment delivers vicious blows that deal lethal damage to multiple foes at once. Lightly armored, they are agile fighters who rely on punishing kicks when unarmed.', 'https://static.wikia.nocookie.net/dragons-crown/images/6/61/Amazon_Sprite_walk.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/c/cb/DC_-_Amazon_-_02.png', 'https://atlus.com/dragonscrown/img/character/amazon/amazon_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157822366818344/amazon-portrait.png?ex=65dea054&is=65cc2b54&hm=7402c1089c13c59871f711d9837ce9cd6ba9f52a63e5f610d3426158d02c2a46&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_amazon.jpg', 'https://atlus.com/dragonscrown/img/character/amazon_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/9/93/AmazonT.gif', 'https://atlus.com/dragonscrown/img/character/amazon/amazon_lg.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`) VALUES (3, 'Elf', 'A long-lived forest race who are often much older than they appear to human eyes. While slight of body, they are deadly masters of the bow and arrow, using their superior athleticism to fight nimbly and fearlessly from a distance.', 'https://static.wikia.nocookie.net/dragons-crown/images/4/4d/Dragon%27s_Crown_Elf_Walk.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/d/d7/DC_-_Elf_-_02.png', 'https://atlus.com/dragonscrown/img/character/elf/elf_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157822995832872/elf-portrait.png?ex=65dea054&is=65cc2b54&hm=9ba3048b2f5671bd705fa8ec1bb29af8fd5af8c32ee67d3a0aa75f6be97ba77c&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_elf.jpg', 'https://atlus.com/dragonscrown/img/character/elf_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/9/91/ElfT2.gif', 'https://atlus.com/dragonscrown/img/character/elf/elf_lg.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`) VALUES (4, 'Dwarf', 'Stocky fighters whose muscular frames permit them to wield a weapon in each hand. Their strength lets them pick up and throw anything in sight, even heavy foes. Throwing enemies lets them damage multiple foes with one fling, laying waste to an entire horde of adversaries.', 'https://static.wikia.nocookie.net/dragons-crown/images/c/cc/DC_-_Dwarf_Sprite.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/a/a4/DC_-_Dwarf_-_02.png', 'https://atlus.com/dragonscrown/img/character/dwarf/dwarf_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157822685577256/dwarf-portrait.png?ex=65dea054&is=65cc2b54&hm=cfc53cda237847ed4382644d181689efb81e9263e67584dc71e20d0b4de9ff81&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_dwarf.jpg', 'https://atlus.com/dragonscrown/img/character/dwarf_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/8/8a/DwarfT.gif', 'https://atlus.com/dragonscrown/img/character/dwarf/dwarf_lg.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`) VALUES (5, 'Sorceress', 'Bewitching women with knowledge of dark magic. They are weak of body, but the great knowledge they wield of the arcane arts cannot be ignored. Sorceresses can create delicious food, control skeletons, and turn foes into harmless frogs. A jack-of-all-trades support class, they can provide aid to their friends in countless ways.', 'https://static.wikia.nocookie.net/dragons-crown/images/8/88/Dragons-crown-sorceress-walking-animation.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/1/1d/Sorceress_lg.png', 'https://atlus.com/dragonscrown/img/character/sorceress/sorceress_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157823558123580/sorceress-portrait.png?ex=65dea055&is=65cc2b55&hm=abe4a99325e573be169a2cf54349416c80d2e1c1ff15647205ee44713ba98841&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_sor.jpg', 'https://atlus.com/dragonscrown/img/character/sorceress_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/6/64/SorceressT.gif', 'https://atlus.com/dragonscrown/img/character/sorceress/sorceress_lg.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`, `title_url`, `portrait_url`, `background_url`, `icon_url`, `streamable_url`, `hq_artwork_url`) VALUES (6, 'Wizard', 'Male magicians who have a wealth of magic at their beck and call. Unable to fend off monsters with strength, they instead rely on their spells, and are vital assets for any adventure.', 'https://static.wikia.nocookie.net/dragons-crown/images/9/97/DC_-_Wizard_Sprite.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/e/e9/DC_-_Wizard_-_02.png', 'https://atlus.com/dragonscrown/img/character/wizard/wizard_title.png', 'https://media.discordapp.net/attachments/1080302897599877181/1207157823864049704/wizard-portrait.png?ex=65dea055&is=65cc2b55&hm=f3f55e077ca77cb8afa09db9d0d095ec92c065ba036fb434584af355e723e4c5&=&format=webp&quality=lossless&width=400&height=180', 'https://www.4gamer.net/img/sp_dragonscrown/bg_dc_character_wiz.jpg', 'https://atlus.com/dragonscrown/img/character/wizard_btn_off_en.png', 'https://static.wikia.nocookie.net/dragons-crown/images/2/27/WizardT.gif', 'https://atlus.com/dragonscrown/img/character/wizard/wizard_lg.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `class_stats`
-- -----------------------------------------------------
START TRANSACTION;
USE `dragonscrowndb`;
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (1, 1, 300, 16, 4, 14, 7, 12, 10, 0, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (2, 2, 303, 18, 5, 16, 8, 13, 11, 850, 1);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (3, 1, 300, 14, 7, 10, 8, 11, 13, 0, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (4, 2, 303, 15, 8, 11, 9, 12, 14, 850, 2);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (5, 1, 300, 11, 8, 7, 8, 13, 15, 0, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (6, 2, 303, 12, 10, 8, 10, 14, 16, 850, 3);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (7, 1, 300, 18, 3, 16, 6, 8, 12, 0, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (8, 2, 303, 20, 3, 18, 7, 9, 13, 850, 4);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (9, 1, 300, 3, 14, 5, 18, 10, 13, 0, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (10, 2, 303, 3, 16, 6, 20, 11, 14, 850, 5);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (11, 1, 300, 6, 18, 8, 13, 12, 6, 0, 6);
INSERT INTO `class_stats` (`id`, `level`, `health`, `strength`, `intelligence`, `constitution`, `magic_resistance`, `dexterity`, `luck`, `required_exp`, `player_class_id`) VALUES (12, 2, 303, 7, 20, 9, 14, 13, 7, 850, 6);

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

