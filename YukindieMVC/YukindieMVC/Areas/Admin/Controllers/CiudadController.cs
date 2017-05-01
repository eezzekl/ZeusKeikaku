using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DAO;

namespace YukindieMVC.Areas.Admin.Controllers
{
    public class CiudadController : Controller
    {
        // GET: Admin/Ciudad
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult Get()
        {
            try
            {
                var Ciudad = CiudadDAO.Get();
                return new JsonResult()
                {
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                    Data = new { Datos = Ciudad }
                };
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}