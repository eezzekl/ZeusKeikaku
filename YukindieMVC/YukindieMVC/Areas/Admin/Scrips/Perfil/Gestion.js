$(document).ready(function () {
    if (PerfilId != 0)
        FillForm();
});

$("#cmbTipoCuenta").change(function () {
    changeLabels($("#cmbTipoCuenta").val());
})

function changeLabels(tipoPerfil) {
    switch (tipoPerfil) {
        case "1": //Fan
            $('#lblFundacion').text("Fecha de Nacimiento");
            $("#dvEstablecimiento").hide();
            break; 
        case "2": //Banda
            $('#lblFundacion').text("Fecha de Creacion");
            $("#dvEstablecimiento").hide();
            break;
        case "3"://Empresa
            $('#lblFundacion').text("Fecha de Fundacion");
            $("#dvEstablecimiento").show();
            break;
    }
}

function FillForm() {
    $.ajax({
        url: urlGetPerfil,
        type: 'GET',
        dataType: 'json',
        data: { PerfilId: PerfilId },
        success: function (Data) {
            $('#txtNombre').val(Data.Datos.Nombre);
            $('#Fundacion').val(Data.Datos.Fundacion);
            $('#txtTelefono').val(Data.Datos.Telefono);
            $('#cmbTipoCuenta').val(Data.Datos.TipoPerfil);
            $('#cmbCiudad').val(Data.Datos.CiudadId);
            $('#txtCorreo').val(Data.Datos.Correo);
            $('#txtAcerca').val(Data.Datos.AcercaDe);
            $('#txtDireccion').val(Data.Datos.Direccion);
            $('#txtHorarios').val(Data.Datos.Horario);
            $('#txtLatitud').val(Data.Datos.Latitud);
            $('#txtLongitud').val(Data.Datos.Longitud);
            $.each(Data.Datos.SocialMedia, function (index, value) {
                switch (value.RedSocial) {
                    case "Facebook":
                        $('#txtFacebook').val(value.Url);
                        break;
                    case "Youtube":
                        $('#txtYoutube').val(value.Url);
                        break;
                    case "Twitter":
                        $('#txtTwitter').val(value.Url);
                        break;
                    case "SoundCloud":
                        $('#txtSoundCloud').val(value.Url);
                        break;
                    case "Instagram":
                        $('#txtInstagram').val(value.Url);
                        break;
                    case "Web":
                        $('#txtWeb').val(value.Url);
                        break;

                }
            });
        },
        error: function (data) {
            showErrorMessage(data);
        }        
    });
}

function save() {
    var formData = new FormData();

    //Si tiene un archivo o mas se toma el 1o
    if (document.getElementById("filFoto").files.length > 0) {
        var foto = document.getElementById("filFoto").files[0];
        formData.append("filFoto", foto);
    }
    var item = new Perfil();
    //si PerfilId tiene algo se usara este perfil
    if (PerfilId != 0)
        item.PerfilId = PerfilId;
    item.UsuarioId = 1; //Debe tomarse de la sesion , buscar como 
    item.PerfilTipoId = TipoPerfil;
    item.Nombre = $('#txtNombre').val();
    item.Fundacion = $('#txtFundacion').val();
    item.Telefono = $('#txtTelefono').val();
    item.Ciudad = { CiudadId: $('#cmbCiudad').val() };
    item.Correo = $('#txtCorreo').val();
    item.AcercaDe = $("#txtAcerca").val();
    item.Direccion = $('#txtDireccion').val() != '' ? $('#txtDireccion').val() : item.Direccion;
    item.Horario = $('#txtHorarios').val() != '' ? $('#txtHorarios').val() : item.Horario;
    item.Latitud = '2';
    item.Longitud = '1';
    if ($('#txtFacebook').val() != '')
        item.SocialMedia.push({ RedSocial: 'Facebook', Url: $('#txtFacebook').val() });
    if ($('#txtYoutube').val() != '')
        item.SocialMedia.push({ RedSocial: 'Youtube', Url: $('#txtYoutube').val() });
    if ($('#txtTwitter').val() != '')
        item.SocialMedia.push({ RedSocial: 'Twitter', Url: $('#txtTwitter').val() });
    if ($('#txtSoundCloud').val() != '')
        item.SocialMedia.push({ RedSocial: 'SoundCloud', Url: $('#txtSoundCloud').val() });
    if ($('#txtInstagram').val() != '')
        item.SocialMedia.push({ RedSocial: 'Instagram', Url: $('#txtInstagram').val() });
    if ($('#txtWeb').val() != '')
        item.SocialMedia.push({ RedSocial: 'Web', Url: $('#txtWeb').val() });

    formData.append("item", JSON.stringify(item));

    $.ajax({
        url: urlSave,
        type: 'post',
        cache: false,
        contentType: false,
        processData: false,
        data: formData,
        success: function (Data) {
            //$('#lblModifica').text("registro modificado");
            showSuccess(Data.message);
            //$(location).attr('href', urlListado);
        },
        error: function (data) {
            showErrorMessage(data.message);
        },
        complete: function () {
            showSuccess(data);
        }
    });
}

var Perfil = function () {
    this.PerfilId = 0;
    this.UsuarioId = 0;
    this.Rol = 1;
    this.PerfilTipoId = 1;
    this.Nombre = "";
    this.FotoPerfil = "";
    this.AcercaDe = '';
    this.Telefono = '';
    this.Correo = '';
    this.Direccion = '';
    this.Horario = '';
    this.Fundacion = '';
    this.Ciudad = {};
    this.Latitud = '';
    this.Longitud = '';
    this.Presskit = '';
    this.DescripcionCorta = '';
    this.SocialMedia = [];
};