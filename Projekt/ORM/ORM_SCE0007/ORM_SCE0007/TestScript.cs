using Projekt.ORM;
using Projekt.ORM.DAO;
using System;
using System.Data.SqlClient;
using System.IO;
using System.Text;

namespace Projekt
{
	public class TestScript
	{
		public Database db;

		public TestScript(Database database)
		{
			this.db = database;
		}

		private string ReadSqlFile(string path)
		{
			StringBuilder fileString = new StringBuilder();

			try
			{
				using (StreamReader sr = new StreamReader(path))
				{
					string tmp;
					while ((tmp = sr.ReadLine()) != null)
					{
						fileString.Append(tmp + "\n");
					}
				}
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}

			return fileString.ToString();
		}

		public void DbInit()
		{
			DirectoryInfo dicDirectoryInfo = Directory.GetParent(AppDomain.CurrentDomain.BaseDirectory).Parent.Parent.Parent;
			string delete_sql = ReadSqlFile(dicDirectoryInfo.FullName + "\\" + "SQLs" + "\\" + "delete.sql");
			string create_sql = ReadSqlFile(dicDirectoryInfo.FullName + "\\" + "SQLs" + "\\" + "create.sql");
			string data_sql = ReadSqlFile(dicDirectoryInfo.FullName + "\\" + "SQLs" + "\\" + "data.sql");

			try
			{
				SqlCommand command = db.CreateCommand(delete_sql);
				int status = db.ExecuteNonQuery(command);
			}
			catch (Exception) { }

			try
			{
				SqlCommand command = db.CreateCommand(create_sql);
				int status = db.ExecuteNonQuery(command);
			}
			catch (Exception) { }

			try
			{
				SqlCommand command = db.CreateCommand(data_sql);
				int status = db.ExecuteNonQuery(command);
			}
			catch (Exception) { }
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
				PosledniNavsteva = new DateTime(2020, 4, 24),
				Aktivni = true
			};

			Uzivatel uzivatel2 = new Uzivatel
			{
				Login = "noobmaster",
				Jmeno = "Pavel",
				Prijmeni = "Maly",
				Email = "pavel.maly@gmail.com",
				Typ = "zakaznik",
				PosledniNavsteva = new DateTime(2020, 4, 25),
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
			UzivatelTable.Delete(3, db);
		}

		public void SeznamUzivatelu()
		{
			Console.WriteLine("1.4. Seznam uživatelů - filtrace podle vstupu 'pa':");
			foreach (Uzivatel item in UzivatelTable.SelectSeznam("pa", db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}

		public void DetailUzivatele()
		{
			Console.WriteLine(string.Format("1.5. Detail uživatele - id '3':\n{0}\n", UzivatelTable.SelectDetail(3, db).ToString()));
		}



		
		
		
		
		
		
		// 2. Evidence jízd
		public void CreateJizda()
		{
			Jizda jizda1 = new Jizda { DatumStart = new DateTime(2020, 6, 5), DatumCil = new DateTime(2020, 6, 5), SpojId = 1 };
			Jizda jizda2 = new Jizda { DatumStart = new DateTime(2020, 6, 5), DatumCil = new DateTime(2020, 6, 5), SpojId = 2 };
			Jizda jizda3 = new Jizda { DatumStart = new DateTime(2020, 6, 5), DatumCil = new DateTime(2020, 6, 5), SpojId = 3 };
			Jizda jizda4 = new Jizda { DatumStart = new DateTime(2020, 6, 5), DatumCil = new DateTime(2020, 6, 5), SpojId = 4 };
			Jizda jizda5 = new Jizda { DatumStart = new DateTime(2020, 6, 5), DatumCil = new DateTime(2020, 6, 5), SpojId = 5 };

			Jizda jizda6 = new Jizda { DatumStart = new DateTime(2020, 6, 6), DatumCil = new DateTime(2020, 6, 6), SpojId = 1 };
			Jizda jizda7 = new Jizda { DatumStart = new DateTime(2020, 6, 6), DatumCil = new DateTime(2020, 6, 6), SpojId = 2 };
			Jizda jizda8 = new Jizda { DatumStart = new DateTime(2020, 6, 6), DatumCil = new DateTime(2020, 6, 6), SpojId = 3 };

			Jizda jizda9 = new Jizda { DatumStart = new DateTime(2020, 6, 7), DatumCil = new DateTime(2020, 6, 7), SpojId = 1 };

			JizdaTable.Insert(jizda1, db);
			JizdaTable.Insert(jizda2, db);
			JizdaTable.Insert(jizda3, db);
			JizdaTable.Insert(jizda4, db);
			JizdaTable.Insert(jizda5, db);
			JizdaTable.Insert(jizda6, db);
			JizdaTable.Insert(jizda7, db);
			JizdaTable.Insert(jizda8, db);
			JizdaTable.Insert(jizda9, db);
		}

		public void UpdateJizda()
		{
			Console.WriteLine("2.2. Aktualizování jízdy:\nJizda pred aktualizaci:\n" + JizdaTable.SelectDetail(9, db));

			Jizda jizda = JizdaTable.SelectDetail(9, db);
			jizda.DatumStart = new DateTime(2999, 9, 9);
			jizda.DatumCil = new DateTime(2999, 9, 9);
			JizdaTable.Update(jizda);

			Console.WriteLine("\nJizda po aktualizaci:\n" + JizdaTable.SelectDetail(9, db) + '\n');
		}

		public void DeleteJizda()
		{
			JizdaTable.Delete(9, db);
		}

		public void VyhledaniJizdy()
		{
			Console.WriteLine("2.4. Vyhledání jízdy: stanice_id_start=1, stanice_id_cil=8, datum=5.6.2020, cas=13:00");

			foreach(int?[] item in JizdaTable.NajitJizdu(1, 8, new DateTime(2020, 6, 5), new DateTime(1900, 1, 1, 13, 0, 0), db))
				Console.WriteLine(string.Format("JizdaId: '{0}', prestupni staniceId: '{1}', na jizduId: '{2}'", item[0], item[1], item[2]));
			Console.WriteLine();
		}

		public void DetailJizdy()
		{
			Console.WriteLine(string.Format("2.5. Detail jizdy - id '1':\n{0}\n", JizdaTable.SelectDetail(1, db).ToString()));
		}

		public void VypocitatCenuJizdy()
		{
			int jizda_id = 1;
			int stanice_id_start = 1;
			int stanice_id_cil = 6;
			Console.WriteLine(string.Format("2.6. Vypočítání ceny jízdy:\n" +
				"Vypocitana cena jizdy = {0} Kc. Pro jizda_id: '{1}', stanice_id_start: '{2}' a stanice_id_cil: '{3}'.\n", 
				JizdaTable.VypocitatCenuJizdy(jizda_id, stanice_id_start, stanice_id_cil, db), jizda_id, stanice_id_start, stanice_id_cil));
		}

		public void ZjistiData()
		{
			Console.WriteLine(JizdaTable.ZjistiData(1, 5, 2, 1, 8, db));
		}









		// 3. Evidence jízdenek
		public void CreateJizdenka()
		{
			Jizdenka jizdenka1 = new Jizdenka { UzivatelId = 1, Cena = 0 };
			Jizdenka jizdenka2 = new Jizdenka { UzivatelId = 1, Cena = 0 };
			Jizdenka jizdenka3 = new Jizdenka { UzivatelId = 2, Cena = 0 };
			Jizdenka jizdenka4 = new Jizdenka { UzivatelId = 2, Cena = 0 };

			JizdenkaTable.Insert(jizdenka1, db);
			JizdenkaTable.Insert(jizdenka2, db);
			JizdenkaTable.Insert(jizdenka3, db);
			JizdenkaTable.Insert(jizdenka4, db);
		}

		public void ZapsatJizduDoJizdenky()
		{
			JizdenkaTable.ZapsatJizdu(1, 1, 1, 5);
			JizdenkaTable.ZapsatJizdu(1, 2, 5, 8);

			JizdenkaTable.ZapsatJizdu(2, 1, 2, 5);

			JizdenkaTable.ZapsatJizdu(3, 1, 2, 5);
			JizdenkaTable.ZapsatJizdu(3, 2, 5, 7);
		}

		public void DeleteJizdenka()
		{
			JizdenkaTable.Delete(3, db);
		}

		public void SeznamJizdenek()
		{
			Console.WriteLine("3.4. Seznam jízdenek - podle id uzivatele '1':");
			foreach (JizdenkaJizda item in JizdenkaTable.SelectSeznam(1, db))
				Console.WriteLine(item.Info);
			Console.WriteLine();
		}

		public void DetailJizdenky()
		{
			Console.WriteLine("3.5. Detail jízdenky - id '1':");
			foreach (JizdenkaJizda item in JizdenkaTable.SelectDetail(1, db))
				Console.WriteLine(item.Info);
			Console.WriteLine();
		}




		
		
		
		
		
		// 4. Evidence spojů
		public void CreateSpoj()
		{
			Spoj spoj1 = new Spoj
			{
				Nazev = "LE 500",
				CenaZaKm = 1,
				KapacitaMist = 300,
				Pravidelny = true,
				SpolecnostId = 3,
				Aktivni = true
			};

			Spoj spoj2 = new Spoj
			{
				Nazev = "F",
				CenaZaKm = 1,
				KapacitaMist = 300,
				Pravidelny = true,
				SpolecnostId = 3,
				Aktivni = true
			};

			SpojTable.Insert(spoj1, db);
			SpojTable.Insert(spoj2, db);
		}

		public void UpdateSpoj()
		{
			Spoj spoj = SpojTable.SelectDetail(6, db);
			spoj.Nazev = "[upraveno]";
			SpojTable.Update(spoj);
		}

		public void DeleteSpoj()
		{
			SpojTable.Delete(7);
		}

		public void SeznamSpoju()
		{
			Console.WriteLine("4.4. Seznam spojů - projizdejicich stanici 'Ostrava hl.n.':");
			foreach (Spoj item in SpojTable.SelectSeznam("Ostrava hl.n.", db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}
		
		public void DetailSpoje()
		{
			Spoj spoj = SpojTable.SelectDetail(2, db);

			Console.WriteLine(string.Format("4.5. Detail spoje - id '2':\n{0}\nKolekce jizd pro spoj_id '2':", spoj));

			foreach (Jizda item in spoj.Jizdy)
				Console.WriteLine(item.Info);
		}









		// 5. Evidence příjezdů
		public void CreatePrijezd()
		{
			Prijezd prijezd1 = new Prijezd
			{
				StaniceId = 12,
				SpojId = 3,
				Cas = new DateTime(1900, 1, 1, 15, 50, 0),
				Poradi = 5, Vzdalenost = 40
			};

			PrijezdTable.Insert(prijezd1, db);
		}

		public void UdpatePrijezd()
		{
			Prijezd prijezd = PrijezdTable.SelectDetail(12, 3, db);
			prijezd.Vzdalenost = 9999;
			PrijezdTable.Update(prijezd);
		}

		public void DeletePrijezd()
		{
			PrijezdTable.Delete(11, 3, db);
		}

		public void SeznamPrijezdu()
		{
			Console.WriteLine("5.4. Seznam příjezdů - filtrace podle vstupu 'Ostrava-Svinov', '', '14:00', '2020-06-05:");
			foreach (Prijezd item in PrijezdTable.SelectSeznam("Ostrava-Svinov", "", new DateTime(1900, 1, 1, 14, 0, 0), new DateTime(2020, 6, 5), db))
				Console.WriteLine(item.Info);
			Console.WriteLine();
		}

		public void DetailPrijezdu()
		{
			Console.WriteLine(string.Format("5.5. Detail příjezdu - stanice_id '2' a spoj_id '1':\n{0}\n", PrijezdTable.SelectDetail(2, 1, db).Info));
		}









		// 6. Evidence stanic
		public void SeznamStanic()
		{
			Console.WriteLine("6.1. Seznam stanic - filtrace podle vstupu 'Ost':");
			foreach (Stanice item in StaniceTable.SelectSeznam("Ost", db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}

		public void DetailStanice()
		{
			Console.WriteLine(string.Format("6.2. Detail stanice - id '2':\n{0}\n", StaniceTable.SelectDetail(2, db).ToString()));
		}




		
		
		
		
		
		// 7. Evidence měst
		public void SeznamMest()
		{
			Console.WriteLine("7.1.Seznam měst - filtrace podle vstupu 'ha':");
			foreach (Mesto item in MestoTable.SelectSeznam("ha", db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}

		public void DetailMesta()
		{
			Console.WriteLine(string.Format("7.2. Detail města - id 1:\n{0}\n", MestoTable.SelectDetail(1, db).ToString()));
		}




		
		
		
		
		
		// 8. Evidence společností
		public void SeznamSpolecnosti()
		{
			Console.WriteLine("8.1. Seznam společností - podle vstupu 're':");
			foreach (Spolecnost item in SpolecnostTable.SelectSeznam("re", db))
				Console.WriteLine(item.ToString());
			Console.WriteLine();
		}

		public void DetailSpolecnosti()
		{
			Console.WriteLine(string.Format("8.2. Detail společnosti - id '1':\n{0}\n", SpolecnostTable.SelectDetail(1, db).ToString()));
		}
	}
}
