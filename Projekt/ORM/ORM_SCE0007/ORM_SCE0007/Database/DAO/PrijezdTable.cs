using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class PrijezdTable
	{
        public static string TABLE_NAME = "Prijezd";

        public static string SQL_INSERT = "INSERT INTO Prijezd(stanice_id, spoj_id, cas, poradi, vzdalenost) " +
            "VALUES(@stanice_id, @spoj_id, @cas, @poradi, @vzdalenost)";
        public static string SQL_UPDATE = "UPDATE Prijezd SET cas=@cas, poradi=@poradi, vzdalenost=@vzdalenost WHERE stanice_id=@stanice_id AND spoj_id=@spoj_id";
        public static string SQL_DELETE_ID = "DELETE FROM Prijezd WHERE stanice_id=@stanice_id AND spoj_id=@spoj_id";
        public static string SQL_SELECT_BY_ARIBUTES = "EXEC SeznamPrijezdu @stanice, @spoj, @cas, @datum";
        public static string SQL_SELECT_ID = "SELECT p.stanice_id, p.spoj_id, CAST(p.cas AS DATETIME), p.poradi, p.vzdalenost, st.stanice_id, st.nazev, st.mesto_id, " +
            "m.mesto_id, m.nazev, m.kraj, s.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, sp.spolecnost_id, s.aktivni, sp.spolecnost_id, sp.nazev, " +
            "sp.web, sp.email FROM Prijezd p JOIN Stanice st ON p.stanice_id = st.stanice_id JOIN Mesto m ON st.mesto_id = m.mesto_id JOIN Spoj s ON p.spoj_id = s.spoj_id " +
            "JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id WHERE p.stanice_id=@stanice_id AND p.spoj_id=@spoj_id";

        // 5.1. Vytvoření nového příjezdu.
        public static int Insert(Prijezd prijezd, Database pDb = null)
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
            PrepareCommand(command, prijezd);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        // 5.2. Aktualizování příjezdu.
        public static int Update(Prijezd prijezd, Database pDb = null)
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
            PrepareCommand(command, prijezd);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        // 5.3. Zrušení příjezdu.
        public static int Delete(int stanice_id, int spoj_id, Database pDb = null)
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

            command.Parameters.AddWithValue("@stanice_id", stanice_id);
            command.Parameters.AddWithValue("@spoj_id", spoj_id);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        // 5.4. Seznam příjezdů.
        public static Collection<Prijezd> SelectSeznam(string stanice, string spoj, DateTime cas, DateTime datum, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_SELECT_BY_ARIBUTES);
            command.Parameters.AddWithValue("@stanice", stanice);
            command.Parameters.AddWithValue("@spoj", spoj);
            command.Parameters.AddWithValue("@cas", cas);
            command.Parameters.AddWithValue("@datum", datum);
            SqlDataReader reader = db.Select(command);

            Collection<Prijezd> prijezdy = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return prijezdy;
        }

        // 5.5. Detail příjezdu.
        public static Prijezd SelectDetail(int stanice_id, int spoj_id, Database pDb = null)
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
            command.Parameters.AddWithValue("@stanice_id", stanice_id);
            command.Parameters.AddWithValue("@spoj_id", spoj_id);
            SqlDataReader reader = db.Select(command);

            Collection<Prijezd> prijezdy = Read(reader);
            Prijezd prijezd = null;
            if (prijezdy.Count == 1)
            {
                prijezd = prijezdy[0];
            }
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return prijezd;
        }

        private static void PrepareCommand(SqlCommand command, Prijezd prijezd)
        {
            command.Parameters.AddWithValue("@stanice_id", prijezd.StaniceId);
            command.Parameters.AddWithValue("@spoj_id", prijezd.SpojId);
            command.Parameters.AddWithValue("@cas", prijezd.Cas);
            command.Parameters.AddWithValue("@poradi", prijezd.Poradi);
            command.Parameters.AddWithValue("@vzdalenost", prijezd.Vzdalenost);
        }

        private static Collection<Prijezd> Read(SqlDataReader reader)
        {
            Collection<Prijezd> prijezdy = new Collection<Prijezd>();

            while (reader.Read())
            {
                int i = -1;
                Prijezd prijezd = new Prijezd
                {
                    StaniceId = reader.GetInt32(++i),
                    SpojId = reader.GetInt32(++i),
                    Cas = reader.GetDateTime(++i),
                    Poradi = reader.GetInt32(++i),
                    Vzdalenost = reader.GetInt32(++i)
                };
                prijezd.Stanice = new Stanice
                {
                    Id = reader.GetInt32(++i),
                    Nazev = reader.GetString(++i),
                    MestoId = reader.GetInt32(++i)
                };
                prijezd.Stanice.Mesto = new Mesto
                {
                    Id = reader.GetInt32(++i),
                    Nazev = reader.GetString(++i),
                    Kraj = reader.GetString(++i)
                };
                prijezd.Spoj = new Spoj
                {
                    Id = reader.GetInt32(++i),
                    Nazev = reader.GetString(++i),
                    CenaZaKm = reader.GetInt32(++i),
                    KapacitaMist = reader.GetInt32(++i),
                    Pravidelny = reader.GetBoolean(++i),
                    SpolecnostId = reader.GetInt32(++i),
                    Aktivni = reader.GetBoolean(++i)
                };
                prijezd.Spoj.Spolecnost = new Spolecnost
                {
                    Id = reader.GetInt32(++i),
                    Nazev = reader.GetString(++i),
                    Web = reader.GetString(++i),
                    Email = reader.GetString(++i)
                };

                prijezdy.Add(prijezd);
            }
            return prijezdy;
        }
    }
}
