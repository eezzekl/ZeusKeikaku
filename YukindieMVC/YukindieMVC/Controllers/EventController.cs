using DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace YukindieMVC.Controllers
{
    //[RoutePrefix("Event")]
    public class EventController : Controller
    {
        // GET: Evento
        //[Route("{id}/{slug}")]
        public ActionResult Index(int id, string slug)
        {
            var evento = EventoDAO.GetData(EventoId:id, Estatus: true, allData: true);
            return View(evento);
        }
    }
}