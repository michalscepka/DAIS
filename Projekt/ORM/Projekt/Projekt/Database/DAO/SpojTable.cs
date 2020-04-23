using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class SpojTable
	{
        public static string TABLE_NAME = "Spoj";

        public static string SQL_INSERT = "INSERT INTO Spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) " +
            "VALUES (@nazev, @cena_za_km, @kapacita_mist, @pravidelny, @spolecnost_id, @aktivni)";
        public static string SQL_UPDATE = "UPDATE Spoj SET nazev=@nazev, cena_za_km=@cena_za_km, kapacita_mist=@kapacita_mist, pravidelny=@pravidelny, " +
            "spolecnost_id=@spolecnost_id, aktivni=@aktivni WHERE spoj_id=@id";
        public static string SQL_DELETE_ID = "UPDATE Spoj SET aktivni = 0 WHERE spoj_id = @id";
        public static string SQL_SELECT_BY_STANICE = "SELECT s.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.aktivni, s.spolecnost_id, sp.nazev, sp.web, sp.email " +
            "FROM Spoj s JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id JOIN Prijezd p ON s.spoj_id = p.spoj_id WHERE p.stanice_id=@id";
        public static string SQL_SELECT_ID = "SELECT s.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.aktivni, s.spolecnost_id, sp.nazev, sp.web, sp.email " +
            "FROM Spoj s JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id WHERE spoj_id=@id";

        // 4.1. Vytvoření nového spoje.
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

        // 4.2. Aktualizování spoje.
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

        // 4.3. Zrušení spoje.
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
                    Aktivni = reader.GetBoolean(++i),
                    SpolecnostId = reader.GetInt32(++i),
                    Spolecnost = new Spolecnost
                    {
                        Id = reader.GetInt32(i),
                        Nazev = reader.GetString(++i),
                        Web = reader.GetString(++i),
                        Email = reader.GetString(++i)
					}
                };

                spoje.Add(spoj);
            }
            return spoje;
        }
    }
}
