using System.Data;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace PokemonGo.Models
{
    public class Player
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Money { get; set; }
        public int EggsHeld { get; set; }
        public int PokemonCount { get; set; }
        public int UniquePokemonCount { get; set; }

        internal AppDb Db { get; set; }


        public Player()
        {
        }

        internal Player(AppDb db)
        {
            Db = db;
        }

        public async Task InsertAsync()
        {
            using var cmd = Db.Connection.CreateCommand();
            cmd.CommandText = @"INSERT INTO `players` (`name`, `money`) VALUES (@name, @money);";
            BindParams(cmd);
            await cmd.ExecuteNonQueryAsync();
            Id = (int) cmd.LastInsertedId;
        }
        private void BindId(MySqlCommand cmd)
        {
            cmd.Parameters.Add(new MySqlParameter
            {
                ParameterName = "@id",
                DbType = DbType.Int32,
                Value = Id,
            });
        }

        private void BindParams(MySqlCommand cmd)
        {
            cmd.Parameters.Add(new MySqlParameter
            {
                ParameterName = "@name",
                DbType = DbType.String,
                Value = Name,
            });
            cmd.Parameters.Add(new MySqlParameter
            {
                ParameterName = "@money",
                DbType = DbType.Int32,
                Value = Money,
            });
            cmd.Parameters.Add(new MySqlParameter
            {
                ParameterName = "@eggs_held",
                DbType = DbType.Int32,
                Value = EggsHeld,
            });
        }
    }

}