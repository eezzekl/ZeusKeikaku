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
    
    public partial class st_SelEvento_Result
    {
        public int EventoId { get; set; }
        public string Titulo { get; set; }
        public string Imagen { get; set; }
        public System.DateTime FechaEvento { get; set; }
        public string Direccion { get; set; }
        public string Establecimiento { get; set; }
        public Nullable<decimal> PrecioRegular { get; set; }
        public string Promocion { get; set; }
        public Nullable<decimal> Preventa { get; set; }
        public Nullable<int> EventoTipoId { get; set; }
        public Nullable<int> CiudadId { get; set; }
        public string Latitud { get; set; }
        public string Longitud { get; set; }
        public string LinkEventoFacebook { get; set; }
        public string LinkComprarBoleto { get; set; }
        public Nullable<bool> Estatus { get; set; }
        public int PerfilId { get; set; }
        public string TipoEvento { get; set; }
    }
}
