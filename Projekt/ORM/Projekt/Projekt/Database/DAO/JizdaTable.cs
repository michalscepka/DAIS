using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
    public class JizdaTable
    {
        public static string TABLE_NAME = "Jizda";

        public static string SQL_SELECT = "SELECT * FROM Jizda";
        public static string SQL_SELECT_ID = "";
        public static string SQL_SELECT_BY_ARIBUTES = "";
        public static string SQL_INSERT = "INSERT INTO Jizda VALUES (@datum_start, @datum_cil, @spoj_id)";
        public static string SQL_DELETE_ID = "DELETE FROM Jizda WHERE jizda_id=@id";
        public static string SQL_UPDATE = "UPDATE Jizda SET datum_start=@datum_start, datum_cil=@datum_cil, spoj_id=@spoj_id WHERE jizda_id=@id";

        /// <summary>
        /// 2.1. Vytvoření nové jízdy.
        /// </summary>
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

        /// <summary>
        /// 2.2. Aktualizování jízdy.
        /// </summary>
        public static int Update(Jizda jizda, Database pDb = null)  // TODO Netrivialni
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
            PrepareCommand(command, jizda);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        /// <summary>
        /// 2.3. Zrušení jízdy.
        /// </summary>
        /// <param name="jizda_id">jizda id</param>
        /// <returns></returns>
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

        /// <summary>
        /// 2.4. Vyhledání jízdy.
        /// </summary>
        public static Collection<Jizda> Select(string input, Database pDb = null)    // TODO Netrivialni
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
            command.Parameters.AddWithValue("@input", input);
            SqlDataReader reader = db.Select(command);

            Collection<Jizda> users = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return users;
        }

        /// <summary>
        /// 2.5. Detail jízdy.
        /// </summary>
        /// <param name="id">jizda id</param>
        public static Jizda Select(int id, Database pDb = null)
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

        /// <summary>
        /// 2.6. Vypočítání ceny jízdy.
        /// </summary>
        /// <param name="id">jizda id</param>
        public static int VypocitatCenuJizdy()  // TODO Netrivialni
        {
            return 0;
        }

        /// <summary>
        /// Select all records.
        /// </summary>
        public static Collection<Jizda> Select(Database pDb = null)
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

            Collection<Jizda> jizdy = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return jizdy;
        }

        /// <summary>
        ///  Prepare a command.
        /// </summary>
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
