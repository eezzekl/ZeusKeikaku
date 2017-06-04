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

    getEventoTipo();
    getCiudad();
    LoadBandas();
    LoadTags();
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

    item.EventoId = 0; //Se pone 0 ya que al ser nuevo no tiene id
    item.Titulo = $('#txtTitulo').val();
    item.Imagen = '/rutadeprueba/.jpg';
    item.FechaEvento = $('#dpFechaEvento').val();
    item.Direccion = $('#txtDireccion').val();
    item.Establecimiento = $('#txtEstablecimiento').val();
    item.PrecioRegular = $('#txtPrecio').val();
    item.Promocion = $('#txtPromocion').val();
    item.Preventa = $('#txtPreventa').val();
    item.EventoTipo = { EventoTipoId : $('#cmbEventoTipo').val() };
    item.Ciudad = { CiudadId: $('#cmbCiudad').val() };
    item.Latitud = mapaLatitud;
    item.Longitud = mapaLongitud;
    item.LinkEventoFacebook = $('#txtLinkEventoFacebook').val();
    item.linkComprarBoleto = $('#txtLinkComprarBoleto').val();
    item.Estatus = true;
    item.Perfil = {PerfilId: PerfilId}

    var bandas = $('#txtTagBanda').textext()[0].tags()._formData;

    $.each(bandas, function (ind, elem) {
        item.lPerfil.push({ Nombre: elem });
    });

    var tags = $('#txtTagTag').textext()[0].tags()._formData;

    $.each(tags, function (ind, elem) {
        item.lTag.push({ Nombre: elem });
    });

    //limpiar tags http://cgit.drupalcode.org/block_class_tags/tree/jquery-textext/js/textext.plugin.clear.js?id=b4ef68e97ee57c27f34937bf37017449a9f852c6
    $('#txtTagTag').val('');

    $('#txtTagBanda').val('');

    //link video por eventos
    var group = $('input[name="mytext[]"]');

    if (group.length > 0) {
        group.each(function () {
            //var nombre = $(this).val(); //$(this).attr("name", $(this).attr("name") + "[]");
            item.lEventoVideo.push({ UrlVideo: $(this).val() })
        });
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
            showSuccess(Data.Mensaje);
            limpiar();
        },
        error: function (data) {
            //showErrorMessage(data);
        },
        complete: function () {
            //showSuccess(data);
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

function limpiar() {
    
    $('#txtTitulo').val('');
    var d = new Date();
    $('#dpFechaEvento').val(d.toLocaleDateString());
    $('#txtDireccion').val('');
    $('#txtEstablecimiento').val('');
    $('#txtPrecio').val('');
    $('#txtPromocion').val('');
    $('#txtPreventa').val('');
    //$('#cmbEventoTipo')[0].selectedIndex = 0;
    //$('#cmbCiudad').val()[0].selectedIndex = 0;
    $('#txtLinkEventoFacebook').val('');
    $('#txtLinkComprarBoleto').val('');


    //eliminamos los inputs creados para los videos
    //link video por eventos
    var group = $('input[name="mytext[]"]');

    //if (group.length > 0) {
    //    group.each(function () {
    //        //var nombre = $(this).val(); //$(this).attr("name", $(this).attr("name") + "[]");
    //        $(this).remove();
    //        x--;
    //    });
    //    $('.remove_field').remove();
    //}
    $('.dinamicurl').remove();
    x = 1;

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
        plugins: 'tags prompt focus filter autocomplete',
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