using System.Collections.Generic;

namespace Projekt.ORM
{
	public class Jizdenka
	{
		public int Id { get; set; }
		public int UzivatelId { get; set; }
		public Uzivatel Uzivatel { get; set; }
		public int Cena { get; set; }

		public List<JizdenkaJizda> Jizdy { get; set; } = new List<JizdenkaJizda>();

		public override string ToString()
		{
			return string.Format("Jizdenka {0}: Uzivatel: {1}, Cena: {2}", Id, UzivatelId, Cena);
		}
	}
}
