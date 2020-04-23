﻿using System;

namespace Projekt.ORM
{
	public class Jizda
	{
		public int Id { get; set; }
		public DateTime DatumStart { get; set; }
		public DateTime DatumCil { get; set; }
		public int SpojId { get; set; }
		public Spoj Spoj { get; set; }

		public override string ToString()
		{
			return string.Format("Jizda {0}: Datum start: {1}, Datum cil: {2}; {3}", 
				Id, DatumStart.ToString("dd.MM.yyyy"), DatumCil.ToString("dd.MM.yyyy"), Spoj.ToString());
		}
	}
}
