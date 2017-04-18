using System.Data.Entity;

namespace Model
{
    /// <summary>
    /// Clase parcial del modelo para iniciar con una cadena de conexion tomada desde alguna parte del proyecto
    /// </summary>
    /// <history>
    /// [ecanul] 27/02/2017 created
    /// </history>
    public partial class Entities : DbContext 
    {
        /// <summary>
        /// Constructor que recibe la cadena de conexion
        /// </summary>
        /// <param name="connectionString">cadena de conexion</param>
        /// <history>
        /// [ecanul] 27/02/2017 Created
        /// </history>
        public Entities(string connectionString)
            : base (connectionString)
        {

        }
    }
}
