using System;
using System.Configuration;
using System.Reflection;
using System.Web;
using System.Web.Configuration;

namespace Model.Class
{
    /// <summary>
    /// Clase para leer las configuraciones del appconfig de la dll
    /// </summary>
    public class AppConfigHelper
    {
        /// <summary>
        /// Obtiene y lee el archivo de configuracion de la dll
        /// </summary>
        /// <returns></returns>
        private static Configuration GetConfig()
        {
            try
            {
                var _path = Assembly.GetExecutingAssembly().Location + ".config";
                var _configMap = new ExeConfigurationFileMap
                {
                    ExeConfigFilename = _path
                };
                var _configuracion = ConfigurationManager.OpenMappedExeConfiguration(_configMap, ConfigurationUserLevel.None);
                return _configuracion;
            }
            catch (Exception)
            {

                throw new Exception("No se encontro el archivo de configuracion");
            }

           // //Se obtiene el archivo de configuracion
           //// string dllLocation = type.Assembly.Location + ".config";
           // var dllPath = new Uri(Assembly.GetExecutingAssembly().GetName().CodeBase).LocalPath;
            
           // //Si no se encontro se notifica
           // if (dllPath == null)
           //     throw new Exception("No se encontro el archivo de configuracion ");
           // //Se crea el config
           // //ExeConfigurationFileMap fileMap = new ExeConfigurationFileMap();
           // //fileMap.ExeConfigFilename = dllLocation;
           // var dllConfig = ConfigurationManager.OpenExeConfiguration(dllPath);
           // return dllConfig;
        }

        /// <summary>
        /// Metodo que obtiene una variable de configuracion del app config
        /// </summary>
        /// <param name="key">clave de la variable</param>
        /// <param name="type">typeof(clase) es la clase que llama este metodo</param>
        /// <returns></returns>
        public static string GetConfigProperty(string key, Type type)
        {
            var config = GetConfig();
            var appSettings = config.AppSettings;
            return appSettings.Settings[key].Value;
           // return config.AppSettings.Settings[key].Value;
        }

        public static string getConfPror(string key)
        {
            var s = ConfigurationManager.AppSettings[key];
            //Configuration conf = WebConfigurationManager.OpenWebConfiguration(null);
            //if (0 == conf.AppSettings.Settings.Count)
            //    throw new Exception("No se encontraron variables de configuracion");
            //var setings = conf.AppSettings.Settings[key].Value;
            return s;
        }
    }
}


