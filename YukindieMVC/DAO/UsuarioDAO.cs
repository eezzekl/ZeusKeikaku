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
    public class UsuarioDAO
    {
        /// <summary>
        /// Obtiene un usuario por su correo y  contraseña
        /// </summary>
        /// <param name="usr">Usuario</param>
        /// <history>
        /// [ecanul] 01/05/2017 Created
        /// </history>
        public static Usuario GetByLogin( Usuario usr)
        {
            try
            {
                var usuario = new Usuario();
                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    usuario = db.Usuario.Include("Perfil").Where(u => u.Correo == usr.Correo && u.Contraseña == usr.Contraseña).FirstOrDefault();
                }
                return usuario;
            }
            catch (EntityException ex)
            { throw ex; }
        }
    }
}
