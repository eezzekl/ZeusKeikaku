using System.Collections.Generic;
using System.Linq;
using Model;
using Model.Classes;
using System.Data.Entity.Core;

namespace DAO
{
    public class AlbumDAO
    {
        #region Get
        /// <summary>
        /// Obtiene un listado de de albums segun el id y titulo del album asi como el perfil 
        /// </summary>
        /// <param name="AlbumId">id del album</param>
        /// <param name="Titulo">Titulo del album</param>
        /// <param name="PerfilId">Id perfil</param>
        /// <history>
        /// [egongora] Created
        /// [ecanul] 03/02/2017 Modified. La cosulta la hago desde EF porque no me pasaste el sp
        /// </history>
        public static List<Album> Get(int AlbumId, string Titulo, int PerfilId)
        {
            try
            {
                var item = new List<Album>();
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    item = db.Album.Include("SubGenero").Where(a => a.AlbumId == AlbumId && a.Titulo == Titulo && a.PerfilId == PerfilId).ToList();
                }
                return item;
            }
            catch (EntityException ex)
            {
                //Devuelve el valor arrojado por cliente de entity framework (Es mas detallado que el error que obtiene .net por si solo
                throw ex;
            }
        }
        #endregion

        #region Save
        /// <summary>
        /// Guarda un elemento nuevo o ya existente en la base de datos
        /// </summary>
        /// <param name="item">Album a guardar</param>
        /// <history>
        /// [egongora] created
        /// </history>
        public static int Save(Album item)
        {
            try
            {
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    return db.st_InsAlbum_(item.AlbumId, item.Titulo, item.Imagen, item.FechaPublicacion, item.Formato, item.Contenido, item.Precio, item.Oferta, item.LinkCompra, item.Promocion, item.PerfilId, item.SubGenero.SubGeneroId, item.Estatus, item.FechaRegistro);
                }
            }
            catch (EntityException ex)
            {
                throw ex;
            }
        }
        #endregion

        #region Delete
        /// <summary>
        /// Inactiva un album existente
        /// </summary>
        /// <param name="item">Album a eliminar</param>
        /// <param name="useSP">Si quiere hacerlo por sp o por EF</param>
        /// <history>
        /// [egongora] CREATED
        /// [ecanul] 01/03/2017 Agregue el parametro useSP que indica si se quiere usar por SP o por EF
        /// </history>
        public static int Delete(Album item, bool useSP = true)
        {
            try
            {
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    if (useSP)
                        return db.st_DelAlbum_(item.AlbumId, item.PerfilId);
                    else
                    {
                        var al = db.Album.SingleOrDefault(a => a.AlbumId == item.AlbumId && a.PerfilId == item.PerfilId);
                        al.Estatus = false;
                        return db.SaveChanges();
                    }
                }
            }
            catch (EntityException ex)
            {
                //Para que devuelva los errores de EF y no de .NET
                throw ex;
            }
        } 
        #endregion
    }
}
