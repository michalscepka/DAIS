using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class SpojTable
	{
        public static string TABLE_NAME = "Spoj";

        public static string SQL_SELECT = "SELECT * FROM Spoj";
        public static string SQL_SELECT_ID = "";
        public static string SQL_SELECT_NAME = "";
        public static string SQL_INSERT = "INSERT INTO Spoj VALUES (@nazev, @cena_za_km, @kapacita_mist, @pravidelny, @spolecnost_id, @aktivni)";
        public static string SQL_DELETE_ID = "UPDATE Spoj SET aktivni = 0 WHERE spoj_id = @id";
        public static string SQL_UPDATE = "UPDATE Spoj SET nazev=@nazev, cena_za_km=@cena_za_km, kapacita_mist=@kapacita_mist, pravidelny=@pravidelny, " +
            "spolecnost_id=@spolecnost_id, aktivni=@aktivni WHERE spoj_id=@id";

        /// <summary>
        /// 4.1. Vytvoření nového spoje.
        /// </summary>
        public static int Insert(Spoj spoj, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_INSERT);
            PrepareCommand(command, spoj);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        /// <summary>
        /// 4.2. Aktualizování spoje.
        /// </summary>
        public static int Update(Spoj spoj, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_UPDATE);
            PrepareCommand(command, spoj);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        /// <summary>
        /// 4.3. Zrušení spoje.
        /// </summary>
        /// <param name="spoj_id">uzivatel id</param>
        /// <returns></returns>
        public static int Delete(int spoj_id, Database pDb = null)
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
            SqlCommand command = db.CreateCommand(SQL_DELETE_ID);

            command.Parameters.AddWithValue("@id", spoj_id);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        /// <summary>
        /// 4.4. Seznam spojů.
        /// </summary>
        public static Collection<Spoj> Select(string input, Database pDb = null)    // TODO
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

            Collection<Spoj> spoje = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return spoje;
        }

        /// <summary>
        /// 4.5. Detail spoje.
        /// </summary>
        /// <param name="id">spoj id</param>
        public static Spoj Select(int id, Database pDb = null)  // TODO
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

            Collection<Spoj> spoje = Read(reader);
            Spoj spoj = null;
            if (spoje.Count == 1)
            {
                spoj = spoje[0];
            }
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return spoj;
        }

        /// <summary>
        /// Select all records.
        /// </summary>
        public static Collection<Spoj> Select(Database pDb = null)
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

            Collection<Spoj> spoje = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return spoje;
        }

        /// <summary>
        ///  Prepare a command.
        /// </summary>
        private static void PrepareCommand(SqlCommand command, Spoj spoj)
        {
            command.Parameters.AddWithValue("@id", spoj.Id);
            command.Parameters.AddWithValue("@nazev", spoj.Nazev);
            command.Parameters.AddWithValue("@cena_za_km", spoj.CenaZaKm);
            command.Parameters.AddWithValue("@kapacita_mist", spoj.KapacitaMist);
            command.Parameters.AddWithValue("@pravidelny", spoj.Pravidelny);
            command.Parameters.AddWithValue("@spolecnost_id", spoj.SpolecnostId);
            command.Parameters.AddWithValue("@aktivni", spoj.Aktivni);
        }

        private static Collection<Spoj> Read(SqlDataReader reader)
        {
            Collection<Spoj> spoje = new Collection<Spoj>();

            while (reader.Read())
            {
                int i = -1;
                Spoj spoj = new Spoj
                {
                    Id = reader.GetInt32(++i),
                    Nazev = reader.GetString(++i),
                    CenaZaKm = reader.GetInt32(++i),
                    KapacitaMist = reader.GetInt32(++i),
                    Pravidelny = reader.GetBoolean(++i),
                    SpolecnostId = reader.GetInt32(++i),
                    Aktivni = reader.GetBoolean(++i)
                };

                spoje.Add(spoj);
            }
            return spoje;
        }
    }
}
