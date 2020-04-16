using System;
using System.Collections.Generic;

namespace Projekt.ORM
{
	public class Uzivatel
	{
		public int Id { get; set; }
		public string Login { get; set; }
		public string Jmeno { get; set; }
		public string Prijmeni { get; set; }
		public string Email { get; set; }
		public string Typ { get; set; }
		public DateTime? PosledniNavsteva { get; set; }
		public bool Aktivni { get; set; }
		public List<Jizdenka> Jizdenky { get; set; } = new List<Jizdenka>();

		//Artificial columns (physically not in the database)
		public string FullName { get { return Jmeno + " " + Prijmeni; } }
	}
}
