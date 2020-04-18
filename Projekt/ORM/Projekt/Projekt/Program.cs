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

            foreach (Uzivatel item in UzivatelTable.Select(db))
                Console.WriteLine(item.ToString());

            Console.WriteLine();
            //Jizda

            foreach (Jizda item in JizdaTable.Select(db))
                Console.WriteLine(item.ToString());

            Console.WriteLine();
            //Jizdenka

            foreach (Jizdenka item in JizdenkaTable.Select(db))
                Console.WriteLine(item.ToString());

            Console.WriteLine();
            //Spoj

            foreach (Spoj item in SpojTable.Select(db))
                Console.WriteLine(item.ToString());

            Console.WriteLine();
            //Prijezd

            foreach (Prijezd item in PrijezdTable.Select(db))
                Console.WriteLine(item.ToString());

            Console.WriteLine();
            //Stanice

            foreach (Stanice item in StaniceTable.Select(db))
                Console.WriteLine(item.ToString());

            Console.WriteLine();
            //Mesto

            foreach (Mesto item in MestoTable.Select(db))
                Console.WriteLine(item.ToString());

            Console.WriteLine();
            //Spolecnost

            foreach (Spolecnost item in SpolecnostTable.Select(db))
                Console.WriteLine(item.ToString());

            Console.WriteLine();
            //HistorieCeny

            foreach (HistorieCeny item in HistorieCenyTable.Select(db))
                Console.WriteLine(item.ToString());

            db.Close();
        }
	}
}
