using System.Collections.Generic;
using System.Linq;
using Model;
using Model.Classes;
using System.Data.Entity.Core;
using System;
using System.Transactions;
using System.Data.Entity.Core.Objects;

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
        public static List<Album> Get(int AlbumId, int PerfilId, string Titulo = "")
        {
            try
            {
                PerfilId = 3;
                var item = new List<Album>();
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    item = db.st_SelAlbum_(AlbumId, Titulo, PerfilId).Select(x => new Album
                    {
                        AlbumId = x.AlbumId,
                        Titulo = x.Titulo,
                        Imagen = x.Imagen,
                        FechaPublicacionTexto = x.FechaPublicacion.ToString("dd/mm/yyyy"),
                        Formato = x.Formato,
                        Contenido = x.Contenido,
                        Precio = x.Precio,
                        Oferta = x.Oferta,
                        LinkCompra = x.LinkCompra,
                        Promocion = x.Promocion,
                        PerfilId = x.PerfilId,
                        Estatus = x.Estatus,
                        SubGenero = new SubGenero
                        {
                            SubGeneroId = x.SubGeneroId,
                            Descripcion = x.SubGenero
                        },
                        LTag = new List<Tag>()
                        //AlbumTag = AlbumTagDAO.ListByAlbum(x.AlbumId)     
                        //LTag = new List<Tag>(TagDAO.GetTagsByAlbum(AlbumId).ToList())
                        // users = m.users.Where(u => u.surname == "surname").ToList()             
                    }).ToList();
                }

                //return (from a in IDs
                //        from b in a.Values
                //        where b.Code == code
                //        select (new A { ID = a.ID, Values = new List<B>
                //        { new B { Code = b.Code, DisplayName = b.DisplayName } }
                //        })).FirstOrDefault();

                var tags = TagDAO.GetTagsByAlbum(item[0].AlbumId);
                foreach (var tag in tags)
                {
                    item[0].LTag.Add(new Tag { TagId = tag.TagId, Nombre = tag.Nombre });
                }
                //item[0].LTag = 
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
        public static Album Save(Album item, List<Tag> Ltag = null)
        {
            TransactionOptions options = new TransactionOptions();
            options.IsolationLevel = IsolationLevel.ReadCommitted;
            options.Timeout = new TimeSpan(0, 5, 0);
            try
            {
                using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required, options))
                {
                    ObjectParameter AlbumId = new ObjectParameter("AlbumId", item.AlbumId);
                    using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                    {
                        try
                        {
                            //Se inserta la informacion
                            var i = db.st_InsAlbum_(item.AlbumId, item.Titulo, item.Imagen, item.FechaPublicacion, item.Formato, item.Contenido, item.Precio, item.Oferta, item.LinkCompra, item.Promocion, item.PerfilId, item.SubGenero.SubGeneroId, item.Estatus, item.FechaRegistro);
                            //Se obtiene el album recien ingresado
                            int albumId = (item.AlbumId > 0) ? item.AlbumId : Convert.ToInt32(AlbumId.Value);
                            var album = db.Album.Where(x => x.Titulo == item.Titulo && x.PerfilId == item.PerfilId).FirstOrDefault();
                            //Eliminamos los tags que tenga asignados
                            if (item.LTag != null && item.LTag.Count > 0)
                            {
                                //Eliminamos todos los tags del album
                                AlbumTagDAO.Delete(new AlbumTag { AlbumId = albumId });
                                //Llenamos los tags del album
                                foreach (Tag tag in item.LTag)
                                {
                                    //Obtenemos el tag
                                    var t = TagDAO.Get(tag);
                                    //si el tag no existe se crea
                                    if (t == null)
                                        t = TagDAO.Save(tag);
                                    //Guardamos la relacion
                                    AlbumTagDAO.Save(new AlbumTag
                                    {
                                        AlbumId = album.AlbumId,
                                        TagId = t.TagId
                                    });
                                }
                            }
                            scope.Complete();
                            return album;
                        }
                        catch (EntityException ex)
                        {
                            scope.Dispose();
                            throw ex;
                        }
                    }
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
