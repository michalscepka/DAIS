using Forms_SCE0007.Forms;
using Projekt.ORM.DAO;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Forms_SCE0007
{
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window
	{
		private readonly Database db;
		private readonly TestScript testScript;
		private int uzivatel_id = 1;

		public MainWindow()
		{
			InitializeComponent();
			CultureInfo.CurrentCulture = new CultureInfo("cs-CZ");

			db = new Database();
			db.Connect();

			testScript  = new TestScript(db);
			testScript.DbInit();

			InsertData();
		}
		
		private void UserDetail_Click(object sender, RoutedEventArgs e)
		{
			Content.Content = new UserDetail(uzivatel_id);
		}

		private void FindConnection_Click(object sender, RoutedEventArgs e)
		{
			Content.Content = new FindConnection();
		}

		private void MyTickets_Click(object sender, RoutedEventArgs e)
		{
			Content.Content = new MyTickets(uzivatel_id);
		}

		private void FindTrain_Click(object sender, RoutedEventArgs e)
		{
			Content.Content = new FindTrain();
		}

		private void InsertData()
		{
			testScript.CreateUzivatel();
			testScript.CreateJizda();
			testScript.CreateJizdenka();
			testScript.ZapsatJizduDoJizdenky();
			testScript.CreateSpoj();
			testScript.CreatePrijezd();
		}
	}
}
