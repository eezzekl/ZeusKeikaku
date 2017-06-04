using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace YukindieMVC
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            //            routes.MapRoute(
            //name: "SlugsAfterId",
            //url: "{controller}/{id}/{slug}",
            //defaults: new { action = "Index", id = UrlParameter.Optional, slug = UrlParameter.Optional }
            //);

            routes.MapRoute(
name: "SlugsAfterId",
url: "{Controller}/{action}/{id}/{slug}",
defaults: new {  controller="Event", action = "Index" }
);

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
