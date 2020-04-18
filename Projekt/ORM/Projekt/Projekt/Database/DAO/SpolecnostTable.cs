using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class SpolecnostTable
	{
        public static string TABLE_NAME = "Spolecnost";

        public static string SQL_SELECT = "SELECT * FROM Spolecnost";
        public static string SQL_SELECT_NAME = "SELECT spolecnost_id, nazev, web, email FROM Spolecnost WHERE nazev LIKE \'%\' + @input + \'%\'";
        public static string SQL_SELECT_ID = "SELECT spolecnost_id, nazev, web, email FROM Spolecnost WHERE spolecnost_id = @id";

        /// <summary>
        /// 8.1. Seznam společností.
        /// </summary>
        /// <param name="id">user id</param>
        public static Collection<Spolecnost> Select(string input, Database pDb = null)
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

            Collection<Spolecnost> spolecnosti = Read(reader, true);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return spolecnosti;
        }

        /// <summary>
        /// 8.2. Detail společnosti.
        /// </summary>
        /// <param name="id">user id</param>
        public static Spolecnost Select(int id, Database pDb = null)
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

            Collection<Spolecnost> spolecnosti = Read(reader, true);
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

        /// <summary>
        /// Select all records.
        /// </summary>
        public static Collection<Spolecnost> Select(Database pDb = null)
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

            Collection<Spolecnost> spolecnosti = Read(reader, false);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return spolecnosti;
        }

        private static Collection<Spolecnost> Read(SqlDataReader reader, bool complete = false)
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
