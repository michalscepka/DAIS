using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class MestoTable
	{
        public static string TABLE_NAME = "Mesto";

        public static string SQL_SELECT = "SELECT * FROM Mesto";
        public static string SQL_SELECT_NAME = "SELECT mesto_id, nazev, kraj FROM Mesto WHERE nazev LIKE \'%\' + @input + \'%\'";
        public static string SQL_SELECT_ID = "SELECT mesto_id, nazev, kraj FROM Mesto WHERE mesto_id = @id";

        /// <summary>
        /// 7.1. Seznam měst.
        /// </summary>
        /// <param name="id">user id</param>
        public static Collection<Mesto> Select(string input, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_SELECT_NAME);
            command.Parameters.AddWithValue("@input", input);
            SqlDataReader reader = db.Select(command);

            Collection<Mesto> mesta = Read(reader, true);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return mesta;
        }

        /// <summary>
        /// 7.2. Detail města.
        /// </summary>
        /// <param name="id">user id</param>
        public static Mesto Select(int id, Database pDb = null)
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

            Collection<Mesto> users = Read(reader, true);
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

        /// <summary>
        /// Select all records.
        /// </summary>
        public static Collection<Mesto> Select(Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_SELECT);
            SqlDataReader reader = db.Select(command);

            Collection<Mesto> mesta = Read(reader, false);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return mesta;
        }

        private static Collection<Mesto> Read(SqlDataReader reader, bool complete)
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
