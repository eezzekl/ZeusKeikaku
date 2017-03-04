using System.Configuration;

namespace Model.Classes
{
    /// <summary>
    /// Clase que lee las configuraciones del appconfig/webconfig
    /// </summary>
    public class AppConfigHelper
    {
        /// <summary>
        /// Lee una "Key del app config y devuelve su valor"
        /// </summary>
        /// <param name="key">Nombre de la variable a conseguir</param>
        /// <history>
        /// [ecanul] 27/02/2017 Created
        /// </history>
        public static string GetConfiProp(string key)
        {
            var conf = ConfigurationManager.AppSettings[key];
            return conf;
        }
    }
}
