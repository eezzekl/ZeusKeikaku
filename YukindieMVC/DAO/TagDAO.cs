using System.Collections.Generic;
using System.Linq;
using Model;
using Model.Classes;
using System.Data.Entity.Core;

namespace DAO
{
    public class TagDAO
    { 
        /// <summary>
        /// Inserta un nuevo tag a la base de datos
        /// </summary>
        /// <param name="item">Datos del Tag</param>
        /// <returns>El registro agregado</returns>
        /// <history>
        /// [ecanul] 12/04/2017 Created
        /// </history>
        public static Tag Save (Tag item)
        {
            try
            {
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    db.Tag.Add(item);
                    db.SaveChanges();
                    return item;
                }
            }
            catch(EntityException e)
            {
                throw e;
            }
        }

        /// <summary>
        /// Obtiene el tag segun el nombre
        /// </summary>
        /// <param name="item"></param>
        /// <returns></returns>
        /// <history>
        /// [ecanul] 12/04/2017 Created
        /// </history>
        public static Tag Get(Tag item)
        {
            try
            {
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    return db.Tag.Where(t => t.nombre == item.nombre).FirstOrDefault();
                }
            }
            catch (EntityException e)
            {
                throw e;
            }
        }

        /// <summary>
        /// obtiene el istado de todos los tags
        /// </summary>
        /// <returns></returns>
        /// <history>
        /// [ecanul] 12/04/2017 Created
        /// </history>
        public static List<Tag> GetAll()
        {
            try
            {
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    return db.Tag.ToList();
                }
            }
            catch (EntityException e)
            {
                throw e;
            }
        }

        public static List<Tag> GetTagsByAlbum(int AlbumId)
        {
            try
            {
                using(var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    var tag = (from tagAl in db.AlbumTag
                               join t in db.Tag on tagAl.TagId equals t.TagId
                               where tagAl.AlbumId == AlbumId
                               select t
                               ).ToList();
                    return tag;
                }
            }
            catch (EntityException ex)
            {

                throw ex;
            }
        }
    }
}
