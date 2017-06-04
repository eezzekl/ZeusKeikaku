using System.Collections.Generic;
using System.Linq;
using Model;
using Model.Classes;
using System.Data.Entity.Core;
using System;

namespace DAO
{
    public class AlbumTagDAO
    {
        public static int Save(AlbumTag item)
        {
            try
            {
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    db.AlbumTag.Add(item);
                    return db.SaveChanges();
                }

            }
            catch(EntityException e)
            {
                throw e;
            }
        }

        public static List<AlbumTag> ListByAlbum(int idAlbum)
        {
            using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
            {
                return db.AlbumTag.Include("Tag").Where(x => x.AlbumId == idAlbum).ToList();
            }
        }

        public static AlbumTag Get(AlbumTag item)
        {
            try
            {
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    return db.AlbumTag.Where(r => r.AlbumId == item.AlbumId && r.TagId == item.TagId).FirstOrDefault();
                }
            }
            catch (EntityException e)
            {
                throw e;
            }
        }

        public static int Delete(AlbumTag item)
        {
            try
            {
                using(var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    var del = db.AlbumTag.Where(x => x.AlbumId == item.AlbumId).Single();
                    db.AlbumTag.Remove(del);
                    return db.SaveChanges();
                }
            }
            catch (EntityException ex)
            {
                throw ex;
            }
        }
    }
}
