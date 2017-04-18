using System.Data.Entity.Core.EntityClient;

namespace Model.Classes
{
    public class ConnectionStringHelper
    {
        static string _connectionString;

        /// <summary>
        /// Metodo que construye el la cadena de conexion
        /// </summary>
        /// <history>
        /// [ecanul] 27/02/2017 Created
        /// </history>
        public static string ConnectionString()
        {
            if (string.IsNullOrEmpty(_connectionString))
            {
                EntityConnectionStringBuilder builder = new EntityConnectionStringBuilder();
                builder.Provider = "System.Data.SqlClient";
                builder.ProviderConnectionString = AppConfigHelper.GetConfiProp("connectionStr");
                string databaseModel = "YukindieModel"; // nombre del modelo de la base de datos
                builder.Metadata = $"res://*/{databaseModel}.csdl|res://*/{databaseModel}.ssdl|res://*/{databaseModel}.msl";
                _connectionString = builder.ToString();
            }
            return _connectionString;
        }
    }
}
