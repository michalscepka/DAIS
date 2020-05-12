using Projekt.ORM;
using Projekt.ORM.DAO;
using System;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;

namespace Forms_SCE0007.Forms
{
	/// <summary>
	/// Interaction logic for FindConnection.xaml
	/// </summary>
	public partial class FindConnection : UserControl
	{
		private readonly Database db;
		private readonly int uzivatel_id;
		Collection<int?[]> NalezeneJizdyIDs;

		public FindConnection(int uzivatel_id, Database database)
		{
			InitializeComponent();

			this.db = database;
			this.uzivatel_id = uzivatel_id;
		}

		private void Find_Click(object sender, RoutedEventArgs e)
		{
			NalezeneJizdyIDs = JizdaTable.NajitJizdu(
				cb_start.SelectedIndex + 1,
				cb_cil.SelectedIndex + 1,
				datepicker.SelectedDate ?? new DateTime(2020, 6, 5),
				new DateTime(1900, 1, 1, int.Parse(cb_hh.Text), int.Parse(cb_mm.Text), 0),
				db);

			Collection<NalezenaJizda> nalezeneJizdy = new Collection<NalezenaJizda>();

			info.Content = string.Empty;

			if (NalezeneJizdyIDs.Count > 0)
			{
				for (int i = 0; i < NalezeneJizdyIDs.Count; i++)
				{
					NalezenaJizda nalezenaJizda = JizdaTable.ZjistiData(
						NalezeneJizdyIDs[i][0] ?? 0,
						NalezeneJizdyIDs[i][1] ?? 0,
						NalezeneJizdyIDs[i][2] ?? 0,
						cb_start.SelectedIndex + 1,
						cb_cil.SelectedIndex + 1,
						db);

					nalezenaJizda.StartStanice = cb_start.Text;
					nalezenaJizda.CilStanice = cb_cil.Text;
					nalezenaJizda.Datum = datepicker.SelectedDate.HasValue ? datepicker.SelectedDate.Value.ToString("dd.MM.yyyy") : string.Empty;

					nalezeneJizdy.Add(nalezenaJizda);
				}
			}
			else
			{
				info.Content = "Pro zadané data nejsou nalezeny žádné jízdy.";
			}

			dataGrid.Items.Clear();
			foreach (NalezenaJizda item in nalezeneJizdy)
				dataGrid.Items.Add(item);
		}

		private void Buy_Click(object sender, RoutedEventArgs e)
		{
			if (dataGrid.SelectedItem != null)
			{
				Jizdenka jizdenka = new Jizdenka { UzivatelId = uzivatel_id, Cena = 0 };
				jizdenka.Id = JizdenkaTable.Insert(jizdenka, db);

				if (NalezeneJizdyIDs[dataGrid.SelectedIndex][1] != null)
				{
					try
					{
						JizdenkaTable.ZapsatJizdu(
							jizdenka.Id,
							NalezeneJizdyIDs[dataGrid.SelectedIndex][0] ?? 0,
							cb_start.SelectedIndex + 1,
							NalezeneJizdyIDs[dataGrid.SelectedIndex][1] ?? 0,
							db);
						JizdenkaTable.ZapsatJizdu(
							jizdenka.Id,
							NalezeneJizdyIDs[dataGrid.SelectedIndex][2] ?? 0,
							NalezeneJizdyIDs[dataGrid.SelectedIndex][1] ?? 0,
							cb_cil.SelectedIndex + 1,
							db);
					}
					catch (Exception exception)
					{
						info.Content = exception.Message;
						return;
					}
				}
				else
				{
					try
					{
						JizdenkaTable.ZapsatJizdu(
						jizdenka.Id,
						NalezeneJizdyIDs[dataGrid.SelectedIndex][0] ?? 0,
						cb_start.SelectedIndex + 1,
						cb_cil.SelectedIndex + 1,
						db);
					}
					catch (Exception exception)
					{
						info.Content = exception.Message;
						return;
					}
				}

				info.Content = string.Format("Jizdenka Id {0} koupena.", jizdenka.Id);
			}
			else
			{
				info.Content = "Vyberte jízdu, kterou si chcete koupit.";
			}
		}
	}
}
