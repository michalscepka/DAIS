using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class StaniceTable
	{
        public static string TABLE_NAME = "Stanice";

        public static string SQL_SELECT = "SELECT * FROM Stanice";
        public static string SQL_SELECT_NAME = "SELECT s.stanice_id, s.nazev, s.mesto_id, m.nazev, m.kraj " +
            "FROM stanice s JOIN Mesto m ON s.mesto_id = m.mesto_id WHERE s.nazev LIKE \'%\' + @input + \'%\'";
        public static string SQL_SELECT_ID = "SELECT s.stanice_id, s.nazev, s.mesto_id, m.nazev, m.kraj " +
            "FROM stanice s JOIN Mesto m ON s.mesto_id = m.mesto_id WHERE stanice_id = @id";

        /// <summary>
        /// 6.1. Seznam stanic.
        /// </summary>
        /// <param name="id">user id</param>
        public static Collection<Stanice> Select(string input, Database pDb = null)
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

            Collection<Stanice> stanice = Read(reader, true);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return stanice;
        }

        /// <summary>
        /// 6.2. Detail stanice.
        /// </summary>
        /// <param name="id">user id</param>
        public static Stanice Select(int id, Database pDb = null)
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

            Collection<Stanice> stanice_arr = Read(reader, true);
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

        /// <summary>
        /// Select all records.
        /// </summary>
        public static Collection<Stanice> Select(Database pDb = null)
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

            Collection<Stanice> stanice_arr = Read(reader, false);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return stanice_arr;
        }

        private static Collection<Stanice> Read(SqlDataReader reader, bool complete)
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

                if(complete)
                {
                    stanice.Mesto = new Mesto
                    {
                        Id = stanice.MestoId,
                        Nazev = reader.GetString(++i),
                        Kraj = reader.GetString(++i)
                    };
                }

                stanice_arr.Add(stanice);
            }
            return stanice_arr;
        }
    }
}
