using DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace YukindieMVC.Areas.Admin.Controllers
{
    public class TagController : Controller
    {
        // GET: Admin/Tag
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult Get(int TagId, string Nombre)
        {
            var lPerfil = TagDAO.Get(TagId, Nombre);
            return new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                Data = new { Datos = lPerfil }
            };
        }
    }
}