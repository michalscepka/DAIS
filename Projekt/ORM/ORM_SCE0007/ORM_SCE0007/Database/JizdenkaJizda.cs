namespace Projekt.ORM
{
	public class JizdenkaJizda
	{
		public int JizdenkaId { get; set; }
		public Jizdenka Jizdenka { get; set; }
		public int JizdaId { get; set; }
		public Jizda Jizda { get; set; }
		public int StaniceIdStart { get; set; }
		public Stanice StaniceStart { get; set; }
		public int StaniceIdCil { get; set; }
		public Stanice StaniceCil { get; set; }
		public int Poradi { get; set; }

		public override string ToString()
		{
			return string.Format("JizdenkaJizda JizdenkaId: {0}, JizdaId: {1}, StaniceIdStart: {2}, StaniceIdCil: {3}, Poradi: {4}; {5}; {6}; {7}; {8}",
				JizdenkaId, JizdaId, StaniceIdStart, StaniceIdCil, Poradi, Jizdenka.ToString(), Jizda.ToString(), StaniceStart.ToString(), StaniceCil.ToString());
		}
	}
}
