using System.Collections.Generic;

namespace Projekt.ORM
{
	public class Jizdenka
	{
		public int Id { get; set; }
		public int Cena { get; set; }
		public List<JizdenkaJizda> Jizdy { get; set; } = new List<JizdenkaJizda>();
	}
}
