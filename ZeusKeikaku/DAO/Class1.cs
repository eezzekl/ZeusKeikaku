using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
using Model.Class;

namespace DAO
{
    public class Class1
    {
        public static List<Album> test()
        {
            using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
            {
                return db.Albums.Where(x => x.AlbumId != 0).ToList();
            }
        }
    }
}
