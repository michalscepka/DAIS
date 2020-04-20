using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class HistorieCenyTable
	{
        public static string TABLE_NAME = "HistorieCeny";

        public static string SQL_SELECT_ALL = "SELECT * FROM Historie_ceny";

        /// Select all records.
        public static Collection<HistorieCeny> SelectAll(Database pDb = null)
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

            Collection<HistorieCeny> historie_cen = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return historie_cen;
        }

        private static Collection<HistorieCeny> Read(SqlDataReader reader)
        {
            Collection<HistorieCeny> historie_cen = new Collection<HistorieCeny>();

            while (reader.Read())
            {
                int i = -1;
                HistorieCeny historie_ceny = new HistorieCeny
                {
                    Id = reader.GetInt32(++i),
                    Cena = reader.GetInt32(++i),
                    Datum = reader.GetDateTime(++i),
                    SpojId = reader.GetInt32(++i)
                };

                historie_cen.Add(historie_ceny);
            }
            return historie_cen;
        }
    }
}
