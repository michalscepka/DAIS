using Projekt.ORM.DAO;
using System;
using System.Data.SqlClient;
using System.IO;
using System.Text;

namespace Forms_SCE0007
{
	class InitScript
    {
		public Database db;

		public InitScript(Database database)
		{
			this.db = database;
		}

		private string ReadSqlFile(string path)
		{
			StringBuilder fileString = new StringBuilder();

			try
			{
				using (StreamReader sr = new StreamReader(path))
				{
					string tmp;
					while ((tmp = sr.ReadLine()) != null)
					{
						fileString.Append(tmp + "\n");
					}
				}
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}

			return fileString.ToString();
		}

		public void DbInit()
		{
			DirectoryInfo dicDirectoryInfo = Directory.GetParent(AppDomain.CurrentDomain.BaseDirectory).Parent.Parent.Parent.Parent;
			string delete_sql = ReadSqlFile(dicDirectoryInfo.FullName + "\\" + "SQLs" + "\\" + "delete.sql");
			string create_sql = ReadSqlFile(dicDirectoryInfo.FullName + "\\" + "SQLs" + "\\" + "create.sql");
			string data_sql = ReadSqlFile(dicDirectoryInfo.FullName + "\\" + "SQLs" + "\\" + "data.sql");

			try
			{
				SqlCommand command = db.CreateCommand(delete_sql);
				int status = db.ExecuteNonQuery(command);
			}
			catch (Exception) { }

			try
			{
				SqlCommand command = db.CreateCommand(create_sql);
				int status = db.ExecuteNonQuery(command);
			}
			catch (Exception) { }

			try
			{
				SqlCommand command = db.CreateCommand(data_sql);
				int status = db.ExecuteNonQuery(command);
			}
			catch (Exception) { }
		}

		public void ZapsatJizduDoJizdenky()
		{
			JizdenkaTable.ZapsatJizdu(1, 1, 1, 5);
			JizdenkaTable.ZapsatJizdu(1, 2, 5, 8);

			JizdenkaTable.ZapsatJizdu(2, 1, 2, 5);

			JizdenkaTable.ZapsatJizdu(3, 1, 2, 5);
			JizdenkaTable.ZapsatJizdu(3, 2, 5, 7);
		}
	}
}
