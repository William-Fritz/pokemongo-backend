using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace PokemonGo.Models
{
    public class PlayerQuery
    {
        public AppDb Db { get; set; }

        public PlayerQuery(AppDb db)
        {
            Db = db;
        }

        public async Task UpdateName(int id, string name)
        {
            using var cmd = Db.Connection.CreateCommand();
            cmd.CommandText = @"CALL update_players_name(@id, @name);";
            cmd.Parameters.Add(new MySqlParameter
            {
                ParameterName = "@id",
                DbType = DbType.Int32,
                Value = id,
            });
            cmd.Parameters.Add(new MySqlParameter
            {
                ParameterName = "@name",
                DbType = DbType.String,
                Value = name,
            });
            await cmd.ExecuteNonQueryAsync();
        }

        public async Task<Player> GetPlayerInfo(int id)
        {
            using var cmd = Db.Connection.CreateCommand();
            cmd.CommandText = @"CALL get_player_info(@id)";
            cmd.Parameters.Add(new MySqlParameter
            {
                ParameterName = "@id",
                DbType = DbType.Int32,
                Value = id,
            });
            var reader = await cmd.ExecuteReaderAsync();
            var result = new Player();
            using (reader)
            {
                await reader.ReadAsync();
                result.Name = reader.GetString(0);
                result.PokemonCount = reader.GetInt32(1);
                result.UniquePokemonCount = reader.GetInt32(2);
            }
            return result;
        }
       
    }
}