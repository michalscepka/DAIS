using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class HistorieCenyTable
	{
        public static string TABLE_NAME = "HistorieCeny";

        public static string SQL_SELECT = "SELECT h.history_id, h.cena, h.datum, h.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, " +
            "s.spolecnost_id, s.aktivni, sp.nazev, sp.web, sp.email " +
            "FROM Historie_Ceny h JOIN Spoj s ON h.spoj_id = s.spoj_id JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id";
        public static string SQL_SELECT_ID = "SELECT h.history_id, h.cena, h.datum, h.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, " +
            "s.spolecnost_id, s.aktivni, sp.nazev, sp.web, sp.email " +
            "FROM Historie_Ceny h JOIN Spoj s ON h.spoj_id = s.spoj_id JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id WHERE history_id = @id";
        //public static string SQL_SELECT_BY_NAME = "SELECT * FROM Uzivatel WHERE jmeno LIKE \'%\' + @v_input + \'%\' OR prijmeni LIKE \'%\' + @v_input + \'%\';";

        /// <summary>
        /// Select the records.
        /// </summary>
        public static Collection<HistorieCeny> Select(Database pDb = null)
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

            Collection<HistorieCeny> historie_cen = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return historie_cen;
        }

        /// <summary>
        /// Select the records.
        /// </summary>
        /// <param name="id">user id</param>
        public static HistorieCeny Select(int id, Database pDb = null)
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

            Collection<HistorieCeny> historie_cen = Read(reader);
            HistorieCeny historie_ceny = null;
            if (historie_cen.Count == 1)
            {
                historie_ceny = historie_cen[0];
            }
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return historie_ceny;
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
                    SpojID = reader.GetInt32(++i)
                };
                historie_ceny.Spoj = new Spoj
                {
                    Id = historie_ceny.SpojID,
                    Nazev = reader.GetString(++i),
                    CenaZaKm = reader.GetInt32(++i),
                    KapacitaMist = reader.GetInt32(++i),
                    Pravidelny = reader.GetBoolean(++i),
                    SpolecnostId = reader.GetInt32(++i),
                    Aktivni = reader.GetBoolean(++i)
                };
                historie_ceny.Spoj.Spolecnost = new Spolecnost
                {
                    Id = historie_ceny.Spoj.SpolecnostId,
                    Nazev = reader.GetString(++i),
                    Web = reader.GetString(++i),
                    Email = reader.GetString(++i)
                };

                historie_cen.Add(historie_ceny);
            }
            return historie_cen;
        }
    }
}
