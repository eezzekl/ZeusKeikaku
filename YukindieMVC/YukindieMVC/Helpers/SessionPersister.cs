using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YukindieMVC.Helpers
{
    public class SessionPersister
    {
        static string UsuarioEnSessionvar = "UsuariosSession";
        static string MenuEnSessionVar = "MenuSession";

        public static Model.Usuario UsuarioEnSession
        {
            get
            {
                if (HttpContext.Current == null)
                    return null;
                var EventosSession = HttpContext.Current.Session[UsuarioEnSessionvar];
                if (EventosSession != null)
                    return EventosSession as Model.Usuario;
                return null;
            }
            set
            {
                HttpContext.Current.Session[UsuarioEnSessionvar] = value;
            }
        }

        public static List<Model.Seguridad_Menu> menu
        {
            get
            {
                if (HttpContext.Current == null)
                    return null;
                //else if (HttpContext.Current.Session == null)
                //    return null;
                var sessionVar = HttpContext.Current.Session[MenuEnSessionVar];
                if (sessionVar != null)
                    return sessionVar as List<Model.Seguridad_Menu>;
                return null;
            }
            set
            {
                HttpContext.Current.Session[MenuEnSessionVar] = value;
            }
        }
    }


}