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
	/// Interaction logic for FindTrain.xaml
	/// </summary>
	public partial class FindTrain : UserControl
	{
		public FindTrain()
		{
			InitializeComponent();
		}

		private void ButtonFind_Click(object sender, RoutedEventArgs e)
		{
			dataGrid.DataContext = SpojTable.SelectSeznam(tb_input.Text);
		}
	}
}
