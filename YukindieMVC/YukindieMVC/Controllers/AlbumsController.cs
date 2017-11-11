using DAO;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YukindieMVC.Helpers;

namespace YukindieMVC.Controllers
{
    public class AlbumsController : Controller
    {
        // GET: Album
        [HttpGet]
        public ActionResult Index(int ? page)
        {
            var dummyItems = AlbumDAO.Get(0, 0, "");
            var pager = new Pager(dummyItems.Count(), page);
            var viewModel = new IndexViewModel
            {
                AlbumP = dummyItems.Skip((pager.CurrentPage - 1) * pager.PageSize).Take(pager.PageSize),
                Pager = pager
            };
            return View(viewModel);
        }

        public ActionResult Album(int Id = 0)
        {
            ViewBag.AlbumId = Id;
            return View();
        }

        [HttpPost]
        public JsonResult Get(int AlbumId, int PerfilId, string Titulo = "")
        {
            Album album = AlbumDAO.Get(AlbumId, PerfilId, Titulo).FirstOrDefault();
            var a = new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                Data = new { Datos = album/*, Tags = LTag */}
            };
            return a;
        }
    }
}