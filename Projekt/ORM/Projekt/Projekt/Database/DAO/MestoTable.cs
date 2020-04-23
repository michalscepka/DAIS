using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class MestoTable
	{
        public static string TABLE_NAME = "Mesto";

        public static string SQL_SELECT_BY_NAME = "SELECT mesto_id, nazev, kraj FROM Mesto WHERE nazev LIKE \'%\' + @input + \'%\'";
        public static string SQL_SELECT_ID = "SELECT mesto_id, nazev, kraj FROM Mesto WHERE mesto_id = @id";

        // 7.1. Seznam měst.
        public static Collection<Mesto> SelectSeznam(string input, Database pDb = null)
        {
            Database db;
            if (pDb == null)
            {
                db = new Database();
                db.Connect();
            }
            else
            {
                db = pDb;
            }

            SqlCommand command = db.CreateCommand(SQL_SELECT_BY_NAME);
            command.Parameters.AddWithValue("@input", input);
            SqlDataReader reader = db.Select(command);

            Collection<Mesto> mesta = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return mesta;
        }

        // 7.2. Detail města.
        public static Mesto SelectDetail(int id, Database pDb = null)
        {
            Database db;
            if (pDb == null)
            {
                db = new Database();
                db.Connect();
            }
            else
            {
                db = pDb;
            }

            SqlCommand command = db.CreateCommand(SQL_SELECT_ID);
            command.Parameters.AddWithValue("@id", id);
            SqlDataReader reader = db.Select(command);

            Collection<Mesto> users = Read(reader);
            Mesto user = null;
            if (users.Count == 1)
            {
                user = users[0];
            }
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }
            
            return user;
        }

        private static Collection<Mesto> Read(SqlDataReader reader)
        {
            Collection<Mesto> mesta = new Collection<Mesto>();

            while (reader.Read())
            {
                int i = -1;
                Mesto mesto = new Mesto
                {
                    Id = reader.GetInt32(++i),
                    Nazev = reader.GetString(++i),
                    Kraj = reader.GetString(++i)
                };

                mesta.Add(mesto);
            }
            return mesta;
        }
    }
}
