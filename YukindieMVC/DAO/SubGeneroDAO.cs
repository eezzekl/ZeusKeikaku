using System.Collections.Generic;
using System.Linq;
using Model;
using Model.Classes;
using System.Data.Entity.Core;

namespace DAO
{
    public class SubGeneroDAO
    {
        #region Get
        /// <summary>
        /// selecciona todos los subgeneros que esten activos
        /// </summary>
        /// <param name="useSP">Si quieren hacerlo con sp o con EF</param>
        /// <history>
        /// [egongora] Created
        /// [ecanul] 01/03/2017 Modified. Agregue el parametro use SP
        /// </history>
        public static List<SubGenero> Get(bool useSP = true)
        {
            try
            {
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    if (useSP)
                        return db.st_SelSubGeneroGetAll().Select(x => new SubGenero
                        {
                            SubGeneroId = x.SubGeneroId,
                            Descripcion = x.Descripcion
                        }).ToList();
                    else
                        return db.SubGenero.Where(sg => sg.Estatus == true).ToList();
                }
            }
            catch (EntityException ex)
            {
                throw ex;
            }
        } 
        #endregion
    }
}
