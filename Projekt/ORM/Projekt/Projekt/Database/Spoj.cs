using System.Collections.Generic;

namespace Projekt.ORM
{
	public class Spoj
	{
		public int Id { get; set; }
		public string Nazev { get; set; }
		public int CenaZaKm { get; set; }
		public int KapacitaMist { get; set; }
		public bool Pravidelny { get; set; }
		public Spolecnost Spolecnost { get; set; }
		public bool Aktivni { get; set; }
		public List<HistorieCeny> HistorieCeny { get; set; } = new List<HistorieCeny>();
		public List<Jizda> Jizdy { get; set; } = new List<Jizda>();
		public List<Prijezd> Prijezdy { get; set; } = new List<Prijezd>();
	}
}
