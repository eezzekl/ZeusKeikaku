using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DAO;


namespace ZeusKeikaku.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            var list = Class1.test();
            var al = list[0];
            ViewBag.Item = al;
            return View();
        }
    }
}