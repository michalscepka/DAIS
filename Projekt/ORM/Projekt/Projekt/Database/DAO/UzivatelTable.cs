using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace Projekt.ORM.DAO
{
	public class UzivatelTable
	{
        public static string TABLE_NAME = "Uzivatel";

        public static string SQL_SELECT = "SELECT * FROM \"Uzivatel\"";
        public static string SQL_SELECT_NAME = "EXEC SelectByName @input";
        public static string SQL_INSERT = "INSERT INTO \"Uzivatel\" VALUES (@login, @jmeno, @prijmeni, @email, @typ, @posledni_navsteva, @aktivni)";
        public static string SQL_DELETE_ID = "DELETE FROM \"Uzivatel\" WHERE uzivatel_id=@id";
        public static string SQL_UPDATE = "UPDATE \"Uzivatel\" SET login=@login, jmeno=@jmeno, prijmeni=@prijmeni," +
            "email=@email, typ=@typ, posledni_navsteva=@posledni_navsteva, aktivni=@aktivni WHERE uzivatel_id=@id";
        

        /// <summary>
        /// Select the records.
        /// </summary>
        public static Collection<Uzivatel> Select(Database pDb = null)
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

            Collection<Uzivatel> users = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return users;
        }

        /// <summary>
        /// Select the records.
        /// </summary>
        public static Collection<Uzivatel> SelectByName(string input, Database pDb = null)
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

            Collection<Uzivatel> users = Read(reader);
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return users;
        }

        /// <summary>
        /// Insert the record.
        /// </summary>
        public static int Insert(Uzivatel uzivatel, Database pDb = null)
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
            PrepareCommand(command, uzivatel);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        /// <summary>
        /// Update the record.
        /// </summary>
        public static int Update(Uzivatel uzivatel, Database pDb = null)
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
            PrepareCommand(command, uzivatel);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        /// <summary>
        /// Delete the record.
        /// </summary>
        /// <param name="uzivatel_id">uzivatel id</param>
        /// <returns></returns>
        public static int Delete(int uzivatel_id, Database pDb = null)
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

            command.Parameters.AddWithValue("@id", uzivatel_id);
            int ret = db.ExecuteNonQuery(command);

            if (pDb == null)
            {
                db.Close();
            }

            return ret;
        }

        /// <summary>
        ///  Prepare a command.
        /// </summary>
        private static void PrepareCommand(SqlCommand command, Uzivatel uzivatel)
        {
            command.Parameters.AddWithValue("@id", uzivatel.Id);
            command.Parameters.AddWithValue("@login", uzivatel.Login);
            command.Parameters.AddWithValue("@jmeno", uzivatel.Jmeno);
            command.Parameters.AddWithValue("@prijmeni", uzivatel.Prijmeni);
            command.Parameters.AddWithValue("@email", uzivatel.Email);
            command.Parameters.AddWithValue("@typ", uzivatel.Typ);
            command.Parameters.AddWithValue("@posledni_navsteva", uzivatel.PosledniNavsteva == null ? DBNull.Value : (object)uzivatel.PosledniNavsteva);
            command.Parameters.AddWithValue("@aktivni", uzivatel.Aktivni);
        }

        private static Collection<Uzivatel> Read(SqlDataReader reader)
        {
            Collection<Uzivatel> uzivatele = new Collection<Uzivatel>();

            while (reader.Read())
            {
                int i = -1;
                Uzivatel uzivatel = new Uzivatel();
                uzivatel.Id = reader.GetInt32(++i);
                uzivatel.Login = reader.GetString(++i);
                uzivatel.Jmeno = reader.GetString(++i);
                uzivatel.Prijmeni = reader.GetString(++i);
                uzivatel.Email = reader.GetString(++i);
                uzivatel.Typ = reader.GetString(++i);
                if (!reader.IsDBNull(++i))
                {
                    uzivatel.PosledniNavsteva = reader.GetDateTime(i);
                }
                uzivatel.Aktivni = reader.GetBoolean(++i);

                uzivatele.Add(uzivatel);
            }
            return uzivatele;
        }
    }
}
