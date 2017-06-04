$(document).ready(function () {

    //para el checkbox de precio regular
    $("#chkEstablecimiento").on('ifChanged', function () {
        debugger;
        var value = $('#chkEstablecimiento').prop('checked');
        if (value) {
            //$("#txtEstablecimiento").val("Delorean Bar Santuario Sonoro")
            $.ajax({
                url: urlGetEstablecimiento,
                type: 'GET',
                dataType: "json",
                //data: { EventoTipoId: 0, Descripcion: "", Estatus: true },
                success: function (Data) {
                    debugger;
                    //for (var key in Data.Datos) {
                    //    $('#cmbEventoTipo').append('<option value="' + Data.Datos[key].EventoTipoId + '">' + Data.Datos[key].Descripcion + '</option>');
                    //}
                    $("#txtEstablecimiento").val(Data.Datos.Nombre)
                },
                error: function (data) {
                    //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
                },
                complete: function () {
                    //  DesbloquearForm("#frmLogin");
                }
            })
        }
        else {
            $("#txtEstablecimiento").val("")
        }
    });

    //para el checkbox de precio de oferta, cuando se selecciona se pone 0.00 por defecto en el textbox
    $("#chkDireccion").on('ifChanged', function () {
        debugger;
        var value = $('#chkDireccion').prop('checked');
        if (value) {
            $("#txtDireccion").val("calle 120")
        }
        else {
            $("#txtDireccion").val("")
        }
    });

    //para el checkbox de precio de oferta, cuando se selecciona se pone 0.00 por defecto en el textbox
    $("#chkPrecio").on('ifChanged', function () {
        debugger;
        var value = $('#chkPrecio').prop('checked');
        if (value) {
            $("#txtPrecio").val("0.00")
        }
        else {
            $("#txtPrecio").val("")
        }
    });

    initMap();

    getCiudad();
    LoadBandas();
    LoadTags();
    llenartags();
    //checar por que marca error la parte de http://localhost:15182/admin/evento/update/music/undefined al momento de cargar evento tipo
    LoadData();
    getEventoTipo();

});

/*******************APARTADO PARA EL AGREGADO DE MARKERS****************************/
var map;
var markers = [];

var marker;

var mapaLatitud;
var mapaLongitud;

function placeMarker(location) {
    if (marker) {
        marker.setPosition(location);
        marker.map = map;
    } else {
        marker = new google.maps.Marker({
            position: location,
            map: map
        });
    }

    mapaLatitud = marker.getPosition().lat();
    mapaLongitud = marker.getPosition().lng();

};

function initMap() {
    var haightAshbury = { lat: 20.962972208693014, lng: -89.66502189694438 };

    map = new google.maps.Map(document.getElementById('map'), {
        zoom: 15,
        center: haightAshbury,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });

    //var marker = new google.maps.Marker({
    //    position: haightAshbury,
    //    map: map
    //});



    // This event listener will call addMarker() when the map is clicked.
    map.addListener('click', function (event) {
        debugger;
        // esto permite agregar varios markers lo cual para nuestra
        // operacion necesitamos solamente 1
        //addMarker(event.latLng);
        placeMarker(event.latLng);
    });

    //// Adds a marker at the center of the map.
    //placeMarker(haightAshbury);

    //var infoWindow = new google.maps.InfoWindow({map: map});

    // Try HTML5 geolocation.
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };

            //infoWindow.setPosition(pos);
            //infoWindow.setContent('Location found.');
            map.setCenter(pos);
        }, function () {
            handleLocationError(true, infoWindow, map.getCenter());
        });
    } else {
        // Browser doesn't support Geolocation
        handleLocationError(false, infoWindow, map.getCenter());
    }
};


/*******************APARTADO DONDE TERMINA EL AGREGADO DE MARKERS*********************/

function getEventoTipo() {
    debugger;
    $.ajax({
        url: urlGetEventoTipo,
        type: 'GET',
        dataType: "json",
        data: { EventoTipoId: 0, Descripcion: "", Estatus: true },
        success: function (Data) {
            debugger;
            for (var key in Data.Datos) {
                $('#cmbEventoTipo').append('<option value="' + Data.Datos[key].EventoTipoId + '">' + Data.Datos[key].Descripcion + '</option>');
            }
        },
        error: function (data) {
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        },
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    })
};

function getCiudad() {
    debugger;
    $.ajax({
        url: urlGetCiudad,
        type: 'GET',
        dataType: "json",
        //data: { AlbumId: AlbumIdRef, Titulo: TituloRef, PerfilId: PerfilIdRef },
        success: function (Data) {
            debugger;
            for (var key in Data.Datos) {
                $('#cmbCiudad').append('<option value="' + Data.Datos[key].CiudadId + '">' + Data.Datos[key].Nombre + '</option>');
            }
        },
        error: function (data) {
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        },
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    })
};

/**
 * Funcion que valida los controles antes de guardar
 **/
function ValidaForm() {
    if ($('#txtTitulo').val() == '') {
        showErrorMessage('El Título es obligatorio');
        return false;
    }
    if ($('#dpFechaEvento').val() == '') {
        showErrorMessage('La Fecha de publicación es obligatoria');
        return false;
    }
    if ($('#txtEstablecimiento').val() == '') {
        showErrorMessage('El Establecimiento es obligatorio');
        return false;
    }
    if ($('#txtDireccion').val() == '') {
        showErrorMessage('La Dirección es obligatoria');
        return false;
    }
    if ($('#txtPrecio').val() == '') {
        showErrorMessage('El Precio es obligatorio');
        return false;
    }
    return true;
}

/**
 * Metodo que guarda un nuevo album
 **/
function guardar() {
    //si valida form regresa un falso nos salimos
    if (!ValidaForm())
        return;
    debugger;
    var formData = new FormData();
    var totalFiles = document.getElementById("FileUpload").files.length;
    for (var i = 0; i < totalFiles; i++) {
        var file = document.getElementById("FileUpload").files[i];

        formData.append("FileUpload", file);
    }

    var item = new Evento();

    item.EventoId = EventoId; //Se pone 0 ya que al ser nuevo no tiene id
    item.Titulo = $('#txtTitulo').val();
    item.Imagen = '/rutadeprueba/.jpg';
    item.FechaEvento = $('#dpFechaEvento').val();
    item.Direccion = $('#txtDireccion').val();
    item.Establecimiento = $('#txtEstablecimiento').val();
    item.PrecioRegular = $('#txtPrecio').val();
    item.Promocion = $('#txtPromocion').val();
    item.Preventa = $('#txtPreventa').val();
    item.EventoTipo = { EventoTipoId: $('#cmbEventoTipo').val() };
    item.Ciudad = { CiudadId: $('#cmbCiudad').val() };
    item.Latitud = mapaLatitud;
    item.Longitud = mapaLongitud;
    item.LinkEventoFacebook = $('#txtLinkEventoFacebook').val();
    item.linkComprarBoleto = $('#txtLinkComprarBoleto').val();
    item.Estatus = true;
    item.FechaRegistro = $('#dpFechaEvento').val();
    item.Perfil = { PerfilId: PerfilId }

    var bandas = $('#txtTagBanda').textext()[0].tags()._formData;

    $.each(bandas, function (ind, elem) {
        item.lPerfil.push({ Nombre: elem });
    });

    var tags = $('#txtTagTag').textext()[0].tags()._formData;

    $.each(tags, function (ind, elem) {
        item.lTag.push({ Nombre: elem });
    });

    //link video por eventos
    var group = $('input[name="mytext[]"]');

    if (group.length > 0) {
        group.each(function () {
            //var nombre = $(this).val(); //$(this).attr("name", $(this).attr("name") + "[]");
            item.lEventoVideo.push({ UrlVideo: $(this).val() })
        });

        //for (var key in group.length) {
        //    item.lEventoVideo.push({ UrlVideo: $(this).val() })
        //}
    }



    formData.append("evento", JSON.stringify(item));

    $.ajax({
        url: urlGuardarEvento,
        type: 'post',
        cache: false,
        contentType: false,
        processData: false,
        data: formData,
        success: function (Data) {
            //$('#lblModifica').text("registro modificado");
            //showSuccess(Data);
            //$(location).attr('href', urlListado);
            //alert('Proceso Realizado Correctamente');
            showSuccess(Data.Mensaje);
        },
        error: function (data) {
            //showErrorMessage(data);
        },
        complete: function () {
            //showSuccess(data);
        }
    })

};

//cargamos las bandas a la lista de sugerencias
function LoadBandas() {
    debugger;
    var list = [];

    $.ajax({
        url: urlGetBandas,
        type: 'GET',
        dataType: "json",
        //data: { AlbumId: AlbumIdRef, Titulo: TituloRef, PerfilId: PerfilIdRef },
        success: function (Data) {
            debugger;
            //$.each(Data.Datos.Nombre, function (ind, elem) {
            //    list.push(elem)
            //});

            for (var key in Data.Datos) {
                list.push(Data.Datos[key].Nombre)
                //$('#cmbCiudad').append('<option value="' + Data.Datos[key].CiudadId + '">' + Data.Datos[key].Nombre + '</option>');
            }
        },
        error: function (data) {
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        },
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    })

    $('#txtTagBanda')
    .textext({
        //plugins: 'tags autocomplete'
        //plugins : 'autocomplete filter tags ajax'
        //plugins: 'tags prompt focus filter autocomplete ',
        plugins: 'tags prompt focus autocomplete',
        prompt: 'Seleccionar...'//,
        //tagsItems: ['uno','dos']
        //ajax: {
        //    url: urlGetBandas,
        //    dataType: 'json',
        //    type: 'GET',
        //    cacheResults: true
        //}
    })
    .bind('getSuggestions', function (e, data) {
        //debugger;
        //list = [
        //        'Amperion',
        //        'akon',
        //        'Uberhate',
        //        'Vampiros_Leyenda_Urbana',
        //        'DWBD',
        //        'Matanza'
        //],
        //var list = data.Datos.Nombre;

        textext = $(e.target).textext()[0],
        query = (data ? data.query : '') || ''
        //query = data.query
        ;

        $(this).trigger(
            'setSuggestions',
            { result: textext.itemManager().filter(list, query) }
        );
    })
        //para evitar que se repitan bandas
    .bind('isTagAllowed', function (e, data) {
        var formData = $(e.target).textext()[0].tags()._formData,
            list = eval(formData);

        // duplicate checking
        if (formData.length && list.indexOf(data.tag) >= 0) {

            data.result = false;
        }
    });
    ;

};

//cargamos los tags a la lista de sugerencias
function LoadTags() {
    debugger;
    var list = [];

    $.ajax({
        url: urlGetTags,
        type: 'GET',
        dataType: "json",
        data: { TagId: 0, Nombre: "" },
        //data: { AlbumId: AlbumIdRef, Titulo: TituloRef, PerfilId: PerfilIdRef },
        success: function (Data) {
            debugger;
            //$.each(Data.Datos.Nombre, function (ind, elem) {
            //    list.push(elem)
            //});

            for (var key in Data.Datos) {
                list.push(Data.Datos[key].Nombre)
                //$('#cmbCiudad').append('<option value="' + Data.Datos[key].CiudadId + '">' + Data.Datos[key].Nombre + '</option>');
            }
        },
        error: function (data) {
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        },
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    })

    $('#txtTagTag')
    .textext({
        plugins: 'tags prompt focus autocomplete',
        prompt: 'Seleccionar...'//,
    })
    .bind('getSuggestions', function (e, data) {

        textext = $(e.target).textext()[0],
        query = (data ? data.query : '') || ''
        ;

        $(this).trigger(
            'setSuggestions',
            { result: textext.itemManager().filter(list, query) }
        );
    })
        //para evitar que se repitan bandas
    .bind('isTagAllowed', function (e, data) {
        var formData = $(e.target).textext()[0].tags()._formData,
            list = eval(formData);

        // duplicate checking
        if (formData.length && list.indexOf(data.tag) >= 0) {

            data.result = false;
        }
    });
    ;

};

//objeto Evento
var Evento = function () {
    this.AlbumId = 0;
    this.Titulo = '';
    this.Imagen = '';
    this.FechaEvento = '';
    this.Direccion = '';
    this.Establecimiento = '';
    this.PrecioRegular = 0;
    this.Promocion = 0;
    this.Preventa = '';
    this.EventoTipo = {};
    this.Ciudad = {};
    this.Latitud = '';
    this.Longitud = '';
    this.LinkEventoFacebook = '';
    this.linkComprarBoleto = '';
    this.Estatus = true;
    this.FechaRegistro = '';
    this.Perfil = {};
    this.lPerfil = [];
    this.lTag = [];
    this.lEventoVideo = [];
};

/**
 * Metodo que inicia los controles del formulario
 **/
function LoadData() {
    var EventoIdRef = EventoId;
    $.ajax({
        url: urlGet,
        type: 'Get',
        dataType: "json",
        data: { EventoId: EventoIdRef},
        success: function (Data) {
            debugger;
            //Asignamos el album encontrado a un temporal
            //OldEvento = Data.Datos;
            $('#cmbCiudad').val(Data.Datos.Ciudad.CiudadId);
            //$('#cmbCiudad').val("3");
            //$("#cmbCiudad option[value=3]").attr('selected', 'selected');
            //$('#txtClave').val(Data.Datos.AlbumId);
            $('#txtTitulo').val(Data.Datos.Titulo);
            //$('#dpFechaPublicacion').val(ObtenerFechaDeBD(Data.Datos.FechaPublicacion));
            $('#dpFechaEvento').datepicker("update", Data.Datos.FechaEventoTexto);
            (Data.Datos.Establecimiento === 0) ? $('#chkEstablecimiento').iCheck('check') : $('#chkEstablecimiento').iCheck('uncheck');
            $('#txtEstablecimiento').val(Data.Datos.Establecimiento);
            //Bandas sobre el escenario
            //etiquetas para el evento

            (Data.Datos.Direccion === 0) ? $('#chkDireccion').iCheck('check') : $('#chkDireccion').iCheck('uncheck');
            $('#txtDireccion').val(Data.Datos.Direccion);
            (Data.Datos.PrecioRegular === 0) ? $('#chkPrecio').iCheck('check') : $('#chkPrecio').iCheck('uncheck');
            $('#txtPrecio').val(Data.Datos.PrecioRegular);
            $('#cmbEventoTipo').val(Data.Datos.EventoTipo.EventoTipoId).prop('selected', true);
            (Data.Datos.Estatus === true) ? $('#chkEstatus').iCheck('check') : $('#chkEstatus').iCheck('uncheck');
            //avanzado
            $('#txtPromocion').val(Data.Datos.Promocion);
            $('#txtPreventa').val(Data.Datos.Preventa);
            $('#txtLinkEventoFacebook').val(Data.Datos.LinkEventoFacebook);
            $('#txtLinkComprarBoleto').val(Data.Datos.LinkComprarBoleto);
            //agregar marker a mapa
            var ubicacion = { lat: parseFloat(Data.Datos.Latitud), lng: parseFloat(Data.Datos.Longitud) };
            placeMarker(ubicacion);

            //$('#cmbCiudad').val(Data.Datos.Ciudad.CiudadId);
            //$('#txtContenido').val(Data.Datos.Contenido);
            //$('#txtLinkCompra').val(Data.Datos.LinkCompra);
            //(Data.Datos.Direccion === 0) ? $('#chkDireccion').iCheck('check') : $('#chkDireccion').iCheck('uncheck');
            //$('#txtPrecio').val(Data.Datos.Precio);
            //(Data.Datos.Establecimiento === 0) ? $('#chkEstablecimiento').iCheck('check') : $('#chkEstablecimiento').iCheck('uncheck');
            //$('#txtOferta').val(Data.Datos.Oferta);
            //$('#txtPromocion').val(Data.Datos.Promocion);
            //var tags = "";
            //$.each(Data.Datos.LTag, function (ind, elem) {
            //    tags += elem.nombre + " ";
            //});
            ////$('#textarea').text(tags);
            ////$('#textarea').val(tags);
            //LlenarTextArea(Data.Datos.LTag);
            //llenartags(Data.Datos.lTag.Nombre)
            var tags = [];
            $.each(Data.Datos.lEventoTag, function (ind, elem) {
                tags.push(elem.Tag.Nombre)
            });
            llenartags(tags)

            var bandas = [];
            $.each(Data.Datos.lEventoPerfil, function (ind, elem) {
                bandas.push(elem.Perfil.Nombre)
            });
            llenarbandas(bandas)

            //agregar las url dinamicamente
            $.each(Data.Datos.lEventoVideo, function (ind, elem) {
                if (x <= max_fields) { //max input box allowed
                    x++; //text box increment
                    $(wrapper).append('<div><input type="text" id="txtVideo' + x + '" class="form-control" name="mytext[]" placeholder="Url de Video" /><a href="#" class="remove_field">Eliminar</a></div>'); //add input box
                    $('#txtVideo' + x + '').val(elem.UrlVideo);
                }
            });
            //var strin = JSON.stringify(Data.Datos.lEventoTag.Tag.Nombre);
        },
        error: function (data) {
            showErrorMessage(data);
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        },
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    });
}

//funcion para el llenado de tags
function llenartags(arreglo) {
    $('#txtTagTag').textext()[0].tags().addTags(arreglo);

    //$('#textarea').textext(JSON.stringify(json))
}

//funcion para el llenado de bandas
function llenarbandas(arreglo) {
    $('#txtTagBanda').textext()[0].tags().addTags(arreglo);

    //$('#textarea').textext(JSON.stringify(json))
}