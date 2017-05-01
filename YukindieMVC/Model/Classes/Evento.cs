using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public partial class Evento
    {
        public List<EventoPerfil > lEventoPerfil { get; set; }
        public List<EventoTag> lEventoTag { get; set; }
        //public List<EventoTipo> lEventoTipo { get; set; }
        public List<EventoVideo> lEventoVideo { get; set; }

        public List<Perfil> lPerfil { get; set; }
        public List<Tag> lTag { get; set; }
    }
}
