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
	/// Interaction logic for FindStation.xaml
	/// </summary>
	public partial class FindStation : UserControl
	{
		public FindStation()
		{
			InitializeComponent();
		}

		private void ButtonFind_Click(object sender, RoutedEventArgs e)
		{
			dataGrid.DataContext = StaniceTable.SelectSeznam(tb_input.Text);
		}
	}
}
