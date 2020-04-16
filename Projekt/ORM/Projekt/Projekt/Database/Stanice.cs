using System.Collections.Generic;

namespace Projekt.ORM
{
	public class Stanice
	{
		public int Id { get; set; }
		public string Nazev { get; set; }
		public List<Prijezd> Prijezdy { get; set; } = new List<Prijezd>();
	}
}
