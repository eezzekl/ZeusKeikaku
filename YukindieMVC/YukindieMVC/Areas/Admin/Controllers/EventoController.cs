using DAO;
using Model;
using Model.Classes;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YukindieMVC.Controllers;
using System.IO;

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

        public ActionResult Update(int Id)
        {
            using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
            {
                var Evento = db.Evento.Where(x => x.EventoId == Id && x.Perfil.PerfilId == 3).FirstOrDefault();
                if (Evento != null)
                {
                    int EventoId = 0;
                    //se valida que el Id no sea texto, si es texto se manda al 404 o a Index
                    //bool esValido = int.TryParse(Id, out IdAlbum);
                    //se valida que el Id recibido tenga datos, de lo contrario mandar a index
                    EventoId = Id;
                    ViewBag.EventoId = EventoId;
                    //creamos una session que contendra los valores de nuestro evento
                    Session["sessionEvento"] = null;
                    return View();
                }
                else
                {
                    return RedirectToAction("Index", "Evento");
                }
            }
        }

        [HttpGet]
        public JsonResult GetAll()
        {
            var jsonData = new
            {
                data = EventoDAO.GetData(allData: true)
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        [HttpGet]
        public JsonResult Get(int EventoId)
        {
            Evento evento = EventoDAO.GetData(EventoId, allData: true).FirstOrDefault();
            Session["sessionEvento"] = evento;
            //var LTag = new List<Tag>(TagDAO.GetTagsByAlbum(album.AlbumId));
            var a = new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                Data = new { Datos = evento/*, Tags = LTag */}
            };
            return a;
        }

        [HttpPost]
        //para que me deje ingresar la url de video de youtube
        [ValidateInput(false)]
        public JsonResult Guardar(string evento)
        {
            try
            {
                //Convcertimos el objeto json a Album
                var eventobo = Newtonsoft.Json.JsonConvert.DeserializeObject<Evento>(evento, new IsoDateTimeConverter { DateTimeFormat = "dd/MM/yyyy" });
                //  Get all files from Request object  
                HttpFileCollectionBase files = Request.Files;
                //Si files tiene al menos un archivo 
                //siempre se guarden las imagenes por si se presenta que el usuario sube otra imagen pero con el mismo nombre.
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
                    //validamos si hay algo en sessionevento
                    //si hay algo significa que es una modificacion de lo contrario en una ccreacion
                    // si hay algo solo pasamos la misma url de la imagen de lo contrario ponemos la que esta por defecto.
                    var eventosesion = (Evento)Session["sessionEvento"];
                    if (eventosesion != null)
                    {
                        eventobo.Imagen = eventosesion.Imagen;
                    }
                    else
                    {
                        //si no tiene imagenes asignamos uno como por defecto 
                        eventobo.Imagen = "~/Images/Album/album.jpg";
                    }
                    //if (string.IsNullOrEmpty(eventobo.Imagen))
                }
                //Valida(albumbo);
                ValidaEvento(eventobo);
                // por que viene null este? no es correcto debe poderse popular al objeto
                eventobo.Perfil.PerfilId = 3;
                EventoDAO.Save(eventobo);
                //si fue exitoso entonces se elimina el archivo que teniamos guardado.

                var EventoEliminar = (Evento)Session["sessionEvento"];
                if (EventoEliminar != null)
                {
                    System.IO.File.Delete(EventoEliminar.Imagen);
                }
                return new JsonResult()
                {
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                    Data = new { Mensaje = "¡Proceso realizado correctamente!" }
                };
            }
            catch (Exception ex)
            {
                return new JsonResult()
                {
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                    Data = new { Mensaje = "Error al guardar: " + ex.Message.ToString() }
                };
            }
        }

        private bool ValidaEvento(Evento item)
        {
            bool bandera = false;
            //si el titulo no esta vacio
            if (string.IsNullOrEmpty(item.Titulo))
            {
                throw new Exception("El Título es necesario");

            }
            //si la fecha de creacion es una fecha valida //Ekliminar fecha hoy
            if (item.FechaEvento.Date < DateTime.Now.Date)
            {
                throw new Exception("La Fecha del evento no puede ser menor a hoy");
            }
            if (string.IsNullOrEmpty(item.Establecimiento))
            {
                throw new Exception("El Establecimiento es necesario");
            }
            if (string.IsNullOrEmpty(item.Direccion))
            {
                throw new Exception("La dirección es necesaria");
            }
            decimal num1 = 0;
            bool res = Decimal.TryParse(item.PrecioRegular.ToString(), out num1);
            if (res == false)
            {
                throw new Exception("El valor del campo Precio Regular debe ser numérico");
            }
            return bandera;
        }
    }
}