using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace YukindieMVC.Controllers
{
    public class SessionExpired : ActionFilterAttribute
    {
        // GET: SessionExpired
        //public ActionResult Index()
        //{
        //    return View();
        //}

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            HttpSessionStateBase session = filterContext.HttpContext.Session;
            Controller controller = filterContext.Controller as Controller;

            if (controller != null)
            {
                //if (session["UsuariosSession"] == null)
                if (session != null && session["UsuariosSession"] == null)
                {
                    //filterContext.Result =
                    //       new RedirectToRouteResult(
                    //           new RouteValueDictionary{{ "controller", "Home" },
                    //                      { "action", "Index" , "area",""}

                    //                                         });

                    filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new
                    {
                        action = "Index",
                        controller = "Home",
                        area = ""
                    }));
                }
            }

            base.OnActionExecuting(filterContext);
        }
    }
}