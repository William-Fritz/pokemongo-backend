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
    while i < 11 do
		INSERT into players(`name`, money) values
		(concat('Kepin ',i), 1000);
        set temp_id = (SELECT id from players where `name` = concat('Kepin ', i) limit 1);
        while j < 11 do
			INSERT into pokemons(player_id, `name`, lvl, `exp`, stat, type1, move1) values 
			(temp_id, 'Pikachu', (concat(5,i)), 0, 0, 4, 3),
            (temp_id, 'Vulpix', (concat(5,i)), 0, 0, 4, 3);
            
            INSERT into eggs(player_id, `type`, distance_traveled) values
            (temp_id, rand()*2, rand()*1500),
            (temp_id, 2+rand()*2, rand()*7000);
            
            set j = j + 1;
		
        end while;
		set j = 1;
        set i = i + 1;
		
        INSERT into inventories(player_id, item_name, quantity) values
        (temp_id, 'Potion', rand()*99),
        (temp_id, 'Ether', rand()*99),
        (temp_id, 'Poke Balls', rand()*99);
        
	end while;
    
    INSERT into items(id, item_name, buy_price, sell_price) values
    (1,'Potion', 50, 5),
    (2,'Ether', 100, 10),
    (3,'Poke Balls', 150, 15);
    
END