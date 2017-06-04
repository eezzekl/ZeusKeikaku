$(document).ready(function () {
    getEvento();
});

//metodo que retorna un album y lo asigna a los controles
function getEvento() {

    var contador = 0;
    $.ajax({
        url: urlGetAll,
        type: 'GET',
        dataType: "json",
        //data: { AlbumId: AlbumIdRef, Titulo: TituloRef, PerfilId: PerfilIdRef },
        success: function (Data) {
            debugger;
            var textoHtml = "";
            var iPage = 1; // bandera para mostrar data
            var iPageSize = Data.rpp; //numero de objetos a mostrar 
            //var asd = `{$asdas} sdsdfsd`;
            var valordei = ((iPage - 1) * iPageSize);
            var valordecount = (((iPage - 1) * iPageSize) + iPageSize);
            var tamanoarreglo = Data.Datos.length
            for (var i = ((iPage - 1) * iPageSize) ; i < (((iPage - 1) * iPageSize) + iPageSize) ; i++) {
                if (i === tamanoarreglo) {
                    break;
                }
                else {
                    textoHtml +=
                        //"<div class='col-md-12'>" +
                        //         "<div class='panel panel-yukindieEvento'>" +
                        //         "<div class='panel-body'>" +
                        //         "<div class='col-md-4'>" +
                        //         "<img src='\\Images\\"+Data.Datos[i].Imagen+"' class='thumbnail' alt='' width='100%'>" +
                        //         "</div>" +
                        //         "<div class='col-md-8'>" +
                        //         "<h3 class='margenh3'><strong><a href='PerfilDetalle.aspx'>" + Data.Datos[i].Titulo + "</a></strong></h3>" +
                        //         "<hr />" +
                        //         "<p class='parraf'><i class='fa fa-clock-o'></i> " + Data.Datos[i].FechaEventoTexto + "</p>" +
                        //         "<p class='parraf'><i class='fa fa-map-marker'></i> " + Data.Datos[i].Establecimiento + "</p>" +
                        //         "<p class='parraf'><strong><i class='fa fa-money'></i>" + Data.Datos[i].PrecioRegular + "</strong></p>" +
                        //         "<h4>" +
                        //         "<label class='label label-primary'>Concierto</label> " +
                        //         "<label class='label label-success'>" +
                        //         "Incluye Promoción" +
                        //         "</label>" +
                        //         "</h4>" +
                        //         "<p class='parraf'><strong>Descripción: </strong>Un gran evento que presenta el talento Yucateco en el mundo de la moda,  con la participación de diseñadores de alto nivel quienes presentan lo mejor de su colección Otoño-Invierno 2016</p>" +
                        //         "<hr />" +
                        //         "<a href='EventoDetalle.aspx?Id=1' class='btn btn-sm btn-yukindie'>Información & Tickets</a>" +
                        //         "</div>" +
                        //         "</div></div></div>"

                            "<hr />"+
                            "<div class='row'>"+
                            "<div class='col-md-3' align='center'>"+
                            "<img src='\\Images\\"+Data.Datos[i].Imagen+"' class='thumbnail' width='100%' />"+
                            "</div>"+
                            "<div class='col-md-6'>"+
                            "<h3><strong>"+Data.Datos[i].Titulo+"</strong></h3>" +
                            "<p class='parraf'><i class='fa fa-clock-o'></i> "+Data.Datos[i].FechaEventoTexto+"</p>"+
                            "<p class='parraf'><i class='fa fa-map-marker'></i> "+Data.Datos[i].Establecimiento+" · <strong>Mérida, Yucatán, México</strong></p>" +
                            "<p class='parraf'><i class='fa fa-usd'></i> " + Data.Datos[i].PrecioRegular + ".00</p>" +
                            "<h4>"+
                            "<label class='label label-primary'>Concierto</label> "+
                            "<label class='label label-success'>Incluye Promoción</label>"+
                            "</h4>"+
                            "</div>"+
                            "<div class='col-md-3'>"+
                            "<a href='/Event/Index/" + Data.Datos[i].Link + "' class='btn btn-sm btn-yukindie' style='width: 100%'>Información & Tickets</a>" +
                            "</div>"+
                            "</div>"
                }
            }

            $("#content").html(textoHtml)
            debugger;
            $('#page-selection').bootpag({
                total: Data.tp, // total de paginas a paginar
                page: 1,
                nextClass: 'next',
                prevClass: 'prev',
                lastClass: 'last',
                firstClass: 'first'
            }).on("page", function (event, /* page number here */ num) {
                debugger;
                var textoHtml = "";
                var iPage = num; // bandera para mostrar data
                var iPageSize = Data.rpp; //numero de objetos a mostrar
                //var asd = `{$asdas} sdsdfsd`;
                var valordei = ((iPage - 1) * iPageSize);
                var valordecount = (((iPage - 1) * iPageSize) + iPageSize);
                var tamanoarreglo = Data.Datos.length
                for (var i = ((iPage - 1) * iPageSize) ; i < (((iPage - 1) * iPageSize) + iPageSize) ; i++) {
                    if (i === tamanoarreglo) {
                        break;
                    }
                    else {
                        textoHtml +=
                            //"<div class='col-md-12'>" +
                            //         "<div class='panel panel-yukindieEvento'>" +
                            //         "<div class='panel-body'>" +
                            //         "<div class='col-md-4'>" +
                            //         "<img src='\\Images\\" + Data.Datos[i].Imagen + "' class='thumbnail' alt='' width='100%'>" +
                            //         "</div>" +
                            //         "<div class='col-md-8'>" +
                            //         "<h3 class='margenh3'><strong><a href='PerfilDetalle.aspx'>" + Data.Datos[i].Titulo + "</a></strong></h3>" +
                            //         "<hr />" +
                            //         "<p class='parraf'><i class='fa fa-clock-o'></i> " + Data.Datos[i].FechaEventoTexto + "</p>" +
                            //         "<p class='parraf'><i class='fa fa-map-marker'></i> " + Data.Datos[i].Establecimiento + "</p>" +
                            //         "<p class='parraf'><strong><i class='fa fa-money'></i>" + Data.Datos[i].PrecioRegular + "</strong></p>" +
                            //         "<h4>" +
                            //         "<label class='label label-primary'>Concierto</label> " +
                            //         "<label class='label label-success'>" +
                            //         "Incluye Promoción" +
                            //         "</label>" +
                            //         "</h4>" +
                            //         "<p class='parraf'><strong>Descripción: </strong>Un gran evento que presenta el talento Yucateco en el mundo de la moda,  con la participación de diseñadores de alto nivel quienes presentan lo mejor de su colección Otoño-Invierno 2016</p>" +
                            //         "<hr />" +
                            //         "<a href='EventoDetalle.aspx?Id=1' class='btn btn-sm btn-yukindie'>Información & Tickets</a>" +
                            //         "</div>" +
                            //         "</div></div></div>"

                            "<hr />" +
                            "<div class='row'>" +
                            "<div class='col-md-3' align='center'>" +
                            "<img src='\\Images\\" + Data.Datos[i].Imagen + "' class='thumbnail' width='100%' />" +
                            "</div>" +
                            "<div class='col-md-6'>" +
                            "<h3><strong>"+Data.Datos[i].Titulo+"</strong></h3>" +
                            "<p class='parraf'><i class='fa fa-clock-o'></i> " + Data.Datos[i].FechaEventoTexto + "</p>" +
                            "<p class='parraf'><i class='fa fa-map-marker'></i> " + Data.Datos[i].Establecimiento + " · <strong>Mérida, Yucatán, México</strong></p>" +
                            "<p class='parraf'><i class='fa fa-usd'></i> " + Data.Datos[i].PrecioRegular + ".00</p>" +
                            "<h4>" +
                            "<label class='label label-primary'>Concierto</label> " +
                            "<label class='label label-success'>Incluye Promoción</label>" +
                            "</h4>" +
                            "</div>" +
                            "<div class='col-md-3'>" +
                            "<a href='/Event/Index/"+Data.Datos[i].Link+"' class='btn btn-sm btn-yukindie' style='width: 100%'>Información & Tickets</a>" +
                            "</div>" +
                            "</div>"
                    }
                }

                // Item Display Logic c#
                //for (Int32 i = ((iPage - 1) * iPageSize); i < (((iPage - 1) * iPageSize) + iPageSize); i++)
                //{
                //    if (i >= l.Count)
                //        break;
                //    objStr.AppendLine(l[i]);
                //}
                //var textoHtml = "";
                //if (num == 1)
                //{
                //    i = 0;
                //}
                //else
                //{
                //    i = num;
                //}


                //for (var i = 0; i <num; i++) {

                //    textoHtml += "<div class='col-md-3'>" + "Página " + Data.Datos[contador].Descripcion + "</div>";
                //    contador++;
                //}
                $("#content").html(
                    textoHtml
                //    "Página " + Data.Datos[0].Descripcion + "<hr>"+
                //    "Página " + Data.Datos[1].Descripcion + "<hr>"+
                //"Página " + Data.Datos[2].Descripcion + "<hr>"+
                //"Página " + Data.Datos[3].Descripcion + "<hr>"+
                //"Página " + Data.Datos[4].Descripcion + "<hr>"
                    ) // some ajax content loading...
            });
            //debugger;
            //for (var key in Data.Datos) {
            //    $('#cmbSubGenero').append('<option value="' + Data.Datos[key].SubGeneroId + '">' + Data.Datos[key].Descripcion + '</option>');
            //}
        },
        error: function (data) {
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        },
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    })
};