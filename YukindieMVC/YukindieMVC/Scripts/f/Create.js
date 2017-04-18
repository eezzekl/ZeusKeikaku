//se deben cargar los script en el render scripts del layout principal.
// si no marca error que no reconoce el $
$(document).ready(function () {
    debugger;
    getSubGenero();

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
});

//metodo que retorna un album y lo asigna a los controles
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
        error: error (data) /*{
            showErrorMessage(data.msg)
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        }*/,
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    })
};

function guardar() {
    debugger;

    var formData = new FormData();
    var totalFiles = document.getElementById("FileUpload").files.length;
    for (var i = 0; i < totalFiles; i++) {
        var file = document.getElementById("FileUpload").files[i];

        formData.append("FileUpload", file);
    }

    var item = new Album();

    item.AlbumId = (AlbumId === 0) ? 0 : $('#txtClave').val();
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

    formData.append("album", JSON.stringify(item));
    formData.append("valor1", "edwin gongora")

    $.ajax({
        url: urlGuardarAlbum,
        //type: 'POST',
        //dataType: "json",
        //data: { album: item, img : formData },
        type: 'post',
        cache: false,
        contentType: false,
        processData: false,
        data: formData,
        //contentType: true,
        //processData: false,
        success: function (Data) {
            alert(Data.Mensaje);
            $('#lblModifica').text("registro modificado");
        },
        error: function (data) {
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        },
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    })

};

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
};

