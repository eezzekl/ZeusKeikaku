using Newtonsoft.Json.Converters;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DAO;
using Model;
using System;

namespace YukindieMVC.Areas.Admin.Controllers
{

    public class AlbumController : Controller
    {
        // GET: Admin/Album
        public ActionResult Index()
        {
            var litemAlbum = AlbumDAO.Get(0, 0);
            return View(litemAlbum);
        }

        public ActionResult IndexDinamico()
        {
            return View();
        }

        //ver si es mejor llenarlo directo el album desde controller
        //ya que hay que pensar en tambien aprovechar las bondades de mvc como sus
        //dataanotations etc.

        public ActionResult Gestion(int Id=0)
        {
            int IdAlbum = 0;
            //se valida que el Id no sea texto, si es texto se manda al 404 o a Index
            //bool esValido = int.TryParse(Id, out IdAlbum);
            //se valida que el Id recibido tenga datos, de lo contrario mandar a index
            IdAlbum = Id;
            ViewBag.IdAlbum = IdAlbum;
                
            return View();
        }

        [HttpPost]
        public JsonResult Get(int AlbumId, int PerfilId, string Titulo)
        {
            Album album = AlbumDAO.Get(AlbumId, PerfilId, Titulo).FirstOrDefault();
            //var LTag = new List<Tag>(TagDAO.GetTagsByAlbum(album.AlbumId));
            var a = new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                Data = new { Datos = album/*, Tags = LTag */}
            };
            return a;
        }

        [HttpGet]
        public JsonResult GetAll()
        {
            var jsonData = new
            {
                data = AlbumDAO.Get(0, 0)
        };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Guardar(string album, string valor1)
        {
            //Convcertimos el objeto json a Album
            var albumbo = Newtonsoft.Json.JsonConvert.DeserializeObject<Album>(album, new IsoDateTimeConverter { DateTimeFormat = "dd/MM/yyyy" });
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
                }
            }
            else
            {
                if(string.IsNullOrEmpty(albumbo.Imagen))
                    //si no tiene imagenes asignamos uno como por defecto 
                    albumbo.Imagen = "~/Images/Album/album.jpg";
            }
            try
            {
                Valida(albumbo);
                AlbumDAO.Save(albumbo);
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

        public ActionResult Create()
        {
            return View();
        }

        /// <summary>
        /// Regresa verdadero si todas las condiciones se cumplen.
        /// </summary>
        /// <param name="item">Item a validar</param>
        /// <history>
        /// [ecanul] 23/03/2017 created
        /// </history>
        private bool Valida(Album item)
        {
            bool valid = false;
            //si el titulo no esta vacio
            if (string.IsNullOrEmpty(item.Titulo))
            {
                throw new Exception("El titulo es necesario");
                
            }
            //si la fecha de creacion es una fecha valida //Ekliminar fecha hoy
            if (item.FechaPublicacion == new DateTime() && item.FechaPublicacion > DateTime.Today)
                throw new Exception("Ingrese una fecha valida");
            return valid;
        }
    }
}