using Model;
using Model.Classes;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public class PerfilDAO
    {
        public static List<Perfil> Get()
        {
            try
            {
                List<Perfil> lPerfil = new List<Perfil>();
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    lPerfil = db.st_selPerfil()
                        .Select(x => new Perfil
                        {
                            Nombre = x.Nombre
                        }).ToList();
                }

                return lPerfil;
            }
            catch (EntityException ex)
            {
                throw ex;
            }
        }
    }
}
