-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pokemon_go
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pokemon_go
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pokemon_go` DEFAULT CHARACTER SET latin1 ;
USE `pokemon_go` ;

-- -----------------------------------------------------
-- Table `pokemon_go`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`players` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `money` DECIMAL(10,0) NOT NULL DEFAULT '0',
  `eggs_held` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 46
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pokemon_go`.`eggs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`eggs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `player_id` INT(11) NOT NULL,
  `type` INT(11) NOT NULL,
  `distance_traveled` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `eggs_player_id_idx` (`player_id` ASC) VISIBLE,
  CONSTRAINT `eggs_player_id`
    FOREIGN KEY (`player_id`)
    REFERENCES `pokemon_go`.`players` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 527
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pokemon_go`.`inventories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`inventories` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `player_id` INT(11) NOT NULL,
  `item_id` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  INDEX `inventory_player_id_idx` (`player_id` ASC) VISIBLE,
  CONSTRAINT `inven_player_id`
    FOREIGN KEY (`player_id`)
    REFERENCES `pokemon_go`.`players` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 121
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pokemon_go`.`items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`items` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `buy_price` INT(11) NOT NULL,
  `sell_price` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pokemon_go`.`pokemons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`pokemons` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `player_id` INT(11) NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `lvl` INT(11) NOT NULL DEFAULT '1',
  `exp` INT(11) NOT NULL DEFAULT '0',
  `stat` INT(11) NOT NULL DEFAULT '0',
  `type1` INT(11) NOT NULL,
  `type2` INT(11) NULL DEFAULT NULL,
  `move1` INT(11) NOT NULL,
  `move2` INT(11) NULL DEFAULT NULL,
  `item_held` INT(11) NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `poke_player_id_idx` (`player_id` ASC) VISIBLE,
  CONSTRAINT `poke_player_id`
    FOREIGN KEY (`player_id`)
    REFERENCES `pokemon_go`.`players` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 528
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pokemon_go`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`transactions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `player_id` INT(11) NOT NULL,
  `item_id` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `total_money` INT(11) NOT NULL,
  `type` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `transactions_player_id_idx` (`player_id` ASC) VISIBLE,
  CONSTRAINT `transactions_player_id`
    FOREIGN KEY (`player_id`)
    REFERENCES `pokemon_go`.`players` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 110
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
