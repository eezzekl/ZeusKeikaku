/**
 * Inicia las actividades del JS
 * [ecanul] Created 29/06/2017 
 **/
$(document).ready(function () {
    if (albumid != '')
        getAlbum(); 
    else
        showErrorMessage('Especificar un Album');
});

/**
 * Inicia las actividades del JS
 * [ecanul] Created 29/06/2017 
 **/
function getAlbum() {
    $.ajax({
        url: urlGet,
        type: 'POST',
        dataType: "json",
        data: { AlbumId: albumid, PerfilId: perfilId, Titulo: '' },
        success: function (Data) {
            $('#lblTitulo').text(Data.Datos.Titulo);
            $("#imgAlbum").attr("src", Data.Datos.Imagen);
            $('#lblPrecio').text(Data.Datos.Precio);
            $('#lblOferta').text(Data.Datos.Oferta);
            $('#lblFechaPublicacion').text(Data.Datos.FechaPublicacionTexto);
            $('#lblFormato').text(Data.Datos.Formato);
            $('#lblContenido').text(Data.Datos.Contenido);
            $('#UrlAlbum').attr('href', Data.Datos.LinkCompra);
            $('#lblPromocion').text(Data.Datos.Promocion);

            if (Data.Datos.UsarAlbumPrecargado) {
                $('#dvLocalRep').hide();
                $('#dvExtRep').show();
                $('#dvExtRep').html(Data.Datos.UrlAlbumPrecargado);
            }
            else {
                $('#dvExtRep').hide();
                $('#dvLocalRep').show();
                //Metodo llenar album con las canciones. Crearlo 
            }

            //Metodos extras
            //getPerfil(Data.Datos.PerfilId);
        },
        error: function (data) {
            showErrorMessage(data);
        }
    });
}
