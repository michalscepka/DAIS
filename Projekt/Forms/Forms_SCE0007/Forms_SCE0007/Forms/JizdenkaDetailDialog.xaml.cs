using Projekt.ORM;
using Projekt.ORM.DAO;
using System;
using System.Collections.ObjectModel;
using System.Windows;

namespace Forms_SCE0007.Forms
{
	/// <summary>
	/// Interaction logic for JizdenkaDetail.xaml
	/// </summary>
	public partial class JizdenkaDetailDialog : Window
	{
		private readonly Database db;
		private readonly Collection<JizdenkaJizda> jizdenka;
		private readonly MyTickets myTickets;

		public JizdenkaDetailDialog(Collection<JizdenkaJizda> jizdenka, MyTickets myTickets, Database database)
		{
			InitializeComponent();

			this.db = database;

			this.jizdenka = jizdenka;
			this.myTickets = myTickets;

			tb_spoj1.Text = jizdenka[0].Jizda.Spoj.Nazev;
			tb_from1.Text = jizdenka[0].StaniceStart.Nazev;
			tb_to1.Text = jizdenka[0].StaniceCil.Nazev;
			tb_datum1.Text = jizdenka[0].Jizda.DatumStart.ToString();
			tb_spolecnost1.Text = jizdenka[0].Jizda.Spoj.Spolecnost.Nazev;

			if(jizdenka.Count > 1)
			{
				tb_spoj2.Text = jizdenka[1].Jizda.Spoj.Nazev;
				tb_from2.Text = jizdenka[1].StaniceStart.Nazev;
				tb_to2.Text = jizdenka[1].StaniceCil.Nazev;
				tb_datum2.Text = jizdenka[1].Jizda.DatumStart.ToString();
				tb_spolecnost2.Text = jizdenka[1].Jizda.Spoj.Spolecnost.Nazev;
			}

			tb_cena.Text = jizdenka[0].Jizdenka.Cena.ToString();
		}

		private void DeleteRecord_Click(object sender, RoutedEventArgs e)
		{
			try
			{
				JizdenkaTable.Delete(jizdenka[0].JizdenkaId, db);
			}
			catch (Exception exception)
			{
				MessageBox.Show(exception.Message, "Varování", MessageBoxButton.OK, MessageBoxImage.Warning);
				return;
			}
			myTickets.OpenRecords(jizdenka[0].Jizdenka.Uzivatel.Id);
			this.Close();
		}
	}
}
