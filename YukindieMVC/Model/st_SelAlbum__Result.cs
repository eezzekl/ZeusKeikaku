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
    
    public partial class st_SelAlbum__Result
    {
        public int AlbumId { get; set; }
        public string Titulo { get; set; }
        public string Imagen { get; set; }
        public System.DateTime FechaPublicacion { get; set; }
        public string Formato { get; set; }
        public string Contenido { get; set; }
        public decimal Precio { get; set; }
        public decimal Oferta { get; set; }
        public string LinkCompra { get; set; }
        public string Promocion { get; set; }
        public int PerfilId { get; set; }
        public int SubGeneroId { get; set; }
        public Nullable<bool> Estatus { get; set; }
        public string SubGenero { get; set; }
        public bool UsarAlbumPrecargado { get; set; }
        public string UrlAlbumPrecargado { get; set; }
    }
}
