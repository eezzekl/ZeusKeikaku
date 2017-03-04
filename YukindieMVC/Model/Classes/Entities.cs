using System.Data.Entity;

namespace Model
{
    public partial class Entities : DbContext
    {
        /// <summary>
        /// Constructor del modelo que recibe una cadena de conexion.
        /// </summary>
        /// <param name="connectionString">Cadena de conexion</param>
        /// <history>
        /// [ecanul] 27/02/2017 Created
        /// </history>
        public Entities(string connectionString)
            : base(connectionString)
        {

        }
    }

}
