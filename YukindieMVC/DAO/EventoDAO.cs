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
        public static Evento GetOne(int EventoTipoId, DateTime? FechaInicial, DateTime? FechaFinal, decimal Precio, int TipoOrdenamiento, bool Estatus)
        {
            try
            {
                Model.Evento itemEvento = new Model.Evento();
                List<EventoPerfil> litemEventoPerfil = new List<EventoPerfil>();
                List<EventoTag> litemEventoTag = new List<EventoTag>();
                List<EventoVideo> litemEventoVideo = new List<EventoVideo>();

                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    itemEvento = db.st_SelEvento(EventoTipoId, FechaInicial, FechaFinal, Precio, TipoOrdenamiento, Estatus)
                        .Select(x => new Evento
                        {
                            EventoId = x.EventoId,
                            Titulo = x.Titulo,
                            Imagen = x.Imagen,
                            FechaEvento = x.FechaEvento,
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
                        ).FirstOrDefault();

                    //AHORA LLENAMOS EVENTOPERFIL
                    if (itemEvento != null)
                    {
                        litemEventoPerfil = db.st_SelEventoPerfil(0, itemEvento.EventoId, 0)
                            .Select(x => new EventoPerfil
                            {
                                EventoPerfilId = x.EventoPerfilId,
                                EventoId = x.EventoId,
                                PerfilId = x.PerfilId
                            }).ToList();

                        litemEventoTag = db.st_SelEventoTag(0, 0, itemEvento.EventoId)
                            .Select(x => new EventoTag
                            {
                                EventoTagId = x.EventoTagId,
                                TagId = x.TagId,
                                EventoId = x.EventoId
                            }).ToList();

                        litemEventoVideo = db.st_SelEventoVideo(0, itemEvento.EventoId, null)
                            .Select(x => new EventoVideo
                            {
                                EventoVideoId = x.EventoVideoId,
                                EventoId = x.EventoId,
                                UrlVideo = x.UrlVideo
                            }).ToList();
                    }
                }

                return itemEvento;
            }
            catch (EntityException ex)
            {
                //Devuelve el valor arrojado por cliente de entity framework (Es mas detallado que el error que obtiene .net por si solo
                throw ex;
            }
        }

        public static List<Evento> Get(int EventoTipoId, DateTime? FechaInicial, DateTime? FechaFinal, decimal Precio, int TipoOrdenamiento, bool Estatus)
        {
            try
            {
                List<Model.Evento> litemEvento = new List<Model.Evento>();
                List<EventoPerfil> litemEventoPerfil = new List<EventoPerfil>();
                List<EventoTag> litemEventoTag = new List<EventoTag>();
                List<EventoVideo> litemEventoVideo = new List<EventoVideo>();

                using (var db = new Entities(ConnectionStringHelper.ConnectionString()))
                {
                    litemEvento = db.st_SelEvento(EventoTipoId, FechaInicial, FechaFinal, Precio, TipoOrdenamiento, Estatus)
                        .Select(x => new Evento
                        {
                            EventoId = x.EventoId,
                            Titulo = x.Titulo,
                            Imagen = x.Imagen,
                            FechaEvento = x.FechaEvento,
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

        public static void Save(Model.Evento item)
        {
            // si necesitamos que un procedure devuelva el valor de un id hacemos esto
            //https://social.msdn.microsoft.com/Forums/en-US/5e56547d-75f0-4688-8069-8328de24f332/error-when-calling-a-stored-procedure?forum=adodotnetentityframework
            // si no sabemos como activar la ventana checamos esto
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

                            //string box = ("edwin" != null) ? toy.ToString() : "";

                            int eventoid = (item.EventoId>0)?item.EventoId:Convert.ToInt32(EventoId.Value);

                            //int evento = item.eve

                            //item.EventoId = Convert.ToInt32(EventoId.Value);

                            //TRABAJADMOS CON EVENTOPERFIL
                            //eliminamos los tags de EventoPerfil que tenga asignado

                            if (item.lPerfil != null)
                            {
                                if (item.lPerfil.Count > 0)
                                {
                                    foreach (Perfil EP in item.lPerfil)
                                    {
                                        //System.Data.Entity.Core.Objects.ObjectParameter PerfilId = new System.Data.Entity.Core.Objects.ObjectParameter("PerfilId", EP.PerfilId);
                                        db.st_InsEventoPerfil(eventoid,
                                                              EP.Nombre);
                                    }
                                }
                            }

                            // TRABAJAMOS CON EVENTOTAG

                            if (item.lTag != null)
                            {
                                if (item.lTag.Count > 0)
                                {
                                    foreach (Tag ET in item.lTag)
                                    {
                                        //System.Data.Entity.Core.Objects.ObjectParameter TagId = new System.Data.Entity.Core.Objects.ObjectParameter("TagId", ET.TagId);
                                        db.st_InsEventoTag(eventoid, ET.Nombre );
                                    }
                                }
                            }

                            // TRABAJAMOS CON EVENTOVIDEO

                            if (item.lEventoVideo != null)
                            {
                                if (item.lEventoVideo.Count > 0)
                                {
                                    foreach (EventoVideo EV in item.lEventoVideo)
                                    {
                                        db.st_InsEventoVideo(eventoid,
                                                             EV.UrlVideo
                                                             );
                                    }

                                    //System.Data.Entity.Core.Objects.ObjectParameter  = new System.Data.Entity.Core.Objects.ObjectParameter("TagId", ET.TagId);
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
