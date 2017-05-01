using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DAO;

namespace YukindieMVC.Areas.Admin.Controllers
{
    public class EventoTipoController : Controller
    {
        // GET: Admin/EventoTipo
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult Get(int EventoTipoId, string Descripcion, Boolean Estatus)
        {
            try
            {
                var EventoTipo = EventoTipoDAO.Get(EventoTipoId, null, Estatus);
                return new JsonResult()
                {
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                    Data = new { Datos = EventoTipo }
                };
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}