//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class Evento
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Evento()
        {
            this.EventoPerfils = new HashSet<EventoPerfil>();
            this.EventoTags = new HashSet<EventoTag>();
            this.LikeEventoes = new HashSet<LikeEvento>();
        }
    
        public int EventoId { get; set; }
        public string Titulo { get; set; }
        public string Imagen { get; set; }
        public System.DateTime FechaEvento { get; set; }
        public string Direccion { get; set; }
        public string Establecimiento { get; set; }
        public Nullable<decimal> PrecioRegular { get; set; }
        public Nullable<decimal> PrecioPreventa { get; set; }
        public string Promocion { get; set; }
        public string Preventa { get; set; }
        public Nullable<int> EventoTipoId { get; set; }
        public Nullable<int> CiudadId { get; set; }
        public string Latitud { get; set; }
        public string Longitud { get; set; }
        public string LinkEventoFacebook { get; set; }
        public string LinkComprarBoleto { get; set; }
        public Nullable<bool> Estatus { get; set; }
        public Nullable<System.DateTime> FechaRegistro { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<EventoPerfil> EventoPerfils { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<EventoTag> EventoTags { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<LikeEvento> LikeEventoes { get; set; }
    }
}
