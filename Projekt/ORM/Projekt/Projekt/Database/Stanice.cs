using System.Collections.Generic;

namespace Projekt.ORM
{
	public class Stanice
	{
		public int Id { get; set; }
		public string Nazev { get; set; }
		public int MestoId { get; set; }
		public Mesto Mesto { get; set; }

		public List<Prijezd> Prijezdy { get; set; } = new List<Prijezd>();

		public override string ToString()
		{
			return string.Format("Stanice {0}: {1}, {2}", Id, Nazev, MestoId);
		}
	}
}
