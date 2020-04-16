using System.Collections.Generic;

namespace Projekt.ORM
{
	public class Spolecnost
	{
		public int Id { get; set; }
		public string Nazev { get; set; }
		public string Web { get; set; }
		public string Email { get; set; }
		public List<Spoj> Spoje { get; set; } = new List<Spoj>();
	}
}
