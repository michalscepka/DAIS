using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class PrijezdTable
	{
        public static string TABLE_NAME = "Prijezd";

        public static string SQL_SELECT = "SELECT stanice_id, spoj_id, CAST(cas AS DATETIME), poradi, vzdalenost FROM Prijezd";
        public static string SQL_SELECT_ID = "SELECT p.stanice_id, p.spoj_id, CAST(p.cas AS DATETIME), p.poradi, p.vzdalenost, st.nazev, s.nazev " +
            "FROM Prijezd p JOIN Stanice st ON p.stanice_id = st.stanice_id JOIN Spoj s ON p.spoj_id = s.spoj_id WHERE p.stanice_id=@stanice_id AND p.spoj_id=@spoj_id";
        public static string SQL_SELECT_BY_ARIBUTES = "EXEC SeznamPrijezdu @stanice, @spoj, @cas, @datum";
        public static string SQL_INSERT = "INSERT INTO Prijezd(stanice_id, spoj_id, cas, poradi, vzdalenost) " +
            "VALUES(@stanice_id, @spoj_id, @cas, @poradi, @vzdalenost)";
        public static string SQL_DELETE_ID = "DELETE FROM Prijezd WHERE stanice_id=@stanice_id AND spoj_id=@spoj_id";
        public static string SQL_UPDATE = "UPDATE Prijezd SET cas=@cas, poradi=@poradi, vzdalenost=@vzdalenost WHERE stanice_id=@stanice_id AND spoj_id=@spoj_id";

        /// <summary>
        /// 5.1. Vytvoření nového příjezdu.
        /// </summary>
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

        /// <summary>
        /// 5.2. Aktualizování příjezdu.
        /// </summary>
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

        /// <summary>
        /// 5.3. Zrušení příjezdu.
        /// </summary>
        /// <param name="stanice_id">stanice id</param>
        /// <param name="spoj_id">spoj id</param>
        /// <returns></returns>
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

        /// <summary>
        /// 5.4. Seznam příjezdů.
        /// </summary>
        public static Collection<Prijezd> Select(string stanice, string spoj, DateTime cas, DateTime datum, Database pDb = null)
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

            Collection<Prijezd> prijezdy = Read(reader, true);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return prijezdy;
        }

        /// <summary>
        /// 5.5. Detail příjezdu.
        /// </summary>
        /// <param name="stanice_id">stanice id</param>
        /// <param name="spoj_id">spoj id</param>
        public static Prijezd Select(int stanice_id, int spoj_id, Database pDb = null)
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

            Collection<Prijezd> prijezdy = Read(reader, false);
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

        /// <summary>
        /// Select all records.
        /// </summary>
        public static Collection<Prijezd> Select(Database pDb = null)
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

            Collection<Prijezd> prijezdy = Read(reader, false);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return prijezdy;
        }

        /// <summary>
        ///  Prepare a command.
        /// </summary>
        private static void PrepareCommand(SqlCommand command, Prijezd prijezd)
        {
            command.Parameters.AddWithValue("@stanice_id", prijezd.StaniceId);
            command.Parameters.AddWithValue("@spoj_id", prijezd.SpojId);
            command.Parameters.AddWithValue("@cas", prijezd.Cas);
            command.Parameters.AddWithValue("@poradi", prijezd.Poradi);
            command.Parameters.AddWithValue("@vzdalenost", prijezd.Vzdalenost);
        }

        /// <summary>
        /// Read
        /// </summary>
        /// <param name="complete">true - all attribute values must be read</param>
        private static Collection<Prijezd> Read(SqlDataReader reader, bool complete)
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

                if (complete)
                {
                    prijezd.Stanice = new Stanice { Nazev = reader.GetString(++i) };
                    prijezd.Spoj = new Spoj { Nazev = reader.GetString(++i) };

                    Jizda jizda = new Jizda
                    {
                        DatumStart = reader.GetDateTime(++i),
                        DatumCil = reader.GetDateTime(++i)
                    };
                    prijezd.Spoj.Jizdy.Add(jizda);
                }

                prijezdy.Add(prijezd);
            }
            return prijezdy;
        }
    }
}
