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
-- procedure buy_item
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `buy_item`(plyr_id int, itm_id int, qty int)
BEGIN
	update inventories 
    set quantity = quantity + qty 
    where player_id = plyr_id 
    and item_id = itm_id;
    
    set @total_spend = (
		select qty * buy_price 
        from items 
        where id = itm_id);
    
    update players 
    set money = money - @total_spend 
    where id = plyr_id;
    
    insert into transactions(
		player_id, item_id, quantity, total_money, `type`)
	values
    (plyr_id, itm_id, qty, @total_spend, 0);
        
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure change_carry_egg
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `change_carry_egg`(plyr_id int, new_egg_id int)
BEGIN
	update players 
    set eggs_held = new_egg_id 
    where id = plyr_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_player_info
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `get_player_info`(plyr_id int)
BEGIN
	select players.`name`,
		count(pokemons.id), 
		count(distinct pokemons.`name`) 
    from players 
    join pokemons 
    on players.id = pokemons.player_id 
    where players.id = plyr_id;  
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_players_current_egg
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `get_players_current_egg`(plyr_id int)
BEGIN
	set @egg_id = (
		select eggs_held 
        from players 
        where id = plyr_id 
        limit 1);
	select * 
    from eggs 
    where id = @egg_id; 
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_players_eggs
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `get_players_eggs`(plyr_id int)
BEGIN
	select * from eggs 
    where player_id = plyr_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_players_inventories
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `get_players_inventories`(plyr_id int)
BEGIN
	select inventories.*, items.`name` item_name 
    from inventories 
    join items 
    on inventories.item_id = items.id 
    where player_id = plyr_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_players_pokemon_collections
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `get_players_pokemon_collections`(plyr_id int)
BEGIN
	select pokemons.*, items.`name` item_name 
    from pokemons 
    left join items 
    on pokemons.item_held = items.id 
    where player_id = plyr_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure populate table
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `populate table`()
BEGIN
	declare i int default 1;
	declare j int default 1;
    declare temp_id int default 0;
    
    delete from players where id > 0;
    delete from pokemons where id > 0;
    delete from eggs where id > 0;
    delete from inventories where id > 0;
    delete from items where id > 0;
    delete from transactions where id > 0;
    while i < 11 do
		INSERT into players(`name`, money) values
		(concat('Kepin ',i), 1000);
        set temp_id = (SELECT id from players where `name` = concat('Kepin ', i) limit 1);
        while j < rand()*11 do
			INSERT into pokemons(player_id, `name`, lvl, `exp`, stat, type1, move1) values 
			(temp_id, 'Pikachu', rand()*99, 0, 0, 4, 3),
            (temp_id, 'Vulpix', rand()*99, 0, 0, 4, 3);
            
            INSERT into eggs(player_id, `type`, distance_traveled) values
            (temp_id, rand()*2, rand()*1500),
            (temp_id, 2+rand()*2, rand()*7000);
            
            INSERT into transactions(player_id, item_id, quantity, total_money, `type`) values
			(temp_id, 2, 5, 500, 0),
            (temp_id, 1, 10, 500, 0);
            
            set j = j + 1;
		
        end while;
		set j = 1;
        set i = i + 1;
		
        INSERT into inventories(player_id, item_id, quantity) values
        (temp_id, 1, rand()*99),
        (temp_id, 2, rand()*99),
        (temp_id, 3, rand()*99);
        
	end while;
    
    INSERT into items(id, `name`, buy_price, sell_price) values
    (1,'Potion', 50, 5),
    (2,'Ether', 100, 10),
    (3,'Poke Balls', 150, 15);
    
    
    
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure release_pokemon
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `release_pokemon`(poke_id int)
BEGIN
	delete from pokemons 
    where id = poke_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure remove_item_from_pokemon
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `remove_item_from_pokemon`(poke_id int, plyr_id int)
BEGIN
	set @temp_item = (
		select item_held 
		from pokemons 
        where id = poke_id);
    
    update inventories 
    set quantity = quantity + 1 
    where player_id = plyr_id 
    and item_id = @temp_item;
    
    update pokemons 
    set item_held = 0 
    where id = poke_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sell_item
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sell_item`(plyr_id int, itm_id int, qty int)
BEGIN
	set @total_money= (
		select qty * sell_price 
        from items 
        where id = itm_id);
	
    update players 
    set money = money + @total_money 
    where id = plyr_id;
	
    update inventories 
    set quantity = quantity - qty 
    where player_id = plyr_id 
    and item_id = itm_id;
    
    insert into transactions(
		player_id, item_id, quantity, total_money, `type`)
	values
		(plyr_id, itm_id, qty, @total_money, 1);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure set_pokemon_hold_item
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `set_pokemon_hold_item`(poke_id int, invnt_id int)
BEGIN
	set @item_id = (
		select item_id 
		from inventories 
        where id = invnt_id);
	update pokemons 
    set item_held = @item_id 
    where id = poke_id;
    
    update inventories 
    set quantity = quantity-1 
    where id = invnt_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_players_name
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `update_players_name`(plyr_id int, new_name varchar(25))
BEGIN
	update players 
    set `name` = new_name 
    where id = plyr_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_pokemon_exp
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `update_pokemon_exp`(poke_id int, exp_add int)
BEGIN
	update pokemons 
    set exp = exp + exp_add 
    where id = poke_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure use_item_to_pokemon
-- -----------------------------------------------------

DELIMITER $$
USE `pokemon_go`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `use_item_to_pokemon`(plyr_id int, poke_id int, invnt_id int)
BEGIN
	set @itm_id = (
		select item_id 
        from inventories 
        where id = invnt_id);
    
    if @itm_id = 2 then 
		-- simulate item use ether will change stat back to normal
		update pokemons 
        set stat = 0 
        where id = poke_id;	
    elseif @itm_id = 1 then
		-- simulate item use potion will increase exp
        -- production code will increase hp instead
		update pokemons 
        set exp = exp + 10 
        where id = poke_id;
	end if;
    
    update inventories 
    set quantity = quantity - 1 
    where id = invnt_id;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
