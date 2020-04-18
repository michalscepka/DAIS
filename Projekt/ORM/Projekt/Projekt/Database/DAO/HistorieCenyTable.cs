using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class HistorieCenyTable
	{
        public static string TABLE_NAME = "HistorieCeny";

        public static string SQL_SELECT = "SELECT * FROM Historie_ceny";
        public static string SQL_SELECT_NAME = "SELECT h.history_id, h.cena, h.datum, h.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, " +
            "s.spolecnost_id, s.aktivni, sp.nazev, sp.web, sp.email " +
            "FROM Historie_Ceny h JOIN Spoj s ON h.spoj_id = s.spoj_id JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id";
        public static string SQL_SELECT_ID = "SELECT h.history_id, h.cena, h.datum, h.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, " +
            "s.spolecnost_id, s.aktivni, sp.nazev, sp.web, sp.email " +
            "FROM Historie_Ceny h JOIN Spoj s ON h.spoj_id = s.spoj_id JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id WHERE history_id = @id";

        /// <summary>
        /// Seznam historii cen.
        /// </summary>
        /// <param name="id">user id</param>
        public static Collection<HistorieCeny> Select(string input, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_SELECT_NAME);
            command.Parameters.AddWithValue("@input", input);
            SqlDataReader reader = db.Select(command);

            Collection<HistorieCeny> historie_cen = Read(reader, true);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return historie_cen;
        }

        /// <summary>
        /// Detail historie ceny.
        /// </summary>
        /// <param name="id">historie ceny id</param>
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

            Collection<HistorieCeny> historie_cen = Read(reader, true);
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

        /// <summary>
        /// Select all records.
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

            Collection<HistorieCeny> historie_cen = Read(reader, false);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return historie_cen;
        }

        private static Collection<HistorieCeny> Read(SqlDataReader reader, bool complete)
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

                if(complete)
                {
                    historie_ceny.Spoj = new Spoj
                    {
                        Id = historie_ceny.SpojId,
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
                }

                historie_cen.Add(historie_ceny);
            }
            return historie_cen;
        }
    }
}
