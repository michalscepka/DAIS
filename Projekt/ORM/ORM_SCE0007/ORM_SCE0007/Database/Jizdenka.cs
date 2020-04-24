
using System.Collections.ObjectModel;

namespace Projekt.ORM
{
	public class Jizdenka
	{
		public int Id { get; set; }
		public int UzivatelId { get; set; }
		public Uzivatel Uzivatel { get; set; }
		public int Cena { get; set; }
		
		public override string ToString()
		{
			return string.Format("Jizdenka {0}: Cena: {1}; {2}", Id, Cena, Uzivatel.ToString());
		}
	}
}
