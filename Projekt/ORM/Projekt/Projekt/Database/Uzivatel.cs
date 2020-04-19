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

		//Artificial columns (physically not in the database)
		public string FullName { get { return Jmeno + " " + Prijmeni; } }

		public override string ToString()
		{
			return string.Format("Uzivatel {0}: {1}, {2}, {3}, {4}, PosledniNavsteva: {5}, Aktivni: {6}", Id, Login, FullName, Email, Typ, PosledniNavsteva, Aktivni);
		}
	}
}
