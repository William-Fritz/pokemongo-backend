CREATE DEFINER=`admin`@`localhost` PROCEDURE `get_players_inventories`(i int)
BEGIN
	select * from inventories where player_id = i;
END