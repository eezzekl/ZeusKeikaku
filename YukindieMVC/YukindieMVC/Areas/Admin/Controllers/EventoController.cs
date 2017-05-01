using DAO;
using Model;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YukindieMVC.Controllers;

namespace YukindieMVC.Areas.Admin.Controllers
{
    public class EventoController : Controller
    {
        // GET: Admin/Evento
        [SessionExpired]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public JsonResult Guardar(string evento)
        {
            //Convcertimos el objeto json a Album
            var eventobo = Newtonsoft.Json.JsonConvert.DeserializeObject<Evento>(evento, new IsoDateTimeConverter { DateTimeFormat = "dd/MM/yyyy" });
            //  Get all files from Request object  
            HttpFileCollectionBase files = Request.Files;
            //Si files tiene al menos un archivo 
            if (files.Count > 0)
            {
                for (int i = 0; i < files.Count; i++)
                {
                    var file = files[i];

                    var fileName = Path.GetFileName(file.FileName);

                    var path = Path.Combine(Server.MapPath("~/Images/"), fileName);
                    file.SaveAs(path);
                    eventobo.Imagen = fileName;
                }
            }
            else
            {
                if (string.IsNullOrEmpty(eventobo.Imagen))
                    //si no tiene imagenes asignamos uno como por defecto 
                    eventobo.Imagen = "~/Images/Album/album.jpg";
            }
            try
            {
                //Valida(albumbo);
                // por que viene null este? no es correcto debe poderse popular al objeto
                eventobo.Perfil.PerfilId = 3;
                EventoDAO.Save(eventobo);
                return new JsonResult()
                {
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                    Data = new { Mensaje = "¡Registro creado con éxito!" }
                };
            }
            catch (Exception ex)
            {
                return new JsonResult()
                {
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                    Data = new { error = ex.Message.ToString() }
                };
            }
        }
    }
}