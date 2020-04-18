using System;

namespace Projekt.ORM
{
	public class Prijezd
	{
		public int StaniceId { get; set; }
		public Stanice Stanice { get; set; }
		public int SpojId { get; set; }
		public Spoj Spoj { get; set; }
		public DateTime Cas { get; set; }
		public int Poradi { get; set; }
		public int Vzdalenost { get; set; }

		public override string ToString()
		{
			return string.Format("Prijezd StaniceId: {0}, SpojId: {1}, Cas: {2}, Poradi: {3}, Vzdalenost: {4}", 
				StaniceId, SpojId, Cas.ToString("HH:mm:ss.f"), Poradi, Vzdalenost);
		}
	}
}
