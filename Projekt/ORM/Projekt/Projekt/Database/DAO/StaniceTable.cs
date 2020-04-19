using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class StaniceTable
	{
        public static string TABLE_NAME = "Stanice";

        public static string SQL_SELECT_ALL = "SELECT * FROM Stanice";
        public static string SQL_SELECT_BY_NAME = "SELECT * FROM stanice WHERE nazev LIKE \'%\' + @input + \'%\'";
        public static string SQL_SELECT_ID = "SELECT * FROM stanice WHERE stanice_id = @id";

        // 6.1. Seznam stanic.
        public static Collection<Stanice> SelectSeznam(string input, Database pDb = null)
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

            Collection<Stanice> stanice = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return stanice;
        }

        // 6.2. Detail stanice.
        public static Stanice SelectDetail(int id, Database pDb = null)
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

            Collection<Stanice> stanice_arr = Read(reader);
            Stanice stanice = null;
            if (stanice_arr.Count == 1)
            {
                stanice = stanice_arr[0];
            }
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return stanice;
        }

        // Select all records.
        public static Collection<Stanice> SelectAll(Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_SELECT_ALL);
            SqlDataReader reader = db.Select(command);

            Collection<Stanice> stanice_arr = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return stanice_arr;
        }

        private static Collection<Stanice> Read(SqlDataReader reader)
        {
            Collection<Stanice> stanice_arr = new Collection<Stanice>();

            while (reader.Read())
            {
                int i = -1;
                Stanice stanice = new Stanice
                {
                    Id = reader.GetInt32(++i),
                    Nazev = reader.GetString(++i),
                    MestoId = reader.GetInt32(++i)
                };

                stanice_arr.Add(stanice);
            }
            return stanice_arr;
        }
    }
}
