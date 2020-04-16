using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Projekt.ORM
{
    public class User
    {
        public int Id { get; set; }
        public String Login { get; set; }
        public String Name { get; set; }
        public String Surname { get; set; }
        public String Address { get; set; }
        public String Telephone { get; set; }
        public int MaximumUnfinisfedAuctions { get; set; }
        public DateTime? LastVisit { get; set; }
        public String Type { get; set; }

        //Artificial columns (physically not in the database)
        public String FullName { get { return this.Name + " " + this.Surname; } }
    }
}
