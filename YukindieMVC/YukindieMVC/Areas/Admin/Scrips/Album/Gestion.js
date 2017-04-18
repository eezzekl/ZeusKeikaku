var OldAlbum;

/**
 * Metodo que se inicia al terminar de cargar el documento 
 **/
$(document).ready(function () {
    getSubGenero();
    formFunctions();
    initForm();
});

/**
 * Metodo que obtiene los subgeneros y los agrega al combo de generos
 **/
function getSubGenero() {
    $.ajax({
        url: urlGetSubGenero,
        type: 'POST',
        dataType: "json",
        success: function (Data) {
            for (var key in Data.Datos) {
                $('#cmbSubGenero').append('<option value="' + Data.Datos[key].SubGeneroId + '">' + Data.Datos[key].Descripcion + '</option>');
            }
        },
        error: function (data) {
            showErrorMessage(data);
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        },
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    })
};

/**
 * Metodo que agrega las funcionalidades de los controles del formulario
 **/
function formFunctions() {
    //para el checkbox de precio regular
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
    //para el checkbox de precio de oferta, cuando se selecciona se pone 0.00 por defecto en el textbox
    $("#chkOferta").on('ifChanged', function () {
        debugger;
        var value = $('#chkOferta').prop('checked');
        if (value) {
            $("#txtOferta").val("0.00")
        }
        else {
            $("#txtOferta").val("")
        }
    });
}

/**
 * Metodo que inicia los controles del formulario
 **/
function initForm() {
    var AlbumIdRef = AlbumId;
    var PerfilIdRef = PerfilId;
    $.ajax({
        url: urlGet,
        type: 'POST',
        dataType: "json",
        data: { AlbumId: AlbumIdRef, PerfilId: PerfilIdRef, Titulo: '' },
        success: function (Data) {
            //Asignamos el album encontrado a un temporal
            OldAlbum = Data.Datos;
            $('#txtClave').val(Data.Datos.AlbumId);
            $('#txtTitulo').val(Data.Datos.Titulo);
            //$('#dpFechaPublicacion').val(ObtenerFechaDeBD(Data.Datos.FechaPublicacion));
            $('#dpFechaPublicacion').datepicker("update", Data.Datos.FechaPublicacionTexto);
            $('#cmbSubGenero').val(Data.Datos.SubGenero.SubGeneroId);
            (Data.Datos.Estatus === true) ? $('#chkEstatus').iCheck('check') : $('#chkEstatus').iCheck('uncheck');
            $('#cmbFormato').val(Data.Datos.Formato);
            $('#txtContenido').val(Data.Datos.Contenido);
            $('#txtLinkCompra').val(Data.Datos.LinkCompra);
            (Data.Datos.Precio === 0) ? $('#chkPrecio').iCheck('check') : $('#chkPrecio').iCheck('uncheck');
            $('#txtPrecio').val(Data.Datos.Precio);
            (Data.Datos.Oferta === 0) ? $('#chkOferta').iCheck('check') : $('#chkOferta').iCheck('uncheck');
            $('#txtOferta').val(Data.Datos.Oferta);
            $('#txtPromocion').val(Data.Datos.Promocion);
            var tags = "";
            $.each(Data.Datos.LTag, function (ind, elem) {
                tags+= elem.nombre + " ";
            });
            //$('#textarea').text(tags);
            //$('#textarea').val(tags);
            LlenarTextArea(Data.Datos.LTag);
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

/**
 * Funcion que valida los controles antes de guardar
 **/
function ValidaForm() {
    if ($('#txtTitulo').val() == '') {
        showErrorMessage('El titulo es obligatorio');
        return false;
    }
    if ($('#dpFechaPublicacion').val() == '') {
        showErrorMessage('La fecha de publicacion es obligatoria');
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

    var formData = new FormData();
    var totalFiles = document.getElementById("FileUpload").files.length;
    for (var i = 0; i < totalFiles; i++) {
        var file = document.getElementById("FileUpload").files[i];

        formData.append("FileUpload", file);
    }

    var album = new Album();
    //Sino tiene archivios
    if (totalFiles <= 0)
        //Se asigna la imagen anterior
        album.Imagen = OldAlbum.Imagen;
    else
        album.Imagen = '/rutadeprueba/1.jpg';
    //var Album = new Album();

    album.AlbumId = album.AlbumId;
    album.Titulo = $('#txtTitulo').val();    
    album.FechaPublicacion = $('#dpFechaPublicacion').val();
    album.Formato = $('#cmbFormato').val();
    album.Contenido = $('#txtContenido').val();
    album.Precio = $('#txtPrecio').val();
    album.Oferta = $('#txtOferta').val();
    album.LinkCompra = $('#txtLinkCompra').val();
    album.Promocion = $('#txtPromocion').val();
    album.PerfilId = PerfilId;
    album.SubGenero = { SubGeneroId: $('#cmbSubGenero').val() };
    album.Estatus = true;
    album.FechaRegistro = $('#dpFechaPublicacion').val();
    var tags = $('#textarea').textext()[0].tags()._formData;

    $.each(tags, function (ind, elem) {
        album.Ltag.push({ nombre: elem });
    });
    formData.append("album", JSON.stringify(album));

    $.ajax({
        url: urlGuardarAlbum,
        type: 'post',
        cache: false,
        contentType: false,
        processData: false,
        data: formData,
        success: function (Data) {
            $('#lblModifica').text("registro modificado");
            showSuccess(Data.Message);
        },
        error: function (Data) {
            showErrorMessage(Data);
        },
        complete: function (Data) {
            showErrorMessage(Data.responseText);
        }
    })

}


function LlenarTextArea(item )
{
    var tags = [];
    $.each(item, function (ind, elem) {
        tags.push(elem.nombre)
    });
    $('#textarea')
        .textext({
            //plugins: 'tags autocomplete'
            //plugins : 'autocomplete filter tags ajax'
            //plugins: 'tags prompt focus filter autocomplete ',
            plugins: 'tags prompt focus autocomplete ',
            prompt: 'Agregar Artistas...',
            tagsItems: tags
        })
        .bind('getSuggestions', function (e, data) {
            var list = [
                    'Amperion',
                    'akon',
                    'Uberhate',
                    'Vampiros_Leyenda_Urbana',
                    'DWBD',
                    'Matanza'
            ],
                textext = $(e.target).textext()[0],
                query = (data ? data.query : '') || ''
            //query = data.query
            ;

            $(this).trigger(
                'setSuggestions',
                { result: textext.itemManager().filter(list, query) }
            );
        });
}

//objeto Album
var Album = function () {
    this.AlbumId = 0;
    this.Titulo = '';
    this.Imagen = '';
    this.FechaPublicacion = '';
    this.Formato = '';
    this.Contenido = '';
    this.Precio = 0;
    this.Oferta = 0;
    this.LinkCompra = '';
    this.Promocion = 0;
    this.PerfilId = 0;
    this.SubGenero = {};
    this.Estatus = true;
    this.FechaRegistro = '';
    this.Ltag = [];
};
