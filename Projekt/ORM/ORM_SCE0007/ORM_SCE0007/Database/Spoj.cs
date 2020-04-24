namespace Projekt.ORM
{
	public class Spoj
	{
		public int Id { get; set; }
		public string Nazev { get; set; }
		public int CenaZaKm { get; set; }
		public int KapacitaMist { get; set; }
		public bool Pravidelny { get; set; }
		public int SpolecnostId { get; set; }
		public Spolecnost Spolecnost { get; set; }
		public bool Aktivni { get; set; }

		public override string ToString()
		{
			return string.Format("Spoj {0}: {1}, {2} Kc/km, Kapacita: {3}, Pravidelny: {4}, Aktivni: {5}; {6}", 
				Id, Nazev, CenaZaKm, KapacitaMist, Pravidelny, Aktivni, Spolecnost.ToString());
		}
	}
}
