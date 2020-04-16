using System;
using System.Collections.Generic;

namespace Projekt.ORM
{
	public class Jizda
	{
		public int Id { get; set; }
		public DateTime DatumStart { get; set; }
		public DateTime DatumCil { get; set; }
		public List<JizdenkaJizda> Jizdenky { get; set; } = new List<JizdenkaJizda>();
	}
}
