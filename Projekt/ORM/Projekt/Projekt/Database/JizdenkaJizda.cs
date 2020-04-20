namespace Projekt.ORM
{
	public class JizdenkaJizda
	{
		public int JizdenkaId { get; set; }
		public int JizdaId { get; set; }
		public int StaniceIdStart { get; set; }
		public int StaniceIdCil { get; set; }
		public int Poradi { get; set; }

		public override string ToString()
		{
			return string.Format("JizdenkaJizda JizdenkaId: {0}, JizdaId: {1}, StaniceIdStart: {2}, StaniceIdCil: {3}, Poradi: {4}",
				JizdenkaId, JizdaId, StaniceIdStart, StaniceIdCil, Poradi);
		}
	}
}
