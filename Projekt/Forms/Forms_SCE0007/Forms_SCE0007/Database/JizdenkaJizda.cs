namespace Projekt.ORM
{
	public class JizdenkaJizda
	{
		public int JizdenkaId { get; set; }
		public Jizdenka Jizdenka { get; set; }
		public int JizdaId { get; set; }
		public Jizda Jizda { get; set; }
		public int StaniceIdStart { get; set; }
		public Stanice StaniceStart { get; set; }
		public int StaniceIdCil { get; set; }
		public Stanice StaniceCil { get; set; }
		public int Poradi { get; set; }

		//Artificial columns (physically not in the database)
		public string Info { get { return string.Format("Jizdenka '{0}' uzivatele '{1}'; cena '{2} Kc'; datum '{3}'; spoj '{4}' '{5}'; z '{6}' do '{7}'", 
			Jizdenka.Id, Jizdenka.Uzivatel.FullName, Jizdenka.Cena, Jizda.DatumStart.ToString("dd.MM.yyyy"), Jizda.Spoj.Nazev, Jizda.Spoj.Spolecnost.Nazev, StaniceStart.Nazev, StaniceCil.Nazev); } }

		public override string ToString()
		{
			return string.Format("JizdenkaJizda JizdenkaId: {0}, JizdaId: {1}, StaniceIdStart: {2}, StaniceIdCil: {3}, Poradi: {4}; {5}; {6}; {7}; {8}",
				JizdenkaId, JizdaId, StaniceIdStart, StaniceIdCil, Poradi, Jizdenka.ToString(), Jizda.ToString(), StaniceStart.ToString(), StaniceCil.ToString());
		}
	}
}
