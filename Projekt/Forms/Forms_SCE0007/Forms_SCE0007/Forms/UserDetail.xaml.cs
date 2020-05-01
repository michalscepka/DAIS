using System;
using System.Collections.Generic;
using System.Diagnostics;
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
using Projekt.ORM;
using Projekt.ORM.DAO;

namespace Forms_SCE0007.Forms
{
	/// <summary>
	/// Interaction logic for UserDetail.xaml
	/// </summary>
	public partial class UserDetail : UserControl
	{
		private Uzivatel uzivatel;
		//TODO odstranit promennou uzivatel_id
		private int uzivatel_id;

		public UserDetail(int uzivatel_id)
		{
			InitializeComponent();
			this.uzivatel_id = uzivatel_id;
			OpenRecord(uzivatel_id);
		}

		public void OpenRecord(int id)
		{
			uzivatel = UzivatelTable.SelectDetail(id);
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
			lb_last_visit.Content = uzivatel.PosledniNavsteva.ToString();
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
			UzivatelTable.Update(uzivatel);
		}

		private void DeleteRecord_Click(object sender, RoutedEventArgs e)
		{
			UzivatelTable.Delete(uzivatel.Id);
			OpenRecord(uzivatel_id);
		}
	}
}
