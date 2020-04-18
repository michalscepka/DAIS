using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class JizdenkaTable
	{
        public static string TABLE_NAME = "Jizdenka";

        public static string SQL_SELECT = "SELECT * FROM Jizdenka";
        public static string SQL_SELECT_ID = "";
        public static string SQL_SELECT_USER = "";
        public static string SQL_INSERT = "INSERT INTO Jizdenka VALUES (@uzivatel_id, @cena)";
        public static string SQL_DELETE_ID = "";
        public static string SQL_ZAPSAT_JIZDU = "";

        /// <summary>
        /// 3.1. Vytvoření jízdenky.
        /// </summary>
        public static int Insert(Jizdenka jizdenka, Database pDb = null)
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
            PrepareCommand(command, jizdenka);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        /// <summary>
        /// 3.2. Zapsání jízdy do jízdenky.
        /// </summary>
        /// <param name="uzivatel_id">uzivatel id</param>
        public static int ZapsatJizdu() // TODO Netrivialni
        {
            return 0;
        }

        /// <summary>
        /// 3.3. Zrušení jízdenky.
        /// </summary>
        /// <param name="jizdenka_id">jizdenka id</param>
        /// <returns></returns>
        public static int Delete(int jizdenka_id, Database pDb = null)  // TODO Netrivialni
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

            command.Parameters.AddWithValue("@id", jizdenka_id);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        /// <summary>
        /// 3.4. Seznam jízdenek.
        /// </summary>
        public static Collection<Jizdenka> SelectSeznam(int uzivatel_id, Database pDb = null)   // TODO
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

            SqlCommand command = db.CreateCommand(SQL_SELECT_USER);
            command.Parameters.AddWithValue("@uzivatel_id", uzivatel_id);
            SqlDataReader reader = db.Select(command);

            Collection<Jizdenka> jizdenky = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return jizdenky;
        }

        /// <summary>
        /// 3.5. Detail jízdenky.
        /// </summary>
        /// <param name="id">uzivatel id</param>
        public static Jizdenka Select(int id, Database pDb = null)  // TODO
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

            Collection<Jizdenka> jizdenky = Read(reader);
            Jizdenka jizdenka = null;
            if (jizdenky.Count == 1)
            {
                jizdenka = jizdenky[0];
            }
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return jizdenka;
        }

        /// <summary>
        /// Select all records.
        /// </summary>
        public static Collection<Jizdenka> Select(Database pDb = null)
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

            Collection<Jizdenka> jizdenky = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return jizdenky;
        }

        /// <summary>
        ///  Prepare a command.
        /// </summary>
        private static void PrepareCommand(SqlCommand command, Jizdenka jizdenka)
        {
            command.Parameters.AddWithValue("@id", jizdenka.Id);
            command.Parameters.AddWithValue("@uzivatel_id", jizdenka.UzivatelId);
            command.Parameters.AddWithValue("@cena", jizdenka.Cena);
        }

        private static Collection<Jizdenka> Read(SqlDataReader reader)
        {
            Collection<Jizdenka> jizdenky = new Collection<Jizdenka>();

            while (reader.Read())
            {
                int i = -1;
                Jizdenka jizdenka = new Jizdenka
                {
                    Id = reader.GetInt32(++i),
                    UzivatelId = reader.GetInt32(++i),
                    Cena = reader.GetInt32(++i)
                };

                jizdenky.Add(jizdenka);
            }
            return jizdenky;
        }
    }
}
