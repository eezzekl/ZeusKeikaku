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
    public class EventosController : Controller
    {
        // GET: Eventos
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Index2()
        {
            return View();
        }

        [HttpGet]
        public ActionResult IndexPaginationMVC(int? page )
        {
            var dummyItems = EventoDAO.GetData(Estatus: true, allData: false);//Enumerable.Range(1, 150).Select(x => "Item " + x);
            var pager = new Pager(dummyItems.Count(), page);

            var viewModel = new IndexViewModel
            {
                Items = dummyItems.Skip((pager.CurrentPage - 1) * pager.PageSize).Take(pager.PageSize),
                Pager = pager
            };

            return View(viewModel);

            //return View();
        }

        [HttpGet]
        public JsonResult GetAll()
        {
            Helpers.Utilerias utileria = new Helpers.Utilerias();
            var evento = EventoDAO.GetData(Estatus:true, allData: false);
            //asignamos cuantos registros queremos mostrar por pagina
            int registrosPorPagina = 0;
            registrosPorPagina = 5;
            //calculamos el numero de paginas que vamos a mostrar
            int totalPaginas = 0;
            totalPaginas = (int)Math.Ceiling((decimal)evento.Count / (int)registrosPorPagina);
            //var LTag = new List<Tag>(TagDAO.GetTagsByAlbum(album.AlbumId));
            var a = new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                Data = new { Datos = evento, rpp= registrosPorPagina, tp = totalPaginas/*, Tags = LTag */}
            };
            return a;
        }
    }
}