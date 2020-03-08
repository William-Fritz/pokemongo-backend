CREATE DEFINER=`admin`@`localhost` PROCEDURE `get_players_current_egg`(i int)
BEGIN
	set @egg_id = (select eggs_held from players where id = i limit 1);
	select * from eggs where id = @egg_id ; 
END