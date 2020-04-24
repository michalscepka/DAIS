using System;
using Projekt.ORM.DAO;

namespace Projekt
{
	class Program
	{
		static void Main(string[] args)
		{
            Database db = new Database();
            db.Connect();

            TestScript testScript = new TestScript(db);

            testScript.DbInit();

            Print("1. Evidence uživatelů");

            // 1.1. Zaregistrování nového uživatele
            testScript.CreateUzivatel();
            // 1.2. Aktualizování uživatele
            testScript.UpdateUzivatel();
            // 1.3. Zrušení uživatele – nastavení hodnoty atributu Uzivatel.aktivni = 0
            testScript.DeleteUzivatel();
            // 1.4. Seznam uživatelů – filtrace podle jména
            testScript.SeznamUzivatelu();
            // 1.5. Detail uživatele
            testScript.DetailUzivatele();

            Print("2. Evidence jízd");

            // 2.1. Vytvoření nové jízdy
            testScript.CreateJizda();
            // 2.2. Aktualizování jízdy – aktualizovat je možné jen jízdu, která ještě nezačala
            testScript.UpdateJizda();
            // 2.3. Zrušení jízdy – kaskádové mazání pro zrušení jízdy a všech podřízených záznamů
            testScript.DeleteJizda();
            // 2.4. Vyhledání jízdy – dle startovní/cílové stanice, času odjezdu a s jedním nebo žádným přestupem
            testScript.VyhledaniJizdy();
            // 2.5. Detail jízdy
            testScript.DetailJizdy();
            // 2.6. Vypočítání ceny jízdy – podle délky trasy
            testScript.VypocitatCenuJizdy();

            Print("3. Evidence jízdenek");

            // 3.1. Vytvoření jízdenky
            testScript.CreateJizdenka();
            // 3.2. Zapsání jízdy do jízdenky – uživatel si nemůže objednat jízdu do plného vlaku
            testScript.ZapsatJizduDoJizdenky();
            // 3.3. Zrušení jízdenky – uživatel nemůže zrušit jízdenku, pokud zbývá méně než 15 minut do odjezdu
            testScript.DeleteJizdenka();
            // 3.4. Seznam jízdenek – zobrazí jízdenky patřící konkrétnímu uživateli
            testScript.SeznamJizdenek();
            // 3.5. Detail jízdenky
            testScript.DetailJizdenky();

            Print("4. Evidence spojů");

            // 4.1. Vytvoření nového spoje
            testScript.CreateSpoj();
            // 4.2. Aktualizování spoje – zapsání původní ceny do tabulky Historie_ceny
            testScript.UpdateSpoj();
            // 4.3. Zrušení spoje - nastavení hodnoty atributu Spoj.aktivni = 0
            testScript.DeleteSpoj();
            // 4.4. Seznam spojů – filtrace dle stanic kterými spoje projíždí
            testScript.SeznamSpoju();
            // 4.5. Detail spoje
            testScript.DetailSpoje();

            Print("5. Evidence příjezdů");

            // 5.1. Vytvoření nového příjezdu
            testScript.CreatePrijezd();
            // 5.2. Aktualizování příjezdu
            testScript.UdpatePrijezd();
            // 5.3. Zrušení příjezdu
            testScript.DeletePrijezd();
            // 5.4. Seznam příjezdů – filtrace podle stanice, spoje nebo data a času příjezdu
            testScript.SeznamPrijezdu();
            // 5.5. Detail příjezdu
            testScript.DetailPrijezdu();

            Print("6. Evidence stanic");

            // 6.1. Seznam stanic – filtrace podle názvu stanice
            testScript.SeznamStanic();
            // 6.2. Detail stanice
            testScript.DetailStanice();

            Print("7. Evidence měst");

            // 7.1.Seznam měst – filtrace podle názvu města
            testScript.SeznamMest();
            // 7.2. Detail města
            testScript.DetailMesta();

            Print("8. Evidence společností");

            // 8.1. Seznam společností – filtrace podle názvu společností
            testScript.SeznamSpolecnosti();
            // 8.2. Detail společnosti
            testScript.DetailSpolecnosti();

            db.Close();
        }

        private static void Print(string category)
        {
            string oddelovac = "-------------------------------------------------------------------------------------";
            Console.WriteLine(oddelovac + '\n' + category + '\n' + oddelovac + '\n');
        }
	}
}
