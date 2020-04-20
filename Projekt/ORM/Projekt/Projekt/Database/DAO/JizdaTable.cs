using System;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
    public class JizdaTable
    {
        public static string TABLE_NAME = "Jizda";

        public static string SQL_SELECT_ALL = "SELECT * FROM Jizda";
        public static string SQL_SELECT_ID = "SELECT * FROM Jizda WHERE jizda_id=@id";
        public static string SQL_FILTER_BY_ARIBUTES = "EXEC NajitJizdu @start_stanice_id, @cil_stanice_id, @datum, @cas_od";
        public static string SQL_INSERT = "INSERT INTO Jizda VALUES (@datum_start, @datum_cil, @spoj_id)";
        public static string SQL_DELETE_ID = "DELETE FROM Jizda WHERE jizda_id=@id";
        public static string SQL_UPDATE = "EXEC AktualizovatJizdu @id, @novy_datum_start, @novy_datum_cil, @novy_spoj_id";
        public static string SQL_SPOCITEJ_CENU = "SELECT dbo.SpocitejCenuJizdy(@jizda_id, @stanice_id_start, @stanice_id_cil) AS cena";

        // 2.1. Vytvoření nové jízdy.
        public static int Insert(Jizda jizda, Database pDb = null)
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
            PrepareCommand(command, jizda);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        // 2.2. Aktualizování jízdy.
        public static int Update(Jizda jizda, Database pDb = null)
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
            command.Parameters.AddWithValue("@id", jizda.Id);
            command.Parameters.AddWithValue("@novy_datum_start", jizda.DatumStart);
            command.Parameters.AddWithValue("@novy_datum_cil", jizda.DatumCil);
            command.Parameters.AddWithValue("@novy_spoj_id", jizda.SpojId);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        // 2.3. Zrušení jízdy.
        public static int Delete(int jizda_id, Database pDb = null)
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

            command.Parameters.AddWithValue("@id", jizda_id);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        // 2.4. Vyhledání jízdy.
        public static Collection<int?[]> NajitJizdu(int start_stanice_id, int cil_stanice_id, DateTime datum, DateTime cas_od, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_FILTER_BY_ARIBUTES);
            command.Parameters.AddWithValue("@start_stanice_id", start_stanice_id);
            command.Parameters.AddWithValue("@cil_stanice_id", cil_stanice_id);
            command.Parameters.AddWithValue("@datum", datum);
            command.Parameters.AddWithValue("@cas_od", cas_od);
            SqlDataReader reader = db.Select(command);

            Collection<int?[]> data = new Collection<int?[]>();

            while (reader.Read())
            {
                int i = -1;
                int?[] jizdy = new int?[3];
                jizdy[++i] = reader.GetInt32(i);
                if (!reader.IsDBNull(++i))
                {
                    jizdy[i] = reader.GetInt32(i);
                    jizdy[++i] = reader.GetInt32(i);
                }
                else
                {
                    jizdy[i] = null;
                    jizdy[++i] = null;
                }

                data.Add(jizdy);
            }
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return data;
        }

        // 2.5. Detail jízdy.
        public static Jizda SelectDetail(int id, Database pDb = null)
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

            Collection<Jizda> jizdy = Read(reader);
            Jizda jizda = null;
            if (jizdy.Count == 1)
            {
                jizda = jizdy[0];
            }
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return jizda;
        }

        // 2.6. Vypočítání ceny jízdy.
        public static int VypocitatCenuJizdy(int jizda_id, int stanice_id_start, int stanice_id_cil, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_SPOCITEJ_CENU);
            command.Parameters.AddWithValue("@jizda_id", jizda_id);
            command.Parameters.AddWithValue("@stanice_id_start", stanice_id_start);
            command.Parameters.AddWithValue("@stanice_id_cil", stanice_id_cil);
            SqlDataReader reader = db.Select(command);

            reader.Read();
            int ret = reader.GetInt32(0);
            reader.Close();
            return ret;
        }

        // Select all records.
        public static Collection<Jizda> SelectAll(Database pDb = null)
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

            Collection<Jizda> jizdy = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return jizdy;
        }

        private static void PrepareCommand(SqlCommand command, Jizda jizda)
        {
            command.Parameters.AddWithValue("@id", jizda.Id);
            command.Parameters.AddWithValue("@datum_start", jizda.DatumStart);
            command.Parameters.AddWithValue("@datum_cil", jizda.DatumCil);
            command.Parameters.AddWithValue("@spoj_id", jizda.SpojId);
        }

        private static Collection<Jizda> Read(SqlDataReader reader)
        {
            Collection<Jizda> jizdy = new Collection<Jizda>();

            while (reader.Read())
            {
                int i = -1;
                Jizda jizda = new Jizda
                {
                    Id = reader.GetInt32(++i),
                    DatumStart = reader.GetDateTime(++i),
                    DatumCil = reader.GetDateTime(++i),
                    SpojId = reader.GetInt32(++i)
                };

                jizdy.Add(jizda);
            }
            return jizdy;
        }
    }
}
