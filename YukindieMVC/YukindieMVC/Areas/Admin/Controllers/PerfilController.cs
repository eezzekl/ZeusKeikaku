using DAO;
using Model;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using DAO;
using Model;
using System;

namespace YukindieMVC.Areas.Admin.Controllers
{
    public class PerfilController : Controller
    {
        // GET: Admin/Perfil
        public ActionResult Index()
        {
            var lst = PerfilDAO.Get(new Perfil { UsuarioId = 1 });
            return View(lst);
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

        [HttpPost]
        [ValidateInput(false)]
        public JsonResult Save(string item)
        {
            var perfil = JsonConvert.DeserializeObject<Perfil>(item, new IsoDateTimeConverter { DateTimeFormat = "dd/MM/yyyy" });
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
                    perfil.FotoPerfil = fileName;
                }
            }
            else
            {
                var perfilSession = (Perfil)Session["sessionPerfil"];
                if (perfilSession != null)
                    perfil.FotoPerfil = perfilSession.FotoPerfil;
                else
                    perfil.FotoPerfil = "~/Images/Perfiles/delorean.jpg";
            }
            try
            {
                //validar
                PerfilDAO.Save(perfil);
                //Si se guardo bien se elimina la imagen anterior guardada
                return new JsonResult()
                {
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                    Data = new { Mensaje = "¡Registro guardado con éxito!" }
                };
            }
            catch
            {
                throw;
            }
        }

        public ActionResult Create()
        {
            return View();
        }

        public ActionResult Gestion(int id=0, int TipoPerfil = 1)
        {
            ViewBag.PerfilId = id;
            ViewBag.TipoPerfil = TipoPerfil;
            return View();
        }

        [HttpGet]
        public JsonResult GetById (int PerfilId)
        {
            var perfil = PerfilDAO.GetOne(PerfilId);
            Session["sessionPerfil"] = perfil;
            var result = new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                Data = new { Datos = perfil }
            };
            return result;
        }
    }
}