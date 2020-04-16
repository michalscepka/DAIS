using System.Collections.Generic;

namespace Projekt.ORM
{
	public class Mesto
	{
		public int Id { get; set; }
		public string Nazev { get; set; }
		public string Kraj { get; set; }
		public List<Stanice> Stanice { get; set; } = new List<Stanice>();
	}
}
