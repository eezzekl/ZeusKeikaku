﻿$(document).ready(function () {
    initMap();
    $("#cmbTipoCuenta").change(function () {
        changeLabels($("#cmbTipoCuenta").val());
    });
    $("#cmbTipoCuenta").val(TipoPerfil);
    
    CKEDITOR.replace('txtAcerca');
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
/*MAPA*/
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

    // This event listener will call addMarker() when the map is clicked.
    map.addListener('click', function (event) {
        placeMarker(event.latLng);
    });

    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };
            map.setCenter(pos);
        }, function () {
            handleLocationError(true, infoWindow, map.getCenter());
        });
    } else {
        // Browser doesn't support Geolocation
        handleLocationError(false, infoWindow, map.getCenter());
    }
};

/*Fin Mapa*/

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
    item.AcercaDe = CKEDITOR.instances.txtAcerca.getData(); // $("#txtAcerca").val();
    item.Direccion = $('#txtDireccion').val() != '' ? $('#txtDireccion').val() : item.Direccion;
    item.Horario = $('#txtHorarios').val() != '' ? $('#txtHorarios').val() : item.Horario;
    item.Latitud = mapaLatitud;
    item.Longitud = mapaLongitud;
    item.Facebook = $('#txtFacebook').val();
    item.Youtube = $('#txtYoutube').val();
    item.Twitter = $('#txtTwitter').val();
    item.SoundCloud = $('#txtSoundCloud').val();
    item.Instagram = $('#txtInstagram').val();
    item.Web = $('#txtWeb').val();

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
    this.Facebook = '';
    this.Twitter = '';
    this.Instagram = '';
    this.Youtube = '';
    this.SoundCloud = '';
    this.Web = '';
};