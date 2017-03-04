/// <reference path="../plugins/icheck/icheck.min.js" />

//function showImage() {
//    debugger;
//    // Get File Upload Path & File Name
//    var file = $("#FileUploadControl");
//    //var file = document.getElementById("FileUploadControl");
//    // Set Image Url from FileUploader Control
//    //document.getElementById("Image1").src = file.value;
//    $("#imgEvento").attr("src") = file.val()
//    // Display Selected File Path & Name
//    //alert("You selected " + file.value);
//    // Get File Size From Selected File in File Uploader Control 
//    //var inputFile = document.getElementById("FileUpload1").files[0].size;
//    // Displaty Selected File Size
//    //alert("File size: " + inputFile.toString());
//}



$(document).ready(function () {

    $('#ContentPlaceHolder1_uploadImage').on('change',function (event) {
        debugger;   
        var tmppath = URL.createObjectURL(event.target.files[0]);

        var files = event.target.files;
        var fileName = files[0].name;

        $("#ContentPlaceHolder1_imgEvento").fadeIn("fast").attr('src', URL.createObjectURL(event.target.files[0]));
        $("#disp_tmp_path").val(fileName);
        //$("#disp_tmp_path").html("Temporary Path(Copy it and try pasting it in browser address bar) --> <strong>[" + tmppath + "]</strong>");
    });

    //para el checkbox de dirección
    $("#chkDireccion").on('ifChanged', function () {    
        debugger;
        var value = $('#chkDireccion').prop('checked');
        if (value) {
            $("#ContentPlaceHolder1_txtDireccion").val("Calle 120a # 450 colonia Juan Pablo")
        }
        else {
            $("#ContentPlaceHolder1_txtDireccion").val("")
        }
    });

    //para el checkbox de establecimiento
    $("#chkEstablecimiento").on('ifChanged', function () {
        debugger;
        var value = $('#chkEstablecimiento').prop('checked');
        if (value) {
            $("#ContentPlaceHolder1_txtEstablecimiento").val("Delorean Bar Santuario Sonoro")
        }
        else {
            $("#ContentPlaceHolder1_txtEstablecimiento").val("")
        }
    });

    //para el checkbox de precio regular
    $("#chkPrecioRegular").on('ifChanged', function () {
        debugger;
        var value = $('#chkPrecioRegular').prop('checked');
        if (value) {
            $("#ContentPlaceHolder1_txtPrecioRegular").val("0.00")
        }
        else {
            $("#ContentPlaceHolder1_txtPrecioRegular").val("")
        }
    });

    //para el checkbox de precio preventa check normal
    //$("#chkPrecioPreventa").change(function (event) {
    //    debugger;
    //    var value = $('#chkPrecioPreventa').prop('checked');
    //    if (value) {
    //        $("#txtPrecioPreventa").val("$ 0.00")
    //    }
    //    else {
    //        $("#txtPrecioPreventa").val("")
    //    }
    //});

    $('#chkPrecioPreventa').on('ifChanged', function () {
        //alert('Well done, Sir');
        debugger;
            var value = $('#chkPrecioPreventa').prop('checked');
            if (value) {
                $("#ContentPlaceHolder1_txtPrecioPreventa").val("0.00")
            }
            else {
                $("#ContentPlaceHolder1_txtPrecioPreventa").val("")
            }
    });

    $('#chkGM').on('ifChanged', function () {
        //alert('Well done, Sir');
        debugger;
        //20.962972208693014, 
        var value = $('#chkGM').prop('checked');
        if (value) {
            var location = { lat: 20.962972208693014, lng: -89.66502189694438 };
            placeMarker(location)
        }
        else {
            marker.setMap(null);
            marker = null;
        }
    });

    //cargarCiudad();
});

//function CHeck() {
//    //var ChkBox = document.getElementById("chkDireccion");
//    //alert($('#chkDireccion').prop('checked'));
//    var value = $('#chkDireccion').prop('checked');
//    if(value)
//    {
//        $("#txtDireccion").val("Calle 120a # 450 colonia Juan Pablo")
//    }
//    else {
//        $("#txtDireccion").val("")
//    }
//}

//cargar ciudad
function cargarCiudad() {
    $.ajax({
        url: 'GestionNuevoEvento.aspx/cargarCiudad',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //var d = data.d.split('');
            //$.each(JSON.parse(data.d), function (i, item) {
            //    //$.each(item, function (key, val) {
            //        $('<option value="' + item.id + '">' + item.nombre + '</option>').appendTo('#cmbCiudad');
            //    //});
            //});

            for (var i = 0; i < data.d.length; i++) {
                $('<option value="' + data.d[i].id + '">' + data.d[i].nombre + '</option>').appendTo('#ContentPlaceHolder1_cmbCiudad');
            }
        },
        error: function () {
            console.log('err')
        }
    });
};

/*******************OBJETOS**********************/
var Evento = function () {
    this.id = 0;
    this.titulo = '';
    this.imagen = '';
    this.fechaEvento = '';
    this.direccion = '';
    this.establecimiento = '';
    this.precioRegular = 0.00;
    this.precioPreventa = 0.00;
    this.promocion = '';
    this.preventas = '';
    this.idEventoTipo = {};
    this.idCiudad = {};
    this.estatus = true;
    this.idUsuarioCuenta = {};
    this.ubicacionGoogleMaps = '';
    this.linkEventoFacebook = '';
    this.linkComprarBoletos = '';
};

/*************************************************/

function guardar() {
    debugger;
    var evento = new Evento();
    evento.id = 0;//$("#txtClave").val();
    evento.titulo = $("#txtTitulo").val();
    evento.imagen = $("#disp_tmp_path").val();
    evento.fechaEvento = $("#dpFecha").val();
    evento.direccion = $("#txtDireccion").val();
    evento.establecimiento = $("#txtEstablecimiento").val();
    evento.precioRegular = $("#txtPrecioRegular").val();
    evento.precioPreventa = $("#txtPrecioPreventa").val();
    evento.promocion = $("#txtPromocion").val();
    evento.preventas = $("#txtPreventas").val();
    evento.idEventoTipo = { id: $("#cmbCiudad").val() }
    evento.idCiudad = { id: $("#cmbCiudad").val() };
    evento.estatus = true;
    evento.idUsuarioCuenta = { id: 2 };
    evento.ubicacionGoogleMaps = $("#txtLat").val() + ',' + $("#txtLon").val();;
    evento.linkEventoFacebook = $("#txtLinkEventoFacebook").val();
    evento.linkComprarBoletos = $("#txtLinkCompraLinea").val();

    var Id = { jsonArray: JSON.stringify(evento) };

    $.ajax({
        url: "GestionNuevoEvento.aspx/agregarEvento",
        data: JSON.stringify(Id),
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
        debugger;
        //showSuccess(response.d)
        //var resultAsJson = msg.d // your return result is JS array
        //// Now you can loop over the array to get each object
        //for(var i in resultAsJson)
        //{
        //    var user = resultAsJson[i]
        //    var user_name = user.User_Name
        //    // Here you append that value to your label
        //}
    },
        error: function (response) {
            console.log(response)
        //showErrorMessage(response.d)
    }
    }).done(function (response) {
        showSuccess(response.d)
    });

};
