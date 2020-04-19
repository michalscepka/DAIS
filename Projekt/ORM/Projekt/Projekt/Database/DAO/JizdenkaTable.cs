using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class JizdenkaTable
	{
        public static string TABLE_NAME = "Jizdenka";

        public static string SQL_SELECT_ALL = "SELECT * FROM Jizdenka";
        public static string SQL_SELECT_ID = "SELECT * FROM Jizdenka WHERE jizdenka_id=@id";
        public static string SQL_SELECT_BY_USER = "SELECT * FROM Jizdenka WHERE uzivatel_id=@id";
        public static string SQL_INSERT = "INSERT INTO Jizdenka VALUES (@uzivatel_id, @cena)";
        public static string SQL_DELETE_ID = "EXEC ZrusitJizdenku @id";
        public static string SQL_ZAPSAT_JIZDU = "EXEC PridatJizduDoJizdenky @jizdenka_id, @jizda_id, @stanice_id_start, @stanice_id_cil";

        // 3.1. Vytvoření jízdenky.
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

        // 3.2. Zapsání jízdy do jízdenky.
        public static int ZapsatJizdu(int jizdenka_id, int jizda_id, int stanice_id_start, int stanice_id_cil, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_ZAPSAT_JIZDU);

            command.Parameters.AddWithValue("@jizdenka_id", jizdenka_id);
            command.Parameters.AddWithValue("@jizda_id", jizda_id);
            command.Parameters.AddWithValue("@stanice_id_start", stanice_id_start);
            command.Parameters.AddWithValue("@stanice_id_cil", stanice_id_cil);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        // 3.3. Zrušení jízdenky.
        public static int Delete(int jizdenka_id, Database pDb = null)
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

        // 3.4. Seznam jízdenek.
        public static Collection<Jizdenka> SelectSeznam(int uzivatel_id, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_SELECT_BY_USER);
            command.Parameters.AddWithValue("@id", uzivatel_id);
            SqlDataReader reader = db.Select(command);

            Collection<Jizdenka> jizdenky = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return jizdenky;
        }

        // 3.5. Detail jízdenky.
        public static Jizdenka SelectDetail(int id, Database pDb = null)
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

        // Select all records.
        public static Collection<Jizdenka> SelectAll(Database pDb = null)
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

            Collection<Jizdenka> jizdenky = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return jizdenky;
        }

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
