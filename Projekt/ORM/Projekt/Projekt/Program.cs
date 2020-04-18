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

            //Uzivatel

            /*Uzivatel u = new Uzivatel();
            u.Id = 11;
            u.Login = "son28";
            u.Jmeno = "Tonda";
            u.Prijmeni = "Sobota";
            u.Email = "email";
            u.Typ = "zakaznik";
            u.PosledniNavsteva = null;
            u.Aktivni = true;*/

            //UzivatelTable.Insert(u, db);
            //UzivatelTable.Update(u, db);
            //UzivatelTable.Delete(11, db);

            /*int count1 = UserTable.Select(db).Count;
            int dltCount = UserTable.Delete(7, db);
            int count2 = UserTable.Select(db).Count;

            Console.WriteLine("#C: " + count1);
            Console.WriteLine("#D: " + dltCount);
            Console.WriteLine("#C: " + count2);*/

            foreach (Uzivatel item in UzivatelTable.Select(db))
                Console.WriteLine(item.ToString());

            //UzivatelTable.Delete(1);

            //Console.WriteLine(UzivatelTable.Select(1).ToString());

            //Jizda

            foreach (Jizda item in JizdaTable.Select(db))
                Console.WriteLine(item.ToString());

            //Jizdenka

            foreach (Jizdenka item in JizdenkaTable.Select(db))
                Console.WriteLine(item.ToString());

            //Spoj

            foreach (Spoj item in SpojTable.Select(db))
                Console.WriteLine(item.ToString());

            //Prijezd

            foreach (Prijezd item in PrijezdTable.Select(db))
                Console.WriteLine(item.ToString());

            //Stanice

            foreach (Stanice item in StaniceTable.Select(db))
                Console.WriteLine(item.ToString());

            //Mesto

            foreach (Mesto item in MestoTable.Select(db))
                Console.WriteLine(item.ToString());

            //Spolecnost

            foreach (Spolecnost item in SpolecnostTable.Select(db))
                Console.WriteLine(item.ToString());

            db.Close();
        }
	}
}
