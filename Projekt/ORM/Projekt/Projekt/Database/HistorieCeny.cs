using System;

namespace Projekt.ORM
{
	public class HistorieCeny
	{
		public int Id { get; set; }
		public int Cena { get; set; }
		public DateTime Datum { get; set; }
		public int SpojID { get; set; }
		public Spoj Spoj { get; set; }

		public override string ToString()
		{
			return string.Format("HistorieCeny: Cena: {0} Kc/km, Datum: {1}, {2}", Cena, Datum.ToString("dd.MM.yyyy"), Spoj.ToString());
		}
	}
}
