using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class JizdenkaTable
	{
        public static string TABLE_NAME = "Jizdenka";

        public static string SQL_INSERT = "INSERT INTO Jizdenka (uzivatel_id, cena) VALUES (@uzivatel_id, @cena)";
        public static string SQL_ZAPSAT_JIZDU = "EXEC PridatJizduDoJizdenky @jizdenka_id, @jizda_id, @stanice_id_start, @stanice_id_cil";
        public static string SQL_DELETE_ID = "EXEC ZrusitJizdenku @id";
        public static string SQL_SELECT_BY_USER =
            "SELECT jj.jizdenka_id, jj.jizda_id, jj.stanice_id_start, jj.stanice_id_cil, jj.poradi, " +
                "ji.jizdenka_id, ji.uzivatel_id, ji.cena, " +
                "u.uzivatel_id, u.login, u.jmeno, u.prijmeni, u.email, u.typ, u.aktivni, u.posledni_navsteva, " +
                "j.jizda_id, j.datum_start, j.datum_cil, j.spoj_id, " +
                "s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.spolecnost_id, s.aktivni, " +
                "sp.spolecnost_id, sp.nazev, sp.web, sp.email, " +
                "st.stanice_id, st.nazev, st.mesto_id, m.nazev, m.kraj, " +
                "st2.stanice_id, st2.nazev, st2.mesto_id, m2.nazev, m2.kraj " +
            "FROM Jizdenka ji " +
                "LEFT JOIN jizdenka_jizda jj ON ji.jizdenka_id = jj.jizdenka_id " +
                "LEFT JOIN Uzivatel u ON ji.uzivatel_id = u.uzivatel_id " +
                "LEFT JOIN Jizda j ON jj.jizda_id = j.jizda_id " +
                "LEFT JOIN Spoj s ON j.spoj_id = s.spoj_id " +
                "LEFT JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id " +
                "LEFT JOIN Stanice st ON jj.stanice_id_start = st.stanice_id " +
                "LEFT JOIN Mesto m ON st.mesto_id = m.mesto_id " +
                "LEFT JOIN Stanice st2 ON jj.stanice_id_cil = st2.stanice_id " +
                "LEFT JOIN Mesto m2 ON st2.mesto_id = m2.mesto_id " +
            "WHERE u.uzivatel_id=@id";
        public static string SQL_SELECT_ID =
            "SELECT jj.jizdenka_id, jj.jizda_id, jj.stanice_id_start, jj.stanice_id_cil, jj.poradi, " +
                "ji.jizdenka_id, ji.uzivatel_id, ji.cena, " +
                "u.uzivatel_id, u.login, u.jmeno, u.prijmeni, u.email, u.typ, u.aktivni, u.posledni_navsteva, " +
                "j.jizda_id, j.datum_start, j.datum_cil, j.spoj_id, " +
                "s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.spolecnost_id, s.aktivni, " +
                "sp.spolecnost_id, sp.nazev, sp.web, sp.email, " +
                "st.stanice_id, st.nazev, st.mesto_id, m.nazev, m.kraj, " +
                "st2.stanice_id, st2.nazev, st2.mesto_id, m2.nazev, m2.kraj " +
            "FROM Jizdenka ji " +
                "LEFT JOIN jizdenka_jizda jj ON ji.jizdenka_id = jj.jizdenka_id " +
                "LEFT JOIN Uzivatel u ON ji.uzivatel_id = u.uzivatel_id " +
                "LEFT JOIN Jizda j ON jj.jizda_id = j.jizda_id " +
                "LEFT JOIN Spoj s ON j.spoj_id = s.spoj_id " +
                "LEFT JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id " +
                "LEFT JOIN Stanice st ON jj.stanice_id_start = st.stanice_id " +
                "LEFT JOIN Mesto m ON st.mesto_id = m.mesto_id " +
                "LEFT JOIN Stanice st2 ON jj.stanice_id_cil = st2.stanice_id " +
                "LEFT JOIN Mesto m2 ON st2.mesto_id = m2.mesto_id " +
            "WHERE jj.jizdenka_id=@id";

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
        public static Collection<JizdenkaJizda> SelectSeznam(int uzivatel_id, Database pDb = null)
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

            Collection<JizdenkaJizda> jizdenky = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return jizdenky;
        }

        // 3.5. Detail jízdenky.
        public static Collection<JizdenkaJizda> SelectDetail(int id, Database pDb = null)
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

            Collection<JizdenkaJizda> jizdenka_jizdy = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return jizdenka_jizdy;
        }

        private static void PrepareCommand(SqlCommand command, Jizdenka jizdenka)
        {
            command.Parameters.AddWithValue("@id", jizdenka.Id);
            command.Parameters.AddWithValue("@uzivatel_id", jizdenka.UzivatelId);
            command.Parameters.AddWithValue("@cena", jizdenka.Cena);
        }

        private static Collection<JizdenkaJizda> Read(SqlDataReader reader)
        {
            Collection<JizdenkaJizda> jizdenka_jizdy = new Collection<JizdenkaJizda>();

            while (reader.Read())
            {
                int i = -1;

                JizdenkaJizda jizdenka_jizda = new JizdenkaJizda();
                if (!reader.IsDBNull(++i))
                {
                    jizdenka_jizda.JizdenkaId = reader.GetInt32(i);
                    jizdenka_jizda.JizdaId = reader.GetInt32(++i);
                    jizdenka_jizda.StaniceIdStart = reader.GetInt32(++i);
                    jizdenka_jizda.StaniceIdCil = reader.GetInt32(++i);
                    jizdenka_jizda.Poradi = reader.GetInt32(++i);
                }
                else
                {
                    i = 4;
                }

                jizdenka_jizda.Jizdenka = new Jizdenka
                {
                    Id = reader.GetInt32(++i),
                    UzivatelId = reader.GetInt32(++i),
                    Cena = reader.GetInt32(++i)
                };
                jizdenka_jizda.Jizdenka.Uzivatel = new Uzivatel
                {
                    Id = reader.GetInt32(++i),
                    Login = reader.GetString(++i),
                    Jmeno = reader.GetString(++i),
                    Prijmeni = reader.GetString(++i),
                    Email = reader.GetString(++i),
                    Typ = reader.GetString(++i),
                    Aktivni = reader.GetBoolean(++i)
                };
                if (!reader.IsDBNull(++i))
                {
                    jizdenka_jizda.Jizdenka.Uzivatel.PosledniNavsteva = reader.GetDateTime(i);
                }

                if (!reader.IsDBNull(++i))
                {
                    jizdenka_jizda.Jizda = new Jizda
                    {
                        Id = reader.GetInt32(i),
                        DatumStart = reader.GetDateTime(++i),
                        DatumCil = reader.GetDateTime(++i),
                        SpojId = reader.GetInt32(++i)
                    };
                    jizdenka_jizda.Jizda.Spoj = new Spoj
                    {
                        Id = reader.GetInt32(i),
                        Nazev = reader.GetString(++i),
                        CenaZaKm = reader.GetInt32(++i),
                        KapacitaMist = reader.GetInt32(++i),
                        Pravidelny = reader.GetBoolean(++i),
                        SpolecnostId = reader.GetInt32(++i),
                        Aktivni = reader.GetBoolean(++i)
                    };
                    jizdenka_jizda.Jizda.Spoj.Spolecnost = new Spolecnost
                    {
                        Id = reader.GetInt32(++i),
                        Nazev = reader.GetString(++i),
                        Web = reader.GetString(++i),
                        Email = reader.GetString(++i)
                    };
                    jizdenka_jizda.StaniceStart = new Stanice
                    {
                        Id = reader.GetInt32(++i),
                        Nazev = reader.GetString(++i),
                        MestoId = reader.GetInt32(++i)
                    };
                    jizdenka_jizda.StaniceStart.Mesto = new Mesto
                    {
                        Id = reader.GetInt32(i),
                        Nazev = reader.GetString(++i),
                        Kraj = reader.GetString(++i)
                    };
                    jizdenka_jizda.StaniceCil = new Stanice
                    {
                        Id = reader.GetInt32(++i),
                        Nazev = reader.GetString(++i),
                        MestoId = reader.GetInt32(++i)
                    };
                    jizdenka_jizda.StaniceCil.Mesto = new Mesto
                    {
                        Id = reader.GetInt32(i),
                        Nazev = reader.GetString(++i),
                        Kraj = reader.GetString(++i)
                    };
                }
                else
                {
                    jizdenka_jizda.Jizda = new Jizda
                    {
                        Spoj = new Spoj
                        {
                            Spolecnost = new Spolecnost()
                        }
                    };
                    jizdenka_jizda.StaniceStart = new Stanice
                    {
                        Mesto = new Mesto()
                    };
                    jizdenka_jizda.StaniceCil = new Stanice
                    {
                        Mesto = new Mesto()
                    };
                }

                jizdenka_jizdy.Add(jizdenka_jizda);
            }
            return jizdenka_jizdy;
        }
    }
}
