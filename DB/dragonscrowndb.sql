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
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`) VALUES (1, 'Fighter', 'Experts in battle, outfitted with full-plate armor and a sturdy shield. Boasting the stoutest defense of all classes, their shields can protect all allies in the nearby area. Their one-handed weapons have short reach, but they can swing them quickly, allowing them to make short work of nearby foes.', 'https://static.wikia.nocookie.net/dragons-crown/images/a/aa/Walking_animation.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/5/5e/DC_-_Fighter_-_02.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`) VALUES (2, 'Amazon', 'Dauntless warriors who know no fear as they effortlessly wield their two-handed weapons. Their massive equipment delivers vicious blows that deal lethal damage to multiple foes at once. Lightly armored, they are agile fighters who rely on punishing kicks when unarmed.', 'https://static.wikia.nocookie.net/dragons-crown/images/6/61/Amazon_Sprite_walk.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/c/cb/DC_-_Amazon_-_02.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`) VALUES (3, 'Elf', 'A long-lived forest race who are often much older than they appear to human eyes. While slight of body, they are deadly masters of the bow and arrow, using their superior athleticism to fight nimbly and fearlessly from a distance.', 'https://static.wikia.nocookie.net/dragons-crown/images/4/4d/Dragon%27s_Crown_Elf_Walk.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/d/d7/DC_-_Elf_-_02.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`) VALUES (4, 'Dwarf', 'Stocky fighters whose muscular frames permit them to wield a weapon in each hand. Their strength lets them pick up and throw anything in sight, even heavy foes. Throwing enemies lets them damage multiple foes with one fling, laying waste to an entire horde of adversaries.', 'https://static.wikia.nocookie.net/dragons-crown/images/c/cc/DC_-_Dwarf_Sprite.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/a/a4/DC_-_Dwarf_-_02.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`) VALUES (5, 'Sorceress', 'Bewitching women with knowledge of dark magic. They are weak of body, but the great knowledge they wield of the arcane arts cannot be ignored. Sorceresses can create delicious food, control skeletons, and turn foes into harmless frogs. A jack-of-all-trades support class, they can provide aid to their friends in countless ways.', 'https://static.wikia.nocookie.net/dragons-crown/images/8/88/Dragons-crown-sorceress-walking-animation.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/1/1d/Sorceress_lg.png');
INSERT INTO `player_class` (`id`, `name`, `description`, `animation_url`, `artwork_url`) VALUES (6, 'Wizard', 'Male magicians who have a wealth of magic at their beck and call. Unable to fend off monsters with strength, they instead rely on their spells, and are vital assets for any adventure.', 'https://static.wikia.nocookie.net/dragons-crown/images/9/97/DC_-_Wizard_Sprite.gif', 'https://static.wikia.nocookie.net/dragons-crown/images/e/e9/DC_-_Wizard_-_02.png');

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

