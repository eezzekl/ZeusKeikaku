using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public partial class Album
    {
        public string FechaPublicacionTexto { get; set; }
        public List<Tag> LTag { get; set; }
    }
}
