using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.Classes;
using Model;
using System.Data.Entity.Core;
using System.Transactions;

namespace DAO
{
    public class EventoDAO
    {
        //transaccion sql server entities
        //https://msdn.microsoft.com/en-us/data/dn456843.aspx
        //https://msdn.microsoft.com/en-us/library/dn456843(v=vs.113).aspx
        //http://stackoverflow.com/questions/11194143/entity-framework-how-to-put-multiple-stored-procedures-in-a-transaction
        //https://softwareengineering.stackexchange.com/questions/278165/executing-stored-procedure-in-entityframework-on-savechanges
        //http://www.c-sharpcorner.com/UploadFile/ff2f08/working-with-transaction-in-entity-framework-6-0/

        //public static List<Model.Evento> GetData(int EventoTipoId, DateTime? FechaInicial, DateTime? FechaFinal, decimal Precio, int TipoOrdenamiento, bool Estatus)
        //{
        //    try
        //    {
        //        List<Model.Evento> litem = new List<Model.Evento>();
        //        using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
        //        {
        //            litem = db.st_SelEvento(EventoTipoId, FechaInicial, FechaFinal, Precio, TipoOrdenamiento, Estatus)
        //                .Select(x => new Evento
        //                {
        //                    EventoId = x.EventoId,
        //                    Titulo = x.Titulo,
        //                    Imagen = x.Imagen,
        //                    FechaEvento = x.FechaEvento,
        //                    Direccion = x.Direccion,
        //                    Establecimiento = x.Establecimiento,
        //                    PrecioRegular = x.PrecioRegular,
        //                    Promocion = x.Promocion,
        //                    Preventa = x.Preventa,
        //                    CiudadId = new Ciudad
        //                    {
        //                        CiudadId = (Int32)x.CiudadId
        //                    },
        //                    Latitud = x.Latitud,
        //                    Longitud = x.Longitud,
        //                    LinkEventoFacebook = x.LinkEventoFacebook,
        //                    LinkComprarBoleto = x.LinkComprarBoleto,
        //                    Estatus = x.Estatus,
        //                    PerfilId = x.PerfilId,
        //                    EventoTipoId = new EventoTipo
        //                    {
        //                        EventoTipoId = (Int32)x.EventoTipoId,
        //                        Descripcion = x.TipoEvento
        //                    },
        //                }
        //                ).ToList();
        //        }

        //        return litem;
        //    }
        //    catch (EntityException ex)
        //    {
        //        //Devuelve el valor arrojado por cliente de entity framework (Es mas detallado que el error que obtiene .net por si solo
        //        throw ex;
        //    }
        //}

        // vendria siendo un get one
        //alldata es una bandera si es true traemos aparte del evento todos las tablas ligadas como eventoperfil, eventovideo,eventotag
        // de lo contrario solo cargamos la tabla evento
        public static List<Evento> GetData(int EventoId = 0, DateTime? FechaInicial = null, DateTime? FechaFinal = null, decimal Precio = 0, int TipoOrdenamiento = 0, bool Estatus = false, bool allData = false)
        {
            try
            {
                Utilerias utileria = new Utilerias();
                List<Model.Evento> litemEvento = new List<Model.Evento>();
                List<EventoPerfil> litemEventoPerfil = new List<EventoPerfil>();
                List<EventoTag> litemEventoTag = new List<EventoTag>();
                List<EventoVideo> litemEventoVideo = new List<EventoVideo>();

                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    litemEvento = db.st_SelEvento(EventoId, FechaInicial, FechaFinal, Precio, TipoOrdenamiento, Estatus)
                        .Select(x => new Evento
                        {
                            EventoId = x.EventoId,
                            Titulo = x.Titulo,
                            Imagen = x.Imagen,
                            FechaEvento = x.FechaEvento,
                            //FechaEventoTexto = x.FechaEvento.ToString("dd/mm/yyyy"),
                            FechaEventoTexto = x.FechaEvento.ToString("dd, MMM - yyyy · HH:mm tt").ToUpper().Replace(".", ""),
                            Direccion = x.Direccion,
                            Establecimiento = x.Establecimiento,
                            PrecioRegular = x.PrecioRegular,
                            Promocion = x.Promocion,
                            Preventa = x.Preventa,
                            Ciudad = new Ciudad
                            {
                                CiudadId = (Int32)x.CiudadId
                            },
                            Latitud = x.Latitud,
                            Longitud = x.Longitud,
                            LinkEventoFacebook = x.LinkEventoFacebook,
                            LinkComprarBoleto = x.LinkComprarBoleto,
                            Estatus = x.Estatus,
                            Perfil = new Perfil
                            {
                                PerfilId = x.PerfilId,
                                Nombre = x.Nombre,
                                Telefono = x.Telefono,
                                Correo = x.Correo,
                                FotoPerfil = x.FotoPerfil,
                                DescripcionCorta = x.DescripcionCorta
                            },
                            EventoTipo = new EventoTipo
                            {
                                EventoTipoId = (Int32)x.EventoTipoId,
                                Descripcion = x.TipoEvento
                            },
                            //para cuando necesitemos la url de nuestro evento
                            Link = string.Format("{0}/{1}", x.EventoId, utileria.GenerateSlug(x.Titulo))
                        }).ToList();


                    //AHORA LLENAMOS EVENTOPERFIL
                    if (litemEvento != null)
                    {
                        if (allData)
                        {
                            litemEvento[0].lEventoPerfil = db.st_SelEventoPerfil(0, litemEvento[0].EventoId, 0)
                                .Select(x => new EventoPerfil
                                {
                                    EventoPerfilId = x.EventoPerfilId,
                                    EventoId = x.EventoId,
                                    Perfil = new Perfil
                                    {
                                        PerfilId = x.PerfilId,
                                        Nombre = x.Nombre
                                    }
                                }).ToList();

                            //litemEventoTag = db.st_SelEventoTag(0, 0, itemEvento.EventoId)
                            litemEvento[0].lEventoTag = db.st_SelEventoTag(0, 0, litemEvento[0].EventoId)
                                .Select(x => new EventoTag
                                {
                                    EventoTagId = x.EventoTagId,
                                    TagId = x.TagId,
                                    EventoId = x.EventoId,
                                    Tag = new Tag
                                    {
                                        TagId = (Int32)x.TagId,
                                        Nombre = x.Nombre
                                    }

                                }).ToList();

                            //litemEventoVideo = db.st_SelEventoVideo(0, itemEvento.EventoId, null)
                            litemEvento[0].lEventoVideo = db.st_SelEventoVideo(0, litemEvento[0].EventoId, null)
                            .Select(x => new EventoVideo
                            {
                                EventoVideoId = x.EventoVideoId,
                                EventoId = x.EventoId,
                                UrlVideo = x.UrlVideo
                            }).ToList();
                        }
                    }
                }

                return litemEvento;
            }
            catch (EntityException ex)
            {
                //Devuelve el valor arrojado por cliente de entity framework (Es mas detallado que el error que obtiene .net por si solo
                throw ex;
            }
        }

        public static List<Evento> Get(int EventoId, DateTime? FechaInicial, DateTime? FechaFinal, decimal Precio, int TipoOrdenamiento, bool Estatus)
        {
            try
            {
                List<Model.Evento> litemEvento = new List<Model.Evento>();
                List<EventoPerfil> litemEventoPerfil = new List<EventoPerfil>();
                List<EventoTag> litemEventoTag = new List<EventoTag>();
                List<EventoVideo> litemEventoVideo = new List<EventoVideo>();

                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    litemEvento = db.st_SelEvento(EventoId, FechaInicial, FechaFinal, Precio, TipoOrdenamiento, Estatus)
                        .Select(x => new Evento
                        {
                            EventoId = x.EventoId,
                            Titulo = x.Titulo,
                            Imagen = x.Imagen,
                            FechaEventoTexto = x.FechaEvento.ToString("dd/mm/yyyy"),//x.FechaEvento,
                            Direccion = x.Direccion,
                            Establecimiento = x.Establecimiento,
                            PrecioRegular = x.PrecioRegular,
                            Promocion = x.Promocion,
                            Preventa = x.Preventa,
                            Ciudad = new Ciudad
                            {
                                CiudadId = (Int32)x.CiudadId
                            },
                            Latitud = x.Latitud,
                            Longitud = x.Longitud,
                            LinkEventoFacebook = x.LinkEventoFacebook,
                            LinkComprarBoleto = x.LinkComprarBoleto,
                            Estatus = x.Estatus,
                            Perfil = new Perfil
                            {
                                PerfilId = x.PerfilId
                            },
                            EventoTipo = new EventoTipo
                            {
                                EventoTipoId = (Int32)x.EventoTipoId,
                                Descripcion = x.TipoEvento
                            },
                        }
                        ).ToList();
                }

                return litemEvento;
            }
            catch (EntityException ex)
            {
                //Devuelve el valor arrojado por cliente de entity framework (Es mas detallado que el error que obtiene .net por si solo
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //metodo que recibe la url que escribe el usuario en las cajas de texto y si es valida y de youtube o vimeo nos retorna 
        //la url embebida para paginas web
        public static string getUrlEmbed(string urlUsuario)
        {
            string retorno = string.Empty;
            try
            {
                if (urlUsuario.IndexOf("https://vimeo.com") != -1)
                {
                    string[] arreglo = urlUsuario.Split('/');
                    retorno = string.Format(@"<iframe src='https://player.vimeo.com/video/{0}' width='100%' height='400' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>", arreglo[3]);
                }
                else if (urlUsuario.IndexOf("https://www.youtube.com") != -1)
                {
                    string[] arreglo = urlUsuario.Split('=');
                    retorno = string.Format(@"<iframe width='100%' height='400' src='https://www.youtube.com/embed/{0}' frameborder='0' allowfullscreen></iframe>", arreglo[1]);
                }
                return retorno;
            }
            catch (Exception ex)
            {
                return retorno;
            }
        }

        public static void Save(Evento item)
        {
            // si necesitamos que un procedure devuelva el valor de un id hacemos esto
            //https://social.msdn.microsoft.com/Forums/en-US/5e56547d-75f0-4688-8069-8328de24f332/error-when-calling-a-stored-procedure?forum=adodotnetentityframework
            // si no sabemos como activar la ventana  del link de arriba checamos esto
            //http://stackoverflow.com/questions/3729920/cant-find-ado-net-entity-model-browser-window-in-vs2010

            TransactionOptions options = new TransactionOptions();
            options.IsolationLevel = IsolationLevel.ReadCommitted;
            options.Timeout = new TimeSpan(0, 5, 0);
            try
            {
                using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required, options))
                {
                    System.Data.Entity.Core.Objects.ObjectParameter EventoId = new System.Data.Entity.Core.Objects.ObjectParameter("EventoId", item.EventoId);
                    using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                    {
                        try
                        {
                            db.st_InsEvento(EventoId,
                                            item.Titulo,
                                            item.Imagen,
                                            item.FechaEvento,
                                            item.Direccion,
                                            item.Establecimiento,
                                            item.PrecioRegular,
                                            item.Promocion,
                                            item.Preventa,
                                            item.EventoTipo.EventoTipoId,
                                            item.Ciudad.CiudadId,
                                            item.Latitud,
                                            item.Longitud,
                                            item.LinkEventoFacebook,
                                            item.LinkComprarBoleto,
                                            item.Estatus,
                                            item.Perfil.PerfilId
                                            );

                            int eventoid = (item.EventoId > 0) ? item.EventoId : Convert.ToInt32(EventoId.Value);

                            //TRABAJADMOS CON EVENTOPERFIL
                            //eliminamos los tags de EventoPerfil que tenga asignado

                            if (item.lPerfil != null)
                            {
                                if (item.lPerfil.Count > 0)
                                {
                                    //eliminamos las bandas que este evento tenga asignado

                                    db.st_DelEventoPerfil(eventoid, 3);

                                    foreach (Perfil EP in item.lPerfil)
                                    {
                                        // validamos si la banda existe en la lista de perfil
                                        var banda = db.Perfil.Where(x => x.Nombre == EP.Nombre && x.PerfilTipoId == 2).FirstOrDefault();
                                        // si existe entonces insertamos normalmente
                                        if (banda != null)
                                        {
                                            // podemos corregir en el sp que no tome el nombre si no que del resultado de linq
                                            //asignamos el id (banda.perfilId)
                                            db.st_InsEventoPerfil(eventoid,
                                                                  EP.Nombre);
                                        }
                                        //si no existe significa que burlaron el jquery y no debemos insertar.
                                    }
                                }
                            }

                            // TRABAJAMOS CON EVENTOTAG

                            if (item.lTag != null)
                            {
                                if (item.lTag.Count > 0)
                                {
                                    //eliminamos los tags que este evento tenga asignado
                                    db.st_DelEventoTag(eventoid, 3);

                                    foreach (Tag ET in item.lTag)
                                    {
                                        // validamos si el tag existe en la lista de tags
                                        var tag = db.Tag.Where(x => x.Nombre == ET.Nombre).FirstOrDefault();
                                        //si no existe entonces significa que es un tag nuevo lo insertamos en la tabla tags
                                        if (tag == null)
                                        {
                                            TagDAO.Save(ET);
                                            //System.Data.Entity.Core.Objects.ObjectParameter TagId = new System.Data.Entity.Core.Objects.ObjectParameter("TagId", ET.TagId);
                                            //db.st_InsEventoTag(eventoid, ET.Nombre);
                                        }
                                        db.st_InsEventoTag(eventoid, ET.Nombre);
                                        //// si existe entonces significa que el tag existe y solo insertamos la relacion
                                        //else
                                        //{
                                        //    //System.Data.Entity.Core.Objects.ObjectParameter TagId = new System.Data.Entity.Core.Objects.ObjectParameter("TagId", ET.TagId);
                                        //    db.st_InsEventoTag(eventoid, ET.Nombre);
                                        //}
                                    }
                                }
                            }

                            // TRABAJAMOS CON EVENTOVIDEO

                            if (item.lEventoVideo != null)
                            {
                                if (item.lEventoVideo.Count > 0)
                                {
                                    //eliminamos los videos que este evento tenga asignado
                                    db.st_DelEventoVideo(eventoid, 3);

                                    foreach (EventoVideo EV in item.lEventoVideo)
                                    {
                                        if (!String.IsNullOrWhiteSpace(EV.UrlVideo))
                                        {
                                            string urlformato = getUrlEmbed(EV.UrlVideo);
                                            if (!String.IsNullOrWhiteSpace(urlformato))
                                            {
                                                db.st_InsEventoVideo(eventoid, urlformato);
                                            }
                                        }
                                    }
                                }
                            }
                            scope.Complete();
                        }
                        catch (Exception ex)
                        {
                            scope.Dispose();
                            throw ex;
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }
    }
}
