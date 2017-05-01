using System.Collections.Generic;
using System.Linq;
using Model;
using Model.Classes;
using System.Data.Entity.Core;
using System;

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
                    item[0].LTag.Add(new Tag { TagId = tag.TagId, Nombre  = tag.Nombre  });
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
        public static Album Save(Album item, List<Tag> Ltag= null)
        {
            try
            {
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    //Se inserta la informacion
                    var i = db.st_InsAlbum_(item.AlbumId, item.Titulo, item.Imagen, item.FechaPublicacion, item.Formato, item.Contenido, item.Precio, item.Oferta, item.LinkCompra, item.Promocion, item.PerfilId, item.SubGenero.SubGeneroId, item.Estatus, item.FechaRegistro);
                    //Se obtiene el album recien ingresado
                    var album = db.Album.Where(x => x.Titulo == item.Titulo && x.PerfilId == item.PerfilId).FirstOrDefault();
                    //obtenemos la lista original de los tags
                    var oldTags = AlbumTagDAO.ListByAlbum(album.AlbumId);
                    var ntags = new List<int>();
                    Ltag = item.LTag;
                    foreach (var tag in Ltag)
                    {
                        //Si el tag no existe lo agregamos
                        var t = TagDAO.Get(tag);
                        if(t == null)
                            t = TagDAO.Save(tag);
                        //Obtenemos la relacion
                        var albumtag = new AlbumTag();
                        albumtag.AlbumId = album.AlbumId;
                        albumtag.TagId = t.TagId;
                        var rel = AlbumTagDAO.Get(albumtag);
                        //Si la relacion no existe la creamos
                        if (rel == null)
                            AlbumTagDAO.Save(albumtag);
                        ntags.Add(t.TagId);                     
                    }
                    //Obtenemos la lista de tags a eliminar de la relacion
                    var delete = (from tag in oldTags
                             where !ntags.Contains(Convert.ToInt32(tag.TagId))
                             select tag).ToList();

                    foreach (var tagAl in delete)
                    {
                        AlbumTagDAO.Delete(tagAl);
                    }

                    return album;                   
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
