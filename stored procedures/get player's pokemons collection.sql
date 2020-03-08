CREATE DEFINER=`admin`@`localhost` PROCEDURE `get_players_pokemon_collections`(i int)
BEGIN
	select * from pokemons join items on pokemons.item_held = items.id where player_id = i;
END