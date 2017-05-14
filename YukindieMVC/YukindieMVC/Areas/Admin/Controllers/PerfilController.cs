using DAO;
using Model;
using Model.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace YukindieMVC.Areas.Admin.Controllers
{
    public class PerfilController : Controller
    {
        // GET: Admin/Perfil
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult GetAll()
        {
            var lPerfil = PerfilDAO.Get();
            return new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                Data = new { Datos = lPerfil }
            };
        }

        [HttpGet]
        public JsonResult GetEstablecimiento()
        {
            var lPerfil = PerfilDAO.Get().FirstOrDefault();
            return new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                Data = new { Datos = lPerfil }
            };
        }
    }
}