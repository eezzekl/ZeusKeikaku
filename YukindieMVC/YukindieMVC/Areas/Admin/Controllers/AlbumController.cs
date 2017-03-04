using Newtonsoft.Json.Converters;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DAO;
using Model;

namespace YukindieMVC.Areas.Admin.Controllers
{

    public class AlbumController : Controller
    {
        // GET: Admin/Album
        public ActionResult Index()
        {
            var litemAlbum = AlbumDAO.Get(0, null, 0);
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
        public JsonResult Get(int AlbumId, string Titulo, int PerfilId)
        {
            var Album = AlbumDAO.Get(AlbumId, Titulo, PerfilId).FirstOrDefault();
            return new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                Data = new { Datos = Album }
            };
        }

        [HttpGet]
        public JsonResult GetAll()
        {
            var jsonData = new
            {
                data = AlbumDAO.Get(0, "", 0)
        };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Guardar(string album, string valor1)
        {
            //  Get all files from Request object  
            HttpFileCollectionBase files = Request.Files;
            for (int i = 0; i < files.Count; i++)
            {
                var file = files[i];

                var fileName = Path.GetFileName(file.FileName);

                var path = Path.Combine(Server.MapPath("~/Images/"), fileName);
                file.SaveAs(path);
            }
            
            var albumbo = Newtonsoft.Json.JsonConvert.DeserializeObject<Album>(album, new IsoDateTimeConverter { DateTimeFormat = "dd/MM/yyyy" });

            AlbumDAO.Save(albumbo);
            return new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                Data = new { Mensaje = "¡Registro creado con éxito!" }
            };
        }

        public ActionResult Create()
        {
            return View();
        }
    }
}