﻿using System.Collections.Generic;

namespace Projekt.ORM
{
	public class Spolecnost
	{
		public int Id { get; set; }
		public string Nazev { get; set; }
		public string Web { get; set; }
		public string Email { get; set; }

		public List<Spoj> Spoje { get; set; } = new List<Spoj>();	// TODO

		public override string ToString()
		{
			return string.Format("Spolecnost {0}: {1}, {2}, {3}", Id, Nazev, Web, Email);
		}
	}
}
