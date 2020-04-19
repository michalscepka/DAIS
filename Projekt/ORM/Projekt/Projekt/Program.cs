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

            /*//Uzivatel

            foreach (Uzivatel item in UzivatelTable.Select(db))
                Console.WriteLine(item.ToString());
            foreach (Uzivatel item in UzivatelTable.Select("ja", db))
                Console.WriteLine(item.ToString());
            */
            //Console.WriteLine();
            //Jizda

            //Console.WriteLine(PrijezdTable.SelectDetail(1, 1, db));

            //Console.WriteLine(JizdaTable.VypocitatCenuJizdy(2, 3, 13, db));

            Console.Write(string.Join("; ", JizdaTable.NajitJizdu(1, 8, new DateTime(2020, 3, 30), new DateTime(1900, 1, 1, 14, 0, 0), db)));

            /*foreach (Prijezd item in PrijezdTable.SelectSeznam("ost", "", new DateTime(1900, 1, 1, 14, 0, 0), new DateTime(2020, 3, 30), db))
                Console.WriteLine(item.ToString());*/

            /*Jizda jizda = new Jizda
            {
                Id = 21,
                DatumStart = new DateTime(2020, 5, 5),
                DatumCil = new DateTime(2020, 5, 5),
                SpojId = 1
            };

            JizdaTable.Update(jizda, db);*/

            //Console.WriteLine(JizdaTable.Select(1, 8, new DateTime(2020, 3, 30), new DateTime(1900, 1, 1, 14, 0, 0)));
            //Console.WriteLine(JizdaTable.VypocitatCenuJizdy(2, 3, 13, db));

            /*foreach (Jizda item in JizdaTable.Select(db))
                Console.WriteLine(item.ToString());*/

            //Console.WriteLine();
            //Jizdenka

            //foreach (Jizdenka item in JizdenkaTable.Select(db))
            //    Console.WriteLine(item.ToString());

            //JizdenkaTable.ZapsatJizdu(3, 5, 1, 5);
            //JizdenkaTable.Delete(3, db);
            /*foreach (Jizdenka item in JizdenkaTable.SelectSeznam(1, db))
                Console.WriteLine(item.ToString());*/

            /*Console.WriteLine();
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
                Console.WriteLine(item.ToString());*/

            db.Close();
        }
	}
}
