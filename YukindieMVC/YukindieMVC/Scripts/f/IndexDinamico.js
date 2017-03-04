// init bootpag
//$('#page-selection').bootpag({
//    total: 10
//}).on("page", function (event, /* page number here */ num) {
//    $("#content").html("Página " + num); // some ajax content loading...
//});

$(document).ready(function () {
    getSubGenero()
});

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
            $('#page-selection').bootpag({
                total: 3
            }).on("page", function (event, /* page number here */ num) {
                debugger;
                var textoHtml = "";
                for (var i = num-1; i <= num; i++) {
                    textoHtml  += "<div class='col-md-3'>"+"Página " + Data.Datos[i].Descripcion + "</div>";
                }
                $("#content").html(
                    textoHtml
                //    "Página " + Data.Datos[0].Descripcion + "<hr>"+
                //    "Página " + Data.Datos[1].Descripcion + "<hr>"+
                //"Página " + Data.Datos[2].Descripcion + "<hr>"+
                //"Página " + Data.Datos[3].Descripcion + "<hr>"+
                //"Página " + Data.Datos[4].Descripcion + "<hr>"
                    ) // some ajax content loading...
            });
            //debugger;
            //for (var key in Data.Datos) {
            //    $('#cmbSubGenero').append('<option value="' + Data.Datos[key].SubGeneroId + '">' + Data.Datos[key].Descripcion + '</option>');
            //}
        },
        error: function (data) {
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        },
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    })
};