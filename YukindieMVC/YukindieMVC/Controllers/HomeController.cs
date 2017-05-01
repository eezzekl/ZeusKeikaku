using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YukindieMVC.Helpers;
using Model.Classes;
using Model;
using DAO;

namespace YukindieMVC.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            //Model.Usuario usu = new Usuario();
            //usu.UsuarioId = 1;
            //usu.Nombre = "Armando";
            //usu.Apellidos = "Gutierrez Ramos";
            //usu.Correo = "armando@hotmail.com";
            //usu.Contraseña = "12345";
            //Model.Perfil p = new Model.Perfil();
            //p.Nombre = "MNM PRODUCCIONES";   
            //p.FotoPerfil = "/Images/Perfiles/mnm producciones.jpg";
            //usu.PerfilId = p;

            //SessionPersister.UsuarioEnSession = null /*usu*/;

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        /// <summary>
        /// Cambia de usuario 
        /// </summary>
        /// <param name="usr"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult AuthChallange(Usuario usr)
        {
            try
            {
                var usuario = UsuarioDAO.GetByLogin(usr);
                if (usuario == null)
                {
                    return new JsonResult()
                    {
                        JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                        Data = new { result = "Usuario no encontrado", Logueo = "NO", Title = "Login", Class = "gritter-error", Configuracion = false }
                    };
                }
                else
                {
                    usuario.PerfilId = usuario.Perfil.Where(p => p.PerfilTipoId == 1).FirstOrDefault();
                    SessionPersister.UsuarioEnSession = usuario;
                    return new JsonResult()
                    {
                        JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                        Data = new { result = "Sesion Iniciada", Logueo = "OK", Title = "Login", Class = "gritter-success", Configuracion = false }
                    };
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}