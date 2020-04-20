using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class JizdenkaJizdaTable
	{
        public static string TABLE_NAME = "JizdenkaJizda";

        public static string SQL_SELECT_ALL = "SELECT * FROM jizdenka_jizda";
        public static string SQL_SELECT_BY_JIZDENKA_ID = "SELECT * FROM jizdenka_jizda WHERE jizdenka_id=@jizdenka_id";
        public static string SQL_SELECT_ID = "SELECT * FROM jizdenka_jizda WHERE jizdenka_id=@jizdenka_id AND jizda_id=@jizda_id";

        // Seznam jizdenek.
        public static Collection<JizdenkaJizda> SelectSeznam(int jizdenka_id, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_SELECT_BY_JIZDENKA_ID);
            command.Parameters.AddWithValue("@jizdenka_id", jizdenka_id);
            SqlDataReader reader = db.Select(command);

            Collection<JizdenkaJizda> seznam = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return seznam;
        }

        // Detail JizdenkaJizdy.
        public static JizdenkaJizda SelectDetail(int jizdenka_id, int jizda_id, Database pDb = null)
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
            command.Parameters.AddWithValue("@jizdenka_id", jizdenka_id);
            command.Parameters.AddWithValue("@jizda_id", jizda_id);
            SqlDataReader reader = db.Select(command);

            Collection<JizdenkaJizda> seznam = Read(reader);
            JizdenkaJizda item = null;
            if (seznam.Count == 1)
            {
                item = seznam[0];
            }
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return item;
        }

        // Select all records.
        public static Collection<JizdenkaJizda> SelectAll(Database pDb = null)
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

            Collection<JizdenkaJizda> seznam = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return seznam;
        }

        private static Collection<JizdenkaJizda> Read(SqlDataReader reader)
        {
            Collection<JizdenkaJizda> seznam = new Collection<JizdenkaJizda>();

            while (reader.Read())
            {
                int i = -1;
                JizdenkaJizda item = new JizdenkaJizda
                {
                    JizdenkaId = reader.GetInt32(++i),
                    JizdaId = reader.GetInt32(++i),
                    StaniceIdStart = reader.GetInt32(++i),
                    StaniceIdCil = reader.GetInt32(++i),
                    Poradi = reader.GetInt32(++i)
                };

                seznam.Add(item);
            }
            return seznam;
        }
    }
}
