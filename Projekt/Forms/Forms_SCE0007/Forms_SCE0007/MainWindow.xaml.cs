using Forms_SCE0007.Forms;
using Projekt.ORM.DAO;
using System.Windows;

namespace Forms_SCE0007
{
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window
	{
		private readonly Database db;
		private readonly InitScript initScript;
		private readonly int uzivatel_id = 1;

		public MainWindow()
		{
			InitializeComponent();

			db = new Database();
			db.Connect();

			initScript  = new InitScript(db);
			initScript.DbInit();
			initScript.ZapsatJizduDoJizdenky();
		}
		
		private void UserDetail_Click(object sender, RoutedEventArgs e)
		{
			lb_section.Content = "Můj profil:";
			Content.Content = new UserDetail(uzivatel_id, db);
		}

		// 2.4 Vyhledání jízdy
		private void FindConnection_Click(object sender, RoutedEventArgs e)
		{
			lb_section.Content = "Najít spojení:";
			Content.Content = new FindConnection(uzivatel_id, db);
		}

		// 3.3 Seznam jízdenek
		private void MyTickets_Click(object sender, RoutedEventArgs e)
		{
			lb_section.Content = "Moje jízdenky:";
			Content.Content = new MyTickets(uzivatel_id, db);
		}

		private void FindStation_Click(object sender, RoutedEventArgs e)
		{
			lb_section.Content = "Seznam stanic:";
			Content.Content = new FindStation(db);
		}
	}
}
