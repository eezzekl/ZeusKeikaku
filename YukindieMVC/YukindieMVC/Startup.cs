using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(YukindieMVC.Startup))]
namespace YukindieMVC
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
