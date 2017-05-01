using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YukindieMVC.Helpers;

namespace YukindieMVC.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            Model.Usuario usu = new Model.Usuario();
            usu.UsuarioId = 1;
            usu.Nombre = "Armando";
            usu.Apellidos = "Gutierrez Ramos";
            usu.Correo = "armando@hotmail.com";
            usu.Contraseña = "12345";
            Model.Perfil p = new Model.Perfil();
            p.Nombre = "MNM PRODUCCIONES";   
            p.FotoPerfil = "/Images/Perfiles/mnm producciones.jpg";
            usu.PerfilId.Nombre = "edwin";
            usu.PerfilId = p;

            SessionPersister.UsuarioEnSession = null;

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
    }
}