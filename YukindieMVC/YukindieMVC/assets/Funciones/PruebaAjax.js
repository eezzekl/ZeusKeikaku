function prueba() {
    debugger;
    var Id = { val1: $("#txtTitulo").val() };
    $.ajax(
{
    type: "POST",
    //async: true,
    url: "GestionNuevoEvento.aspx/tieneDato",
    data: JSON.stringify(Id),
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    success: function(response)
    {
        debugger;
        showSuccess(response.d)
        //var resultAsJson = msg.d // your return result is JS array
        //// Now you can loop over the array to get each object
        //for(var i in resultAsJson)
        //{
        //    var user = resultAsJson[i]
        //    var user_name = user.User_Name
        //    // Here you append that value to your label
        //}
    },
    failure: function(response)
    {
        showErrorMessage(response.d)
    }
})
};