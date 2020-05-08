using Projekt.ORM;
using Projekt.ORM.DAO;
using System.Windows;
using System.Windows.Controls;

namespace Forms_SCE0007.Forms
{
	/// <summary>
	/// Interaction logic for UserDetail.xaml
	/// </summary>
	public partial class UserDetail : UserControl
	{
		private readonly Database db;
		private Uzivatel uzivatel;		

		public UserDetail(int uzivatel_id, Database database)
		{
			InitializeComponent();

			this.db = database;
			OpenRecord(uzivatel_id);
		}

		public void OpenRecord(int id)
		{
			uzivatel = UzivatelTable.SelectDetail(id, db);
			BindData();
		}

		private void BindData()
		{
			tb_login.Text = uzivatel.Login;
			tb_fname.Text = uzivatel.Jmeno;
			tb_lname.Text = uzivatel.Prijmeni;
			tb_email.Text = uzivatel.Email;
			switch(uzivatel.Typ)
			{
				case "zakaznik":
					cb_typ.SelectedIndex = 0;
					break;
				case "vlakova spolecnost":
					cb_typ.SelectedIndex = 1;
					break;
				case "spravce drah":
					cb_typ.SelectedIndex = 2;
					break;
			}
			lb_last_visit.Content = uzivatel.PosledniNavsteva.HasValue ? uzivatel.PosledniNavsteva.ToString() : "N/A";
			cb_active.IsChecked = uzivatel.Aktivni;
		}

        private void GetData()
        {
            uzivatel.Login = tb_login.Text;
            uzivatel.Jmeno = tb_fname.Text;
            uzivatel.Prijmeni = tb_lname.Text;
            uzivatel.Email = tb_email.Text;
			switch (cb_typ.SelectedIndex)
			{
				case 0:
					uzivatel.Typ = "zakaznik";
					break;
				case 1:
					uzivatel.Typ = "vlakova spolecnost";
					break;
				case 2:
					uzivatel.Typ = "spravce drah";
					break;
			}
			uzivatel.Aktivni = cb_active.IsChecked ?? false;
        }

		private void SaveRecord_Click(object sender, RoutedEventArgs e)
		{
			GetData();
			UzivatelTable.Update(uzivatel, db);
		}

		private void DeleteRecord_Click(object sender, RoutedEventArgs e)
		{
			UzivatelTable.Delete(uzivatel.Id, db);
			OpenRecord(uzivatel.Id);
		}
	}
}
