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
	/// Interaction logic for MyTickets.xaml
	/// </summary>
	public partial class MyTickets : UserControl
	{
		private int uzivatel_id;
		private Collection<JizdenkaJizda> jizdenky;

		public MyTickets(int uzivatel_id)
		{
			InitializeComponent();
			this.uzivatel_id = uzivatel_id;
			OpenRecords(uzivatel_id);
		}

		public void OpenRecords(int id)
		{
			jizdenky = JizdenkaTable.SelectSeznam(id);
			BindData();
		}

		private void BindData()
		{
			dataGrid.DataContext = jizdenky;
		}

		private void Detail_Click(object sender, RoutedEventArgs e)
		{
			// TODO
			if (dataGrid.SelectedItem != null)
			{
				JizdenkaJizda jizdenkaJizda = (JizdenkaJizda)dataGrid.SelectedItem;
			}
		}

		private void Storno_Click(object sender, RoutedEventArgs e)
		{
			if (dataGrid.SelectedItem != null)
			{
				JizdenkaJizda jizdenkaJizda = (JizdenkaJizda)dataGrid.SelectedItem;
				JizdenkaTable.Delete(jizdenkaJizda.JizdenkaId);
			}
			OpenRecords(uzivatel_id);
		}
	}
}
