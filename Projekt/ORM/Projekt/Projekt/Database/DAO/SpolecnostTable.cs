using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class SpolecnostTable
	{
        public static string TABLE_NAME = "Spolecnost";

        public static string SQL_SELECT_ALL = "SELECT * FROM Spolecnost";
        public static string SQL_SELECT_NAME = "SELECT * FROM Spolecnost WHERE nazev LIKE \'%\' + @input + \'%\'";
        public static string SQL_SELECT_ID = "SELECT * FROM Spolecnost WHERE spolecnost_id = @id";

        // 8.1. Seznam společností.
        public static Collection<Spolecnost> SelectSeznam(string input, Database pDb = null)
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

            Collection<Spolecnost> spolecnosti = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return spolecnosti;
        }

        // 8.2. Detail společnosti.
        public static Spolecnost SelectDetail(int id, Database pDb = null)
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

            Collection<Spolecnost> spolecnosti = Read(reader);
            Spolecnost spolecnost = null;
            if (spolecnosti.Count == 1)
            {
                spolecnost = spolecnosti[0];
            }
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return spolecnost;
        }

        // Select all records.
        public static Collection<Spolecnost> SelectAll(Database pDb = null)
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

            Collection<Spolecnost> spolecnosti = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return spolecnosti;
        }

        private static Collection<Spolecnost> Read(SqlDataReader reader)
        {
            Collection<Spolecnost> spolecnosti = new Collection<Spolecnost>();

            while (reader.Read())
            {
                int i = -1;
                Spolecnost spolecnost = new Spolecnost
                {
                    Id = reader.GetInt32(++i),
                    Nazev = reader.GetString(++i),
                    Web = reader.GetString(++i),
                    Email = reader.GetString(++i)
                };

                spolecnosti.Add(spolecnost);
            }
            return spolecnosti;
        }
    }
}
