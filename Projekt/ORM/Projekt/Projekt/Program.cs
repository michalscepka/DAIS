using System;
using Projekt.ORM;
using Projekt.ORM.DAO;

namespace Projekt
{
	class Program
	{
		static void Main(string[] args)
		{
            Database db = new Database();
            db.Connect();

            Uzivatel u = new Uzivatel();
            u.Id = 11;
            u.Login = "son28";
            u.Jmeno = "Tonda";
            u.Prijmeni = "Sobota";
            u.Email = "email";
            u.Typ = "zakaznik";
            u.PosledniNavsteva = null;
            u.Aktivni = true;

            //UzivatelTable.Insert(u, db);
            //UzivatelTable.Update(u, db);
            //UzivatelTable.Delete(11, db);

            /*int count1 = UserTable.Select(db).Count;
            int dltCount = UserTable.Delete(7, db);
            int count2 = UserTable.Select(db).Count;

            Console.WriteLine("#C: " + count1);
            Console.WriteLine("#D: " + dltCount);
            Console.WriteLine("#C: " + count2);*/

            foreach (Uzivatel uzivatel in UzivatelTable.SelectByName("ma", db))
                Console.WriteLine(uzivatel.FullName);

            db.Close();
        }
	}
}
