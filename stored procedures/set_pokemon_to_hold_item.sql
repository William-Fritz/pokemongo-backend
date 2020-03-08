CREATE DEFINER=`admin`@`localhost` PROCEDURE `set_pokemon_hold_item`(i int, n int)
BEGIN

	update pokemons set item_held = n where id = i;
    update inventories set qty = qty-1 where id = n;
END