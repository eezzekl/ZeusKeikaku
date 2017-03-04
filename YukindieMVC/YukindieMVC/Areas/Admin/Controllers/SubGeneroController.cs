using DAO;
using Model;
using System.Web.Mvc;

namespace YukindieMVC.Areas.Admin.Controllers
{
    public class SubGeneroController : Controller
    {
        // GET: Admin/SubGenero
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult Get()
        {
            var SubGenero = SubGeneroDAO.Get();
            return new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                Data = new { Datos = SubGenero }
            };
        }
    }
}