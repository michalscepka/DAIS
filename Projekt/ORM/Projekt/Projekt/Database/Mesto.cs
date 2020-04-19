using System.Collections.Generic;

namespace Projekt.ORM
{
	public class Mesto
	{
		public int Id { get; set; }
		public string Nazev { get; set; }
		public string Kraj { get; set; }

		public override string ToString()
		{
			return string.Format("Mesto {0}: {1}, {2}", Id, Nazev, Kraj);
		}
	}
}
