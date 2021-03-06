﻿using Forms_SCE0007;
using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
    public class JizdaTable
    {
        public static string TABLE_NAME = "Jizda";

        public static string SQL_INSERT = "INSERT INTO Jizda (datum_start, datum_cil, spoj_id) VALUES (@datum_start, @datum_cil, @spoj_id)";
        public static string SQL_UPDATE = "EXEC AktualizovatJizdu @id, @novy_datum_start, @novy_datum_cil, @novy_spoj_id";
        public static string SQL_DELETE_ID = "DELETE FROM Jizda WHERE jizda_id=@id";
        public static string SQL_FILTER_BY_ARIBUTES = "EXEC NajitJizdu @start_stanice_id, @cil_stanice_id, @datum, @cas_od";
        public static string SQL_SELECT_ID = "SELECT j.jizda_id, j.datum_start, j.datum_cil, j.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.aktivni, s.spolecnost_id, sp.nazev, sp.web, sp.email " +
            "FROM Jizda j JOIN Spoj s ON j.spoj_id = s.spoj_id JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id WHERE jizda_id=@id";
        public static string SQL_SPOCITEJ_CENU = "SELECT dbo.SpocitejCenuJizdy(@jizda_id, @stanice_id_start, @stanice_id_cil) AS cena";
        public static string SQL_ZJISTI_DATA = "EXEC ZjistiData @jizda_1_id, @prestup_id, @jizda_2_id, @start_stanice_id, @cil_stanice_id";

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

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        // 2.7. Zjisti data
        public static NalezenaJizda ZjistiData(int jizda_1_id, int prestup, int jizda_2_id, int start_stanice_id, int cil_stanice_id, Database pDb = null)
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

            SqlCommand command = db.CreateCommand(SQL_ZJISTI_DATA);
            command.Parameters.AddWithValue("@jizda_1_id", jizda_1_id);
            command.Parameters.AddWithValue("@prestup_id", prestup);
            command.Parameters.AddWithValue("@jizda_2_id", jizda_2_id);
            command.Parameters.AddWithValue("@start_stanice_id", start_stanice_id);
            command.Parameters.AddWithValue("@cil_stanice_id", cil_stanice_id);
            SqlDataReader reader = db.Select(command);

            NalezenaJizda nalezenaJizda = new NalezenaJizda();

            reader.Read();
            int i = -1;
            nalezenaJizda.Spoj1 = reader.GetString(++i);
            nalezenaJizda.PrestupStanice = reader.GetString(++i);
            nalezenaJizda.Spoj2 = reader.GetString(++i);
            nalezenaJizda.CasOdjezdu = reader.GetTimeSpan(++i).ToString();
            nalezenaJizda.CasPrijezdu = reader.GetTimeSpan(++i).ToString();
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return nalezenaJizda;
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
                jizda.Spoj = new Spoj
                {
                    Id = reader.GetInt32(i),
                    Nazev = reader.GetString(++i),
                    CenaZaKm = reader.GetInt32(++i),
                    KapacitaMist = reader.GetInt32(++i),
                    Pravidelny = reader.GetBoolean(++i),
                    Aktivni = reader.GetBoolean(++i),
                    SpolecnostId = reader.GetInt32(++i)
                };
                jizda.Spoj.Spolecnost = new Spolecnost
                {
                    Id = reader.GetInt32(i),
                    Nazev = reader.GetString(++i),
                    Web = reader.GetString(++i),
                    Email = reader.GetString(++i)
                };

                jizdy.Add(jizda);
            }
            return jizdy;
        }
    }
}
