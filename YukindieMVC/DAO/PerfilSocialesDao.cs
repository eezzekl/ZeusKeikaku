using System.Linq;
using Model;
using Model.Classes;
using System.Data.Entity.Core;
using System.Collections.Generic;

namespace DAO
{
    public class PerfilSocialesDao
    {
        public static int DeleteAllbyPerfilId (PerfilSociales item)
        {
            try
            {
                using(var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    var del = db.PerfilSociales.Where(x => x.PerfilId == item.PerfilId).ToList();
                    db.PerfilSociales.RemoveRange(del);
                    return db.SaveChanges();
                }
            }
            catch (EntityException ex)
            {
                throw ex;
            }
        }

        public static int Save(PerfilSociales item)
        {
            try
            {
                using(var db= new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    db.PerfilSociales.Add(item);
                    return db.SaveChanges();
                }
            }
            catch (EntityException ex)
            {
                throw ex;
            }
        }

        public static PerfilSociales Get(PerfilSociales item)
        {
            try
            {
                using (var db= new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    return db.PerfilSociales.Where(sm => sm.RedSocial == item.RedSocial && sm.PerfilId == item.PerfilId).FirstOrDefault();
                }
            }
            catch (EntityException ex)
            { throw ex; }
        }

        public static List<PerfilSociales> GetByPerfil(int PerfilId)
        {
            using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
            {
                return db.PerfilSociales.Where(sm => sm.PerfilId == PerfilId).ToList();
            }
        }
    }
}
