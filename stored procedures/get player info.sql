CREATE PROCEDURE `get_player_info` (i int)
BEGIN
	select players.`name`, count(pokemons.id), count(distinct pokemons.`name`) from players join pokemons on players.id = pokemons.player_id where players.id = i;  
END
