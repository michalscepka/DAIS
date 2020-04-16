using System;

namespace Projekt.ORM
{
	public class Prijezd
	{
		public int StaniceId { get; set; }
		public int SpojId { get; set; }
		public DateTime Cas { get; set; }
		public int Poradi { get; set; }
		public int Vzdalenost { get; set; }
	}
}
