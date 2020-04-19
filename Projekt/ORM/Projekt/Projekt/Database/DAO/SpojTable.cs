using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class SpojTable
	{
        public static string TABLE_NAME = "Spoj";

        public static string SQL_SELECT_ALL = "SELECT * FROM Spoj";
        public static string SQL_SELECT_ID = "SELECT * FROM Spoj WHERE spoj_id=@id";
        public static string SQL_SELECT_BY_STANICE = "SELECT * FROM Spoj s JOIN Prijezd p ON s.spoj_id = p.spoj_id WHERE p.stanice_id=@id";
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

        // 4.4. Seznam spojů.
        public static Collection<Spoj> SelectSeznam(int stanice_id, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_SELECT_BY_STANICE);
            command.Parameters.AddWithValue("@id", stanice_id);
            SqlDataReader reader = db.Select(command);

            Collection<Spoj> spoje = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return spoje;
        }

        // 4.5. Detail spoje.
        public static Spoj SelectDetail(int id, Database pDb = null)
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

        // Select all records.
        public static Collection<Spoj> SelectAll(Database pDb = null)
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

            Collection<Spoj> spoje = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return spoje;
        }

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
