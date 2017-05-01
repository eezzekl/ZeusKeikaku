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
    public class EventoTipoDAO
    {
        public static List<EventoTipo> Get(int EventoTipoId, string Descripcion, bool Estatus)
        {
            try
            {
                List<Model.EventoTipo> litem = new List<Model.EventoTipo>();

                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    litem = db.st_SelEventoTipo(EventoTipoId,null,Estatus)
                        .Select(x => new EventoTipo
                        {
                            EventoTipoId = x.EventoTipoId,
                            Descripcion = x.Descripcion,
                            Estatus = x.Estatus
                        }).ToList();
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
