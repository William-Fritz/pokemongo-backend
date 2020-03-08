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
USE `pokemon_go` ;

-- -----------------------------------------------------
-- Placeholder table for view `pokemon_go`.`player_rank_money`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`player_rank_money` (`player_name` INT, `total_money` INT);

-- -----------------------------------------------------
-- Placeholder table for view `pokemon_go`.`player_rank_pokemon_count`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`player_rank_pokemon_count` (`name` INT, `count(pokemons.id)` INT);

-- -----------------------------------------------------
-- Placeholder table for view `pokemon_go`.`player_rank_pokemon_unique_count`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`player_rank_pokemon_unique_count` (`name` INT, `count(pokemons.name)` INT);

-- -----------------------------------------------------
-- Placeholder table for view `pokemon_go`.`player_rank_shop_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`player_rank_shop_transactions` (`name` INT, `count(transactions.id)` INT);

-- -----------------------------------------------------
-- Placeholder table for view `pokemon_go`.`pokemon_ranking_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon_go`.`pokemon_ranking_level` (`pokemon_name` INT, `level` INT, `player_name` INT);

-- -----------------------------------------------------
-- View `pokemon_go`.`player_rank_money`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon_go`.`player_rank_money`;
USE `pokemon_go`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `pokemon_go`.`player_rank_money` AS select `pokemon_go`.`players`.`name` AS `player_name`,`pokemon_go`.`players`.`money` AS `total_money` from `pokemon_go`.`players` order by `pokemon_go`.`players`.`money` desc;

-- -----------------------------------------------------
-- View `pokemon_go`.`player_rank_pokemon_count`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon_go`.`player_rank_pokemon_count`;
USE `pokemon_go`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `pokemon_go`.`player_rank_pokemon_count` AS select `pokemon_go`.`players`.`name` AS `name`,count(`pokemon_go`.`pokemons`.`id`) AS `count(pokemons.id)` from (`pokemon_go`.`players` left join `pokemon_go`.`pokemons` on((`pokemon_go`.`players`.`id` = `pokemon_go`.`pokemons`.`player_id`))) group by `pokemon_go`.`players`.`id` order by count(`pokemon_go`.`pokemons`.`id`) desc;

-- -----------------------------------------------------
-- View `pokemon_go`.`player_rank_pokemon_unique_count`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon_go`.`player_rank_pokemon_unique_count`;
USE `pokemon_go`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `pokemon_go`.`player_rank_pokemon_unique_count` AS select `pokemon_go`.`players`.`name` AS `name`,count(distinct `pokemon_go`.`pokemons`.`name`) AS `count(pokemons.name)` from (`pokemon_go`.`players` left join `pokemon_go`.`pokemons` on((`pokemon_go`.`players`.`id` = `pokemon_go`.`pokemons`.`player_id`))) group by `pokemon_go`.`players`.`id` order by count(distinct `pokemon_go`.`pokemons`.`name`) desc;

-- -----------------------------------------------------
-- View `pokemon_go`.`player_rank_shop_transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon_go`.`player_rank_shop_transactions`;
USE `pokemon_go`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `pokemon_go`.`player_rank_shop_transactions` AS select `pokemon_go`.`players`.`name` AS `name`,count(`pokemon_go`.`transactions`.`id`) AS `count(transactions.id)` from (`pokemon_go`.`players` join `pokemon_go`.`transactions` on((`pokemon_go`.`players`.`id` = `pokemon_go`.`transactions`.`player_id`))) group by `pokemon_go`.`players`.`id` order by count(`pokemon_go`.`transactions`.`id`) desc;

-- -----------------------------------------------------
-- View `pokemon_go`.`pokemon_ranking_level`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon_go`.`pokemon_ranking_level`;
USE `pokemon_go`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `pokemon_go`.`pokemon_ranking_level` AS select `pokemon_go`.`pokemons`.`name` AS `pokemon_name`,`pokemon_go`.`pokemons`.`lvl` AS `level`,`pokemon_go`.`players`.`name` AS `player_name` from (`pokemon_go`.`pokemons` join `pokemon_go`.`players` on((`pokemon_go`.`pokemons`.`player_id` = `pokemon_go`.`players`.`id`))) order by `pokemon_go`.`pokemons`.`lvl` desc;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
