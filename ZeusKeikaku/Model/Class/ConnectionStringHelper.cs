using System.Data.Entity.Core.EntityClient;

namespace Model.Class
{
    /// <summary>
    /// Esta clase servira para obtener la cadena de conexion de los app config
    /// </summary>
    /// <history>
    /// [ecanul] 27/02/2017
    /// </history>
    public class ConnectionStringHelper
    {
        static string _connectionString;

        public static string ConnectionString()
        {
            if(string.IsNullOrEmpty(_connectionString))
            {
                EntityConnectionStringBuilder builder = new EntityConnectionStringBuilder();
                builder.Provider = "System.Data.SqlClient";
                builder.ProviderConnectionString = AppConfigHelper.getConfPror("connectionStr");
                string databaseModel = "YukindieMdl"; // nombre del modelo de la base de datos
                builder.Metadata = $"res://*/{databaseModel}.csdl|res://*/{databaseModel}.ssdl|res://*/{databaseModel}.msl";
                _connectionString = builder.ToString();
            }
            return _connectionString;
        }


    }
}
