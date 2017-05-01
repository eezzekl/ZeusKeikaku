using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.Classes;
using Model;
using System.Data.Entity.Core;
using System.Transactions;

namespace DAO
{
    public class CiudadDAO
    {
        public static List<Ciudad> Get()
        {
            try
            {
                List<Ciudad> litem = new List<Ciudad>();

                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    litem = db.st_SelCiudadGetAll()
                        .Select(x => new Ciudad
                        {
                            CiudadId = x.CiudadId,
                            Nombre = x.Nombre
                        }
                        ).ToList();
                }

                return litem;
            }
            catch (EntityException ex)
            {
                //Devuelve el valor arrojado por cliente de entity framework (Es mas detallado que el error que obtiene .net por si solo
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
