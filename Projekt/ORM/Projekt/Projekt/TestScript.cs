using Projekt.ORM;
using Projekt.ORM.DAO;
using System;
using System.Data.SqlClient;

namespace Projekt
{
	public class TestScript
	{
		public Database db;

		public TestScript(Database database)
		{
			this.db = database;
		}

		public void CreateTables()
		{
			SqlCommand command = db.CreateCommand("exec CreateScript");
			db.ExecuteNonQuery(command);
		}




		
		
		
		
		
		// 1. Evidence uživatelů
		public void CreateUzivatel()
		{
			Uzivatel uzivatel1 = new Uzivatel
			{
				Login = "pepa13",
				Jmeno = "Pepa",
				Prijmeni = "Zamotany",
				Email = "pepa.zamotany@gmail.com",
				Typ = "zakaznik",
				Aktivni = true
			};

			Uzivatel uzivatel2 = new Uzivatel
			{
				Login = "noobmaster",
				Jmeno = "Pavel",
				Prijmeni = "Maly",
				Email = "pavel.maly@gmail.com",
				Typ = "zakaznik",
				Aktivni = true
			};

			Uzivatel uzivatel3 = new Uzivatel
			{
				Login = "rebarbora",
				Jmeno = "Barbora",
				Prijmeni = "Velka",
				Email = "bara.velka@gmail.com",
				Typ = "zakaznik",
				Aktivni = true
			};

			UzivatelTable.Insert(uzivatel1, db);
			UzivatelTable.Insert(uzivatel2, db);
			UzivatelTable.Insert(uzivatel3, db);
		}

		public void UpdateUzivatel()
		{
			Uzivatel uzivatel = UzivatelTable.SelectDetail(1, db);
			uzivatel.Prijmeni = "[upraveno]";
			UzivatelTable.Update(uzivatel);
		}

		public void DeleteUzivatel()
		{
			UzivatelTable.Delete(1, db);
		}

		public void SeznamUzivatelu()
		{
			Console.WriteLine("Seznam uzivatelu podle vstupu 'pa':");
			foreach (Uzivatel item in UzivatelTable.SelectSeznam("pa", db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}

		public void DetailUzivatele()
		{
			Console.WriteLine(string.Format("Detail uzivatele s id 1:\n{0}\n", UzivatelTable.SelectDetail(1, db).ToString()));
		}



		
		
		
		
		
		
		// 2. Evidence jízd
		public void CreateJizda()
		{
			// TODO pridat vic spoju
			Jizda jizda1 = new Jizda { DatumStart = new DateTime(2020, 6, 5), DatumCil = new DateTime(2020, 6, 5), SpojId = 1 };
			Jizda jizda2 = new Jizda { DatumStart = new DateTime(2020, 6, 5), DatumCil = new DateTime(2020, 6, 5), SpojId = 2 };
			Jizda jizda3 = new Jizda { DatumStart = new DateTime(2020, 6, 6), DatumCil = new DateTime(2020, 6, 6), SpojId = 1 };
			Jizda jizda4 = new Jizda { DatumStart = new DateTime(2020, 6, 6), DatumCil = new DateTime(2020, 6, 6), SpojId = 2 };
			Jizda jizda5 = new Jizda { DatumStart = new DateTime(2020, 6, 6), DatumCil = new DateTime(2020, 6, 6), SpojId = 3 };
			Jizda jizda6 = new Jizda { DatumStart = new DateTime(2020, 6, 7), DatumCil = new DateTime(2020, 6, 7), SpojId = 3 };
			Jizda jizda7 = new Jizda { DatumStart = new DateTime(2020, 6, 5), DatumCil = new DateTime(2020, 6, 5), SpojId = 4 };

			JizdaTable.Insert(jizda1, db);
			JizdaTable.Insert(jizda2, db);
			JizdaTable.Insert(jizda3, db);
			JizdaTable.Insert(jizda4, db);
			JizdaTable.Insert(jizda5, db);
			JizdaTable.Insert(jizda6, db);
			JizdaTable.Insert(jizda7, db);
		}

		public void UpdateJizda()
		{
			Console.WriteLine("2.2. Aktualizování jízdy\nJizda pred aktualizaci:\n" + JizdaTable.SelectDetail(5, db));

			Jizda jizda = JizdaTable.SelectDetail(5, db);
			jizda.DatumStart = new DateTime(2999, 9, 9);
			jizda.DatumCil = new DateTime(2999, 9, 9);
			JizdaTable.Update(jizda);

			Console.WriteLine("Jizda po aktualizaci:\n" + JizdaTable.SelectDetail(5, db) + '\n');
		}

		public void DeleteJizda()
		{
			JizdaTable.Delete(6, db);
		}

		public void VyhledaniJizdy()
		{
			Console.WriteLine("2.4. Vyhledání jízdy: stanice_id_start=1, stanice_id_cil=8, datum=5.6.2020, cas=13:00");

			foreach(int?[] item in JizdaTable.NajitJizdu(1, 8, new DateTime(2020, 6, 5), new DateTime(1900, 1, 1, 13, 0, 0), db))
				Console.WriteLine(string.Format("JizdaId: {0}; prestupni staniceId: {1}; na jizduId: {2}", item[0], item[1], item[2]));

			Console.WriteLine();
		}

		public void DetailJizdy()
		{
			Console.WriteLine(string.Format("2.5. Detail jizdy s id 1:\n{0}\n", JizdaTable.SelectDetail(1, db).ToString()));
		}

		public void VypocitatCenuJizdy()
		{
			int jizda_id = 1;
			int stanice_id_start = 2;
			int stanice_id_cil = 5;
			Console.WriteLine(string.Format("2.6. Vypočítání ceny jízdy:\n" +
				"Vypocitana cena jizdy = {0} Kc. Pro jizda_id: '{1}', stanice_id_start: '{2}' a stanice_id_cil: '{3}'.\n{4}", 
				JizdaTable.VypocitatCenuJizdy(jizda_id, stanice_id_start, stanice_id_cil, db), jizda_id, stanice_id_start, stanice_id_cil));
		}









		// 3. Evidence jízdenek
		public void CreateJizdenku()
		{
			Jizdenka jizdenka1 = new Jizdenka { UzivatelId = 1, Cena = 0 };
			Jizdenka jizdenka2 = new Jizdenka { UzivatelId = 1, Cena = 0 };
			Jizdenka jizdenka3 = new Jizdenka { UzivatelId = 2, Cena = 0 };

			JizdenkaTable.Insert(jizdenka1, db);
			JizdenkaTable.Insert(jizdenka2, db);
			JizdenkaTable.Insert(jizdenka3, db);
		}

		public void ZapsatJizduDoJizdenky()
		{
			Console.WriteLine("3.2. Zapsání jízdy do jízdenky:\nPred zapsanim jizdy do jizdenky:");
			

			JizdenkaTable.ZapsatJizdu(1, 1, 1, 5);
			JizdenkaTable.ZapsatJizdu(1, 2, 5, 8);

			Console.WriteLine("Po zapsani jizdy do jizdenky:");
			
		}

		public void DeleteJizdenka()
		{
			Console.WriteLine("3.3. Zrušení jízdenky:\nPred zrusenim jizdenky pro uzivatel_id: '1':");
			foreach (JizdenkaJizda item in JizdenkaTable.SelectSeznam(1, db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();

			JizdenkaTable.Delete(1, db);
			
			Console.WriteLine("Po zruseni jizdenky pro uzivatel_id: '1':");
			foreach (JizdenkaJizda item in JizdenkaTable.SelectSeznam(1, db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}

		public void SeznamJizdenek()
		{
			Console.WriteLine("Seznam jizdenek podle id uzivatele '1':");
			foreach (JizdenkaJizda item in JizdenkaTable.SelectSeznam(1, db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}

		public void DetailJizdenky()
		{
			Console.WriteLine("Detail jizdenky s id '1':");
			foreach (JizdenkaJizda item in JizdenkaTable.SelectDetail(1, db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}




		
		
		
		
		
		// 4. Evidence spojů
		public void CreateSpoj()
		{
			Spoj spoj1 = new Spoj
			{
				Nazev = "LE 400",
				CenaZaKm = 1,
				KapacitaMist = 300,
				Pravidelny = true,
				SpolecnostId = 3,
				Aktivni = true
			};

			Spoj spoj2 = new Spoj
			{
				Nazev = "RJ 106",
				CenaZaKm = 2,
				KapacitaMist = 150,
				Pravidelny = true,
				SpolecnostId = 2,
				Aktivni = true
			};

			Spoj spoj3 = new Spoj
			{
				Nazev = "SC 512",
				CenaZaKm = 3,
				KapacitaMist = 100,
				Pravidelny = false,
				SpolecnostId = 1,
				Aktivni = true
			};

			Spoj spoj4 = new Spoj
			{
				Nazev = "SC 500",
				CenaZaKm = 4,
				KapacitaMist = 200,
				Pravidelny = true,
				SpolecnostId = 1,
				Aktivni = true
			};

			SpojTable.Insert(spoj1, db);
			SpojTable.Insert(spoj2, db);
			SpojTable.Insert(spoj3, db);
			SpojTable.Insert(spoj4, db);
		}

		public void UpdateSpoj()
		{
			Spoj spoj = SpojTable.SelectDetail(3, db);
			spoj.Nazev = "[upraveno]";
			SpojTable.Update(spoj);
		}

		public void DeleteSpoj()
		{
			SpojTable.Delete(3);
		}

		public void SeznamSpoju()
		{
			Console.WriteLine("Seznam spoju projizdejicich stanici s id 2:");
			foreach (Spoj item in SpojTable.SelectSeznam(2, db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}
		
		public void DetailSpoje()
		{
			Console.WriteLine(string.Format("Detail spoje s id 1:\n{0}\n", SpojTable.SelectDetail(1, db).ToString()));
		}









		// 5. Evidence příjezdů
		public void CreatePrijezd()
		{
			Prijezd prijezd1 = new Prijezd { StaniceId = 1, SpojId = 1, Cas = new DateTime(1900, 1, 1, 14, 0, 0), Poradi = 1, Vzdalenost = 0 };
			Prijezd prijezd2 = new Prijezd { StaniceId = 2, SpojId = 1, Cas = new DateTime(1900, 1, 1, 14, 10, 0), Poradi = 2, Vzdalenost = 10 };
			Prijezd prijezd3 = new Prijezd { StaniceId = 3, SpojId = 1, Cas = new DateTime(1900, 1, 1, 14, 20, 0), Poradi = 3, Vzdalenost = 20 };
			Prijezd prijezd4 = new Prijezd { StaniceId = 5, SpojId = 1, Cas = new DateTime(1900, 1, 1, 14, 30, 0), Poradi = 4, Vzdalenost = 30 };
			Prijezd prijezd5 = new Prijezd { StaniceId = 6, SpojId = 1, Cas = new DateTime(1900, 1, 1, 14, 40, 0), Poradi = 5, Vzdalenost = 40 };

			Prijezd prijezd6 = new Prijezd { StaniceId = 4, SpojId = 2, Cas = new DateTime(1900, 1, 1, 14, 35, 0), Poradi = 1, Vzdalenost = 0 };
			Prijezd prijezd7 = new Prijezd { StaniceId = 5, SpojId = 2, Cas = new DateTime(1900, 1, 1, 14, 45, 0), Poradi = 2, Vzdalenost = 10 };
			Prijezd prijezd8 = new Prijezd { StaniceId = 7, SpojId = 2, Cas = new DateTime(1900, 1, 1, 14, 55, 0), Poradi = 3, Vzdalenost = 20 };
			Prijezd prijezd9 = new Prijezd { StaniceId = 8, SpojId = 2, Cas = new DateTime(1900, 1, 1, 15, 5, 0), Poradi = 4, Vzdalenost = 30 };
			Prijezd prijezd10 = new Prijezd { StaniceId = 9, SpojId = 2, Cas = new DateTime(1900, 1, 1, 15, 9, 0), Poradi = 5, Vzdalenost = 80 };

			Prijezd prijezd11 = new Prijezd { StaniceId = 4, SpojId = 3, Cas = new DateTime(1900, 1, 1, 14, 35, 0), Poradi = 1, Vzdalenost = 0 };
			Prijezd prijezd12 = new Prijezd { StaniceId = 5, SpojId = 3, Cas = new DateTime(1900, 1, 1, 14, 45, 0), Poradi = 2, Vzdalenost = 10 };
			Prijezd prijezd13 = new Prijezd { StaniceId = 7, SpojId = 3, Cas = new DateTime(1900, 1, 1, 14, 55, 0), Poradi = 3, Vzdalenost = 20 };
			Prijezd prijezd14 = new Prijezd { StaniceId = 8, SpojId = 3, Cas = new DateTime(1900, 1, 1, 15, 5, 0), Poradi = 4, Vzdalenost = 30 };
			Prijezd prijezd15 = new Prijezd { StaniceId = 9, SpojId = 3, Cas = new DateTime(1900, 1, 1, 15, 9, 0), Poradi = 5, Vzdalenost = 80 };

			PrijezdTable.Insert(prijezd1, db);
			PrijezdTable.Insert(prijezd2, db);
			PrijezdTable.Insert(prijezd3, db);
			PrijezdTable.Insert(prijezd4, db);
			PrijezdTable.Insert(prijezd5, db);
			PrijezdTable.Insert(prijezd6, db);
			PrijezdTable.Insert(prijezd7, db);
			PrijezdTable.Insert(prijezd8, db);
			PrijezdTable.Insert(prijezd9, db);
			PrijezdTable.Insert(prijezd10, db);
			PrijezdTable.Insert(prijezd11, db);
			PrijezdTable.Insert(prijezd12, db);
			PrijezdTable.Insert(prijezd13, db);
			PrijezdTable.Insert(prijezd14, db);
			PrijezdTable.Insert(prijezd15, db);
		}

		public void UdpatePrijezd()
		{
			Prijezd prijezd = PrijezdTable.SelectDetail(6, 1, db);
			prijezd.Vzdalenost = 9999;
			PrijezdTable.Update(prijezd);
		}

		public void DeletePrijezd()
		{
			PrijezdTable.Delete(9, 2, db);
		}

		public void SeznamPrijezdu()
		{
			Console.WriteLine("Seznam prijezdu filtrace podle vstupu 'Ostrava-Svinov', 'LE', '14:00', '2020-04-20:");
			foreach (Prijezd item in PrijezdTable.SelectSeznam("Ostrava-Svinov", "", new DateTime(1900, 1, 1, 14, 0, 0), new DateTime(2020, 4, 20), db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}

		public void DetailPrijezdu()
		{
			Console.WriteLine(PrijezdTable.SelectDetail(2, 1, db));
		}









		// 6. Evidence stanic
		public void SeznamStanic()
		{
			Console.WriteLine("Seznam stanic filtrace podle vstupu 'Ost':");
			foreach (Stanice item in StaniceTable.SelectSeznam("Ost", db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}

		public void DetailStanice()
		{
			Console.WriteLine(string.Format("Detail stanice s id 2:\n{0}\n", StaniceTable.SelectDetail(2, db).ToString()));
		}




		
		
		
		
		
		// 7. Evidence měst
		public void SeznamMest()
		{
			Console.WriteLine("Seznam mest filtrace podle vstupu 'ha':");
			foreach (Mesto item in MestoTable.SelectSeznam("ha", db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}

		public void DetailMesta()
		{
			Console.WriteLine(string.Format("Detail mesta s id 1:\n{0}\n", MestoTable.SelectDetail(1, db).ToString()));
		}




		
		
		
		
		// 8. Evidence společností
		public void SeznamSpolecnosti()
		{
			Console.WriteLine("Seznam spolecnosti podle vstupu 're':");
			foreach (Spolecnost item in SpolecnostTable.SelectSeznam("re", db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}

		public void DetailSpolecnosti()
		{
			Console.WriteLine(string.Format("Detail spolecnosti s id 1:\n{0}\n", SpolecnostTable.SelectDetail(1, db).ToString()));
		}
	}
}
