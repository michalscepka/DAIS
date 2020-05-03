using Projekt.ORM;
using Projekt.ORM.DAO;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Forms_SCE0007.Forms
{
	/// <summary>
	/// Interaction logic for FindConnection.xaml
	/// </summary>
	public partial class FindConnection : UserControl
	{
		private int uzivatel_id;

		public FindConnection(int uzivatel_id)
		{
			InitializeComponent();
			this.uzivatel_id = uzivatel_id;
		}

		private void Find_Click(object sender, RoutedEventArgs e)
		{
			Collection<int?[]> connections = JizdaTable.NajitJizdu(int.Parse(tb_from.Text), int.Parse(tb_to.Text), new DateTime(2020, 6, 5), new DateTime(1900, 1, 1, 13, 0, 0));

			dataGrid.ItemsSource = connections;
		}

		private void Buy_Click(object sender, RoutedEventArgs e)
		{
			if (dataGrid.SelectedItem != null)
			{
				Jizdenka jizdenka = new Jizdenka { UzivatelId = uzivatel_id, Cena = 0 };
				JizdenkaTable.Insert(jizdenka);

				int?[] naleneze_spoje = (int?[])dataGrid.SelectedItem;

				int jizdenka_id = JizdenkaTable.SelectSeznam(uzivatel_id)[^1].Jizdenka.Id;

				JizdenkaTable.ZapsatJizdu(jizdenka_id, naleneze_spoje[0] ?? 0, int.Parse(tb_from.Text), naleneze_spoje[1] ?? 0);
				JizdenkaTable.ZapsatJizdu(jizdenka_id, naleneze_spoje[2] ?? 0, naleneze_spoje[1] ?? 0, int.Parse(tb_to.Text));

				info.Content = string.Format("Jizdenka Id {0} koupena", jizdenka_id);
			}
		}
	}
}
