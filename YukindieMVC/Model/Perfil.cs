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
    
    public partial class Perfil
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Perfil()
        {
            this.Album = new HashSet<Album>();
            this.Evento = new HashSet<Evento>();
            this.EventoPerfil = new HashSet<EventoPerfil>();
            this.LikeAlbum = new HashSet<LikeAlbum>();
            this.LikeCancion = new HashSet<LikeCancion>();
            this.LikeEvento = new HashSet<LikeEvento>();
            this.LikePerfil = new HashSet<LikePerfil>();
            this.LikePerfil1 = new HashSet<LikePerfil>();
            this.PerfilSociales = new HashSet<PerfilSociales>();
            this.Seguridad_RolPerfil = new HashSet<Seguridad_RolPerfil>();
        }
    
        public int PerfilId { get; set; }
        public int UsuarioId { get; set; }
        public Nullable<bool> Rol { get; set; }
        public int PerfilTipoId { get; set; }
        public string Nombre { get; set; }
        public string FotoPerfil { get; set; }
        public string AcercaDe { get; set; }
        public string Telefono { get; set; }
        public string Correo { get; set; }
        public string Direccion { get; set; }
        public string Horario { get; set; }
        public Nullable<System.DateTime> Fundacion { get; set; }
        public Nullable<int> CiudadId { get; set; }
        public string Latitud { get; set; }
        public string Longitud { get; set; }
        public string Presskit { get; set; }
        public string DescripcionCorta { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Album> Album { get; set; }
        public virtual Ciudad Ciudad { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Evento> Evento { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<EventoPerfil> EventoPerfil { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<LikeAlbum> LikeAlbum { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<LikeCancion> LikeCancion { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<LikeEvento> LikeEvento { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<LikePerfil> LikePerfil { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<LikePerfil> LikePerfil1 { get; set; }
        public virtual PerfilTipo PerfilTipo { get; set; }
        public virtual Usuario Usuario { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PerfilSociales> PerfilSociales { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Seguridad_RolPerfil> Seguridad_RolPerfil { get; set; }
    }
}
