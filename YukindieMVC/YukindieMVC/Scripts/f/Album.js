//se deben cargar los script en el render scripts del layout principal.
// si no marca error que no reconoce el $
$(document).ready(function () {

    //$('.claseFecha').datepicker({
    //    todayBtn: true,
    //    language: "es",
    //    autoclose: true,
    //    todayHighlight: true
    //});
    if (AlbumId === 0) {

    }
    else {
        getOne('');
    }
    getSubGenero();
    //para el checkbox de precio regular, cuando se selecciona se pone 0.00 por defecto en el textbox
    //$("#chkPrecio").on('ifChanged', function () {
    //    debugger;
    //    var value = $('#chkPrecio').prop('checked');
    //    if (value) {
    //        $("#txtPrecio").val("0.00")
    //    }
    //    else {
    //        $("#txtPrecio").val("")
    //    }
    //});

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
function getOne(TituloRef) {
    debugger;
    var AlbumIdRef = AlbumId;
    var PerfilIdRef = PerfilId;
    $.ajax({
        url: urlGet,
        type: 'POST',
        dataType: "json",
        data: { AlbumId: AlbumIdRef, Titulo: TituloRef, PerfilId: PerfilIdRef },
        success: function (Data) {
            debugger;
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
        },
        error: function (data) {
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        },
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    })
};

//metodo que retorna un album y lo asigna a los controles
function getSubGenero() {
    debugger;
    $.ajax({
        url: urlGetSubGenero,
        type: 'POST',
        dataType: "json",
        //data: { AlbumId: AlbumIdRef, Titulo: TituloRef, PerfilId: PerfilIdRef },
        success: function (Data) {
            debugger;
            for (var key in Data.Datos) {
                $('#cmbSubGenero').append('<option value="' + Data.Datos[key].SubGeneroId + '">' + Data.Datos[key].Descripcion + '</option>');
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
    formData.append("valor1","edwin gongora")

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

