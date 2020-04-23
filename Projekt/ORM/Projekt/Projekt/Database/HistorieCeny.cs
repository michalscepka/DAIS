using System;

namespace Projekt.ORM
{
	public class HistorieCeny
	{
		public int Id { get; set; }
		public int Cena { get; set; }
		public DateTime Datum { get; set; }
		public int SpojId { get; set; }
		public Spoj Spoj { get; set; }

		public override string ToString()
		{
			return string.Format("HistorieCeny {0}: Cena: {1} Kc/km, Datum: {2}; {3}", Id, Cena, Datum.ToString("dd.MM.yyyy"), Spoj.ToString());
		}
	}
}
