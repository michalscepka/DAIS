namespace Projekt.ORM
{
	public class NalezenaJizda
	{
		public string StartStanice { get; set; }
		public string PrestupStanice { get; set; }
		public string CilStanice { get; set; }
		public string Datum { get; set; }
		public string CasOdjezdu { get; set; }
		public string CasPrijezdu { get; set; }
		public string Spoj1 { get; set; }
		public string Spoj2 { get; set; }

		public override string ToString()
		{
			return string.Format("{0}, {1}, {2}, {3}, {4}", Spoj1, PrestupStanice, Spoj2, CasOdjezdu, CasPrijezdu);
		}
	}
}
