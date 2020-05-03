using Projekt.ORM.DAO;
using System;
using System.Collections.Generic;
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
	/// Interaction logic for FindArrival.xaml
	/// </summary>
	public partial class FindArrival : UserControl
	{
		public FindArrival()
		{
			InitializeComponent();
		}

		private void ButtonFind_Click(object sender, RoutedEventArgs e)
		{
			// TODO sebrat cas a datum z textboxu
			dataGrid.DataContext = PrijezdTable.SelectSeznam(tb_station.Text, tb_connection.Text, new DateTime(1900, 1, 1, 14, 0, 0), new DateTime(2020, 6, 5));
		}
	}
}
