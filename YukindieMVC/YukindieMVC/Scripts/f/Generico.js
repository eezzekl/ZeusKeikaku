$(document).ready(function () {
    $('.datepickeres').datepicker({
        //format: "yyyy/mm/dd",
        //language: "es",
        //autoclose: true//,
        //todayHighlight: true
        format: "dd/mm/yyyy",
        //clearBtn: true,
        language: "es",
        daysOfWeekHighlighted: "0,6",
        autoclose: true,
        todayHighlight: true,
        minDate: 0,
        onClose: function (selectedDate) {
            $("#txtVigenciaFinal").datepicker("option", "minDate", selectedDate);
            //$(".active").attr('disabled', 'disabled');
            $(".active")
        }
    });
});

//obtiene la fecha formateada de un valor recibido de bd
function ObtenerFechaDeBD(fecha) {
    debugger;
    var fechaHoy = new Date(fecha);
    var dia = fechaHoy.getDay() < 10 ? '0' + fechaHoy.getDay() : fechaHoy.getDay();
    var mes = (fechaHoy.getMonth() + 1) < 10 ? '0' + (fechaHoy.getMonth() + 1) : (fechaHoy.getMonth() + 1);
    var anio = fechaHoy.getFullYear();
    var fechaCorta = dia + '/' + mes + '/' + anio;
    //if (esGenerico) {
    //    fechaCorta = mes + '/' + dia + '/' + anio;
    //}
    return fechaCorta;
}

//obtiene la fecha formateada de un valor recibido de bd
function ObtenerFechaDeBD2(fecha) {
    //debugger;
    //var fechaHoy = new Date(parseInt(date.substr(6)));
    //var dia = fechaHoy.getDay() < 10 ? '0' + fechaHoy.getDay() : fechaHoy.getDay();
    //var mes = (fechaHoy.getMonth() + 1) < 10 ? '0' + (fechaHoy.getMonth() + 1) : (fechaHoy.getMonth() + 1);
    //var anio = fechaHoy.getFullYear();
    //var fechaCorta = dia + '/' + mes + '/' + anio;
    ////if (esGenerico) {
    ////    fechaCorta = mes + '/' + dia + '/' + anio;
    ////}
    //return fechaCorta;

    var date = fecha;
    var nowDate = new Date(parseInt(date.substr(6)));
    var result = "";
    result = nowDate.format("dd/mm/yyyy");

    return result;
}

//metodo generico que redirecciona al index de cualquier catalogo del admin
function redireccionIndexAdmin() {
    href
};

function Redireccionar(Area,Controlador,Metodo, parameters) {
    if (parameters === null || parameters === "" || parameters === undefined) {
        parameters = "";
    }

    if (Controlador === null || Controlador === "" || Controlador === undefined) {
        Controlador = "Home"
    }
    if (Metodo === null || Metodo === "" || Metodo === undefined)
    {
        Metodo = "Index"
    }
    //window.location.hostname
    location.href = "http://localhost:15182/" + Area + "/" + Controlador + "/" + Metodo + "/" + parameters;
}