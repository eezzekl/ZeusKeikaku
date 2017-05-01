$(document).ready(function () {
    getEventoTipo();
    getCiudad();
    LoadBandas();
    LoadTags();
});

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
    //if (!ValidaForm())
    //    return;
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
    item.Latitud = '';
    item.Longitud = '';
    item.LinkEventoFacebook = $('#txtLinkEventoFacebook').val();
    item.linkComprarBoleto = $('#txtComprarBoleto').val();
    item.Estatus = true;
    item.FechaRegistro = $('#dpFechaEvento').val();
    item.Perfil = {PerfilId: PerfilId}

    var bandas = $('#textarea').textext()[0].tags()._formData;

    $.each(bandas, function (ind, elem) {
        item.lPerfil.push({ Nombre: elem });
    });

    var tags = $('#txtTagTag').textext()[0].tags()._formData;

    $.each(tags, function (ind, elem) {
        item.lTag.push({ Nombre: elem });
    });

    //link video por eventos
    var group = $('input[name="mytext[]"]');

    if (group.length > 1) {
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
            alert('Proceso Realizado Correctamente');
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

    $('#textarea')
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