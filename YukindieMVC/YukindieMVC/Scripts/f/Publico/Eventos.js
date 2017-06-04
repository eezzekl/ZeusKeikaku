$(document).ready(function () {
        //getCiudad();
        getEventoTipo();
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

            $('#cmbEventoTipo').multiselect('rebuild');
                    $('.multiselect-ui').multiselect({
        includeSelectAllOption: true
        });
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
                $('#cmbEventoTipo').append('<option value="' + Data.Datos[key].CiudadId + '">' + Data.Datos[key].Nombre + '</option>');
            }

            $("#cmbEventoTipo").attr('multiple', 'multiple');
            $("#cmbEventoTipo").multiselect();
        },
        error: function (data) {
            //CrearAlerta("#AlertIniciaSesion", "¡Acción Fallida!", "Acción no efectuada. Intente de nuevo, si el problema persiste contacte al Administrador del sistema.", "alert alert-danger");
        },
        complete: function () {
            //  DesbloquearForm("#frmLogin");
        }
    })
};