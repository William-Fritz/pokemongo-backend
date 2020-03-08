using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace PokemonGo.Models
{
    public class PlayerQuery
    {
        public AppDb Db { get; }

        public PlayerQuery(AppDb db)
        {
            Db = db;
        }

        public async Task<Player> FindOneAsync(int id)
        {
            using var cmd = Db.Connection.CreateCommand();
            cmd.CommandText = @"SELECT * FROM players WHERE id = @id";
            cmd.Parameters.Add(new MySqlParameter
            {
                ParameterName = "@id",
                DbType = DbType.Int32,
                Value = id,
            });
            var result = await ReadAllAsync(await cmd.ExecuteReaderAsync());
            return result.Count > 0 ? result[0] : null;
        }

        private async Task<List<Player>> ReadAllAsync(DbDataReader reader)
        {
            var players = new List<Player>();
            using (reader)
            {
                while (await reader.ReadAsync())
                {
                    var post = new Player(Db)
                    {
                        Id = reader.GetInt32(0),
                        Name = reader.GetString(1),
                        Money = reader.GetInt32(2),
                        EggsHeld = reader.GetInt32(3)
                    };
                    players.Add(post);
                }
            }
            return players;
        }
    }
}