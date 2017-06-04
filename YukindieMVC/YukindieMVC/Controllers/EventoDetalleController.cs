using Model;
using Model.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace YukindieMVC.Controllers
{
    public class EventoDetalleController : Controller
    {
        // GET: EventoDetalle
        public ActionResult Index()
        {
            //using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
            //{
            //    var Evento = db.Evento.Where(x => x.EventoId == Id).FirstOrDefault();
            //    if (Evento != null)
            //    {
            //        int EventoId = 0;
            //        //se valida que el Id no sea texto, si es texto se manda al 404 o a Index
            //        //bool esValido = int.TryParse(Id, out IdAlbum);
            //        //se valida que el Id recibido tenga datos, de lo contrario mandar a index
            //        EventoId = Id;
            //        ViewBag.EventoId = EventoId;
            //        //creamos una session que contendra los valores de nuestro evento
            //        return View();
            //    }
            //    else
            //    {
            //        return RedirectToAction("Index", "Evento");
            //    }
            //}

            return View();
        }
    }
}