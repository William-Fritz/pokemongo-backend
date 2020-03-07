-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pokemon_go
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pokemon_go` ;
USE `pokemon_go` ;

-- -----------------------------------------------------
-- Table `pokemon_go`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`players` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `money` DECIMAL NOT NULL DEFAULT 0,
  `eggs_held` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon_go`.`pokemons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`pokemons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `player_id` INT NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `lvl` INT NOT NULL DEFAULT 1,
  `exp` INT NOT NULL DEFAULT 0,
  `stat` INT NOT NULL DEFAULT 0,
  `type1` INT NOT NULL,
  `type2` INT NULL,
  `move1` INT NOT NULL,
  `move2` INT NULL,
  `item_held` INT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `poke_player_id_idx` (`player_id` ASC),
  CONSTRAINT `poke_player_id`
    FOREIGN KEY (`player_id`)
    REFERENCES `pokemon_go`.`players` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon_go`.`eggs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`eggs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `player_id` INT NOT NULL,
  `type` INT NOT NULL,
  `distance_traveled` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `eggs_player_id_idx` (`player_id` ASC),
  CONSTRAINT `eggs_player_id`
    FOREIGN KEY (`player_id`)
    REFERENCES `pokemon_go`.`players` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon_go`.`inventories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`inventories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `player_id` INT NOT NULL,
  `item_name` VARCHAR(25) NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `inventory_player_id_idx` (`player_id` ASC),
  CONSTRAINT `inven_player_id`
    FOREIGN KEY (`player_id`)
    REFERENCES `pokemon_go`.`players` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon_go`.`items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`items` (
  `item_no` INT NOT NULL,
  `item_name` VARCHAR(25) NULL,
  `buy_price` INT NOT NULL,
  `sell_price` INT NOT NULL,
  PRIMARY KEY (`item_no`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
