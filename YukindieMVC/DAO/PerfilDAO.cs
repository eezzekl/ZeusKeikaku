using Model;
using Model.Classes;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

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


        public static Perfil GetEstablecimiento()
        {
            Perfil p = new Perfil();
            using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
            {
                p = db.Perfil.Where(x => x.PerfilId == 3).FirstOrDefault();
            }
            //var lPerfil = PerfilDAO.Get();
            return p;
        }

        #region Save
        /// <summary>
        /// Guarda un perfil
        /// </summary>
        /// <param name="item"></param>
        /// <history>
        /// [ecanul] 22/05/2017 Created
        /// </history>
        public static Perfil Save(Perfil item)
        {
            TransactionOptions options = new TransactionOptions();
            options.IsolationLevel = IsolationLevel.ReadCommitted;
            options.Timeout = new TimeSpan(0, 5, 0);
            try
            {
                using (var scope = new TransactionScope(TransactionScopeOption.Required, options))
                {
                    var PerfilId = new ObjectParameter("PerfilId", item.PerfilId);
                    using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                    {
                        try
                        {
                            var i = db.st_InsPerfil(PerfilId, item.UsuarioId, item.Rol, item.PerfilTipoId, item.Nombre, item.FotoPerfil,
                                item.AcercaDe, item.Telefono, item.Correo, item.Direccion, item.Horario, item.Fundacion,
                                item.CiudadId, item.Latitud, item.Longitud, item.Presskit, item.DescripcionCorta);
                            int id = (item.PerfilId > 0) ? item.PerfilId : Convert.ToInt32(PerfilId.Value);

                            if(item.SocialMedia != null && item.SocialMedia.Count > 0)
                            {
                                PerfilSocialesDao.DeleteAllbyPerfilId(new PerfilSociales { PerfilId = id });
                                foreach(var sm in item.SocialMedia)
                                {
                                    var red = PerfilSocialesDao.Get(new PerfilSociales { RedSocial = sm.RedSocial, PerfilId = id });
                                    if (red == null)
                                        PerfilSocialesDao.Save(new PerfilSociales
                                        {
                                            PerfilId = id,
                                            RedSocial = sm.RedSocial,
                                            Url = sm.Url,
                                            Estatus = true,
                                            FechaRegistro = DateTime.Today
                                        });
                                }
                            }

                            var perfil = db.Perfil.Where(x => x.PerfilId == id).FirstOrDefault();
                            scope.Complete();
                            return perfil;
                        }
                        catch (EntityException ex)
                        {
                            scope.Dispose();
                            throw ex;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region MultiGet
        /// <summary>
        /// Obtiene el listado de perdfiles 
        /// 
        /// ESTA MAL CORREGIR CON SP
        /// </summary>
        /// <param name="item"></param>
        /// <history>
        /// [ecanul] 22/05/2017 Created
        /// </history>
        public static List<Perfil> Get(Perfil item = null)
        {
            using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
            {

                if (item == null) //Si es nulo se regresan todos los tipo artista
                    return db.Perfil.Where(p => p.PerfilTipoId == 2).ToList();
                else if (item.UsuarioId != 0)
                    return db.Perfil.Where(p => p.UsuarioId == item.UsuarioId).ToList();
                else if (item.PerfilId != 0) //Por id especifico
                    return db.Perfil.Where(p => p.PerfilId == item.PerfilId).ToList();
                else if (item.PerfilTipoId != 0) //Si se busca por un tipo de perfil (Fan Musico Empresa)
                    return db.Perfil.Where(p => p.PerfilTipoId == item.PerfilTipoId).ToList();
                else
                    return db.Perfil.Where(p => p.CiudadId == item.CiudadId).ToList();
            }
        }
        #endregion

        public static Perfil GetOne(int PerfilId)
        {
            using(var db= new Entities(ConnectionStringHelper.ConnectionString()))
            {
                var perfil = db.Perfil.Where(p => p.PerfilId == PerfilId).FirstOrDefault();

                perfil.SocialMedia = new List<PerfilSociales>();
                perfil.SocialMedia = PerfilSocialesDao.GetByPerfil(perfil.PerfilId);
                return perfil;
            }
        }

    }
}
