using Projekt.ORM.DAO;
using System.Windows;
using System.Windows.Controls;

namespace Forms_SCE0007.Forms
{
	/// <summary>
	/// Interaction logic for FindStation.xaml
	/// </summary>
	public partial class FindStation : UserControl
	{
		private readonly Database db;

		public FindStation(Database database)
		{
			InitializeComponent();

			this.db = database;
		}

		private void ButtonFind_Click(object sender, RoutedEventArgs e)
		{
			dataGrid.DataContext = StaniceTable.SelectSeznam(tb_input.Text, db);
		}
	}
}
