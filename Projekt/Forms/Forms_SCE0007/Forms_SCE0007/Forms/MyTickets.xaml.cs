using Projekt.ORM;
using Projekt.ORM.DAO;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;

namespace Forms_SCE0007.Forms
{
	/// <summary>
	/// Interaction logic for MyTickets.xaml
	/// </summary>
	public partial class MyTickets : UserControl
	{
		private readonly Database db;
		private readonly int uzivatel_id;
		private Collection<JizdenkaJizda> jizdenky;

		public MyTickets(int uzivatel_id, Database database)
		{
			InitializeComponent();

			this.db = database;
			this.uzivatel_id = uzivatel_id;
			OpenRecords(uzivatel_id);
		}

		public void OpenRecords(int id)
		{
			jizdenky = JizdenkaTable.SelectSeznam(id, db);
			BindData();
		}

		private void BindData()
		{
			dataGrid.Items.Clear();
			foreach(JizdenkaJizda item in jizdenky)
				if(item.Poradi == 1)
					dataGrid.Items.Add(item);
		}

		private void DeleteRecord_Click(object sender, RoutedEventArgs e)
		{
			if (dataGrid.SelectedItem != null)
				JizdenkaTable.Delete((dataGrid.SelectedItem as JizdenkaJizda).JizdenkaId, db);
			OpenRecords(uzivatel_id);
		}

		private void Detail_Click(object sender, RoutedEventArgs e)
		{
			Collection<JizdenkaJizda> jizdenka = new Collection<JizdenkaJizda>();

			foreach(JizdenkaJizda item in jizdenky)
			{
				if (item.JizdenkaId == (dataGrid.SelectedItem as JizdenkaJizda).JizdenkaId)
					jizdenka.Add(item);
			}

			if (dataGrid.SelectedItem != null)
			{
				Window window = new JizdenkaDetailDialog(jizdenka, this, db);
				window.ShowDialog();
			}
		}
	}
}
