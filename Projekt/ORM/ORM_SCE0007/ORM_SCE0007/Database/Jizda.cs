using System;

namespace Projekt.ORM
{
	public class Jizda
	{
		public int Id { get; set; }
		public DateTime DatumStart { get; set; }
		public DateTime DatumCil { get; set; }
		public int SpojId { get; set; }
		public Spoj Spoj { get; set; }

		//Artificial columns (physically not in the database)
		public string Info { get { return string.Format("Jizda {0} na spoji '{1}' DatumStart '{2}', DatumCil '{3}'", Id, Spoj.Nazev, DatumStart, DatumCil); } }

		public override string ToString()
		{
			return string.Format("Jizda {0}: Datum start: {1}, Datum cil: {2}; {3}", 
				Id, DatumStart.ToString("dd.MM.yyyy"), DatumCil.ToString("dd.MM.yyyy"), Spoj.ToString());
		}
	}
}
