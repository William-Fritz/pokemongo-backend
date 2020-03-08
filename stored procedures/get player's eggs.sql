CREATE PROCEDURE `get_players_eggs` (i int)
BEGIN
	select * from eggs where player_id = i;
END
