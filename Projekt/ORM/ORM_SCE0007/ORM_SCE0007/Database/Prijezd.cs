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

		//Artificial columns (physically not in the database)
		public string Info { get { return string.Format("Prijezd: na stanici '{0}' ve meste '{1}', pro spoj '{2}' od spolecnosti '{3}'", 
			Stanice.Nazev, Stanice.Mesto.Nazev, Spoj.Nazev, Spoj.Spolecnost.Nazev); } }

		public override string ToString()
		{
			return string.Format("Prijezd StaniceId: {0}, SpojId: {1}, Cas: {2}, Poradi: {3}, Vzdalenost: {4}; {5}; {6}", 
				StaniceId, SpojId, Cas.ToString("HH:mm:ss.f"), Poradi, Vzdalenost, Stanice.ToString(), Spoj.ToString());
		}
	}
}
