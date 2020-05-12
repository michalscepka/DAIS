using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;

namespace Forms_SCE0007
{
	/// <summary>
	/// Interaction logic for App.xaml
	/// </summary>
	public partial class App : Application
	{

        protected override void OnExit(ExitEventArgs e)
        {
            if (!(MainWindow is MainWindow window))
                return;

            window.db.Close();
            base.OnExit(e);
        }
    }
}
