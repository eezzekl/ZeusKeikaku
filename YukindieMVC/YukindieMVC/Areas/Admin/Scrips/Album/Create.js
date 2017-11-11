//se deben cargar los script en el render scripts del layout principal.
// si no marca error que no reconoce el $
$(document).ready(function () {
    getSubGenero();
    formFunctions();
});

/**
 * Metodo que obtiene los subgeneros y los agrega al combo de generos
 **/
function getSubGenero() {
    $.ajax({
        url: urlGetSubGenero,
        type: 'POST',
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
        var value = $('#chkOferta').prop('checked');
        if (value) {
            $("#txtOferta").val("0.00")
        }
        else {
            $("#txtOferta").val("")
        }
    });

    $('#chkSale').on('ifChanged', function () {
        if ($('#chkSale').prop('checked')) {
            $('#dvSale').show();
        }
        else {
            $('#dvSale').hide();
        }
    });
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

    var item = new Album();

    item.AlbumId = 0; //Se pone 0 ya que al ser nuevo no tiene id
    item.Titulo = $('#txtTitulo').val();
    item.Imagen = '/rutadeprueba/.jpg';
    item.FechaPublicacion = $('#dpFechaPublicacion').val();
    item.Formato = $('#cmbFormato').val();
    item.Contenido = $('#txtContenido').val();
    item.Precio = $('#txtPrecio').val();
    item.Oferta = $('#txtOferta').val();
    item.LinkCompra = $('#txtLinkCompra').val();
    item.Promocion = $('#txtPromocion').val();
    item.PerfilId = PerfilId;
    item.SubGenero = { SubGeneroId: $('#cmbSubGenero').val() };
    item.Estatus = true;
    item.FechaRegistro = $('#dpFechaPublicacion').val();
    item.UrlAlbumPrecargado = $('#txtUrlAlbum').val();
    item.UsarAlbumPrecargado = $('#chkUseAlbumExt').val();
    var tags = $('#textarea').textext()[0].tags()._formData;

    $.each(tags, function (ind, elem) {
        item.Ltag.push({nombre: elem});
    });
    formData.append("album", JSON.stringify(item));
    formData.append("valor1", "edwin gongora")

    $.ajax({
        url: urlGuardarAlbum,
        type: 'post',
        cache: false,
        contentType: false,
        processData: false,
        data: formData,
        success: function (Data) {
            $('#lblModifica').text("registro modificado");
            showSuccess(Data);
            //$(location).attr('href', urlListado);
        },
        error: function (data) {
            showErrorMessage(data);
        },
        complete: function () {
            showSuccess(data);
        }
    })

};

function ValidaForm() {
    if ($('#txtTitulo').val() == '') {
        showErrorMessage('El titulo es obligatorio');
        return false;
    }
    if ($('#dpFechaPublicacion').val()==''){
        showErrorMessage('La fecha de publicacion es obligatoria');
        return false;
    }

    if ($('#cmbSubGenero').val() == '') {
        showErrorMessage('Hubo un error con la conexion y no se guardaron los datos, Recarg la pagina e intenta nuevamente');
        return false;
    }
    return true;
}


function error(data) {
    showErrorMessage(data.msg)
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
    this.FechaRegistro = ''
    this.Ltag = [];
    this.UrlAlbumPrecargado = '', 
    this.UsarAlbumPrecargado = false
};

