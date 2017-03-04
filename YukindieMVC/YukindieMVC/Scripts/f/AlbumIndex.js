var editor; // use a global for the submit and return data rendering in the examples

$(document).ready(function () {
    debugger;

    //editor = new $.fn.dataTable.Editor({
    //    "ajax": urlGetAll,
    //    "table": "#tblEmployee",
    //    "fields": [{
    //        "label": "AlbumId",
    //        "name": "AlbumId"
    //    }, {
    //        "label": "Titulo",
    //        "name": "Titulo"
    //    }
    //    //, {
    //    //    "label": "Position:",
    //    //    "name": "position"
    //    //}, {
    //    //    "label": "Office:",
    //    //    "name": "office"
    //    //}, {
    //    //    "label": "Extension:",
    //    //    "name": "extn"
    //    //}, {
    //    //    "label": "Start date:",
    //    //    "name": "start_date",
    //    //    "type": "datetime"
    //    //}, {
    //    //    "label": "Salary:",
    //    //    "name": "salary"
    //    //}
    //    ]
    //});


    var table = $('#tblEmployee').DataTable({
        "searching": true,
        "ordering": true,
        "pagingType": "full_numbers",
        //"ajax": urlGetAll,
        "ajax": {
            "url": urlGetAll
            //"dataSrc":"",
            //"type": "POST"
        },
        "columns": [
            { "data": "AlbumId" },
            { "data": "Titulo" },
                        { "data": "Formato" },
            { "data": "Contenido" },
            { "data": "Precio" },
                        {
                            data: "Opciones",
                            className: "center",
                            defaultContent: '<a href="" class="editor_edit btn btn-yukindie">Editar</a> <a href="" class="editor_remove btn btn-yukindie">Eliminar</a>'
                        }

            //{ "data": "Formato" },
            //{ "data": "Contenido" },
            //{ "data": "Precio" },
            //{ "data": "Oferta" },
            //{ "data": "LinkCompra" }
        ],
        select: true
    });

    // Edit record
    $('#tblEmployee').on('click', 'a.editor_edit', function (e) {
        e.preventDefault();
        debugger;
        //var table = $('#tblEmployee').DataTable();
        //var idx = table.cell('.selected', 0).index();
        //var data = table.row(idx.row).data();
        var data = table.row($(this).parents('tr')).data();
        //alert(data.AlbumId + " su titulo es: " + data.Titulo);
        Redireccionar('Admin','Album','Gestion',data.AlbumId)

        //editor.edit($(this).closest('tr'), {
        //    title: 'Edit record',
        //    buttons: 'Update'
        //});
    });

    // Delete a record
    $('#tblEmployee').on('click', 'a.editor_remove', function (e) {
        e.preventDefault();

        alert('vas a ganar')
        //editor.remove($(this).closest('tr'), {
        //    title: 'Delete record',
        //    message: 'Are you sure you wish to remove this record?',
        //    buttons: 'Delete'
        //});
    });
});