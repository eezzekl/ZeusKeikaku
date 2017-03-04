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

        $("#ContentPlaceHolder1_imgAlbum").fadeIn("fast").attr('src', URL.createObjectURL(event.target.files[0]));
        $("#disp_tmp_path").val(fileName);
        //$("#disp_tmp_path").html("Temporary Path(Copy it and try pasting it in browser address bar) --> <strong>[" + tmppath + "]</strong>");
    });

    //para el checkbox de precio regular
    $("#chkPrecio").on('ifChanged', function () {
        debugger;
        var value = $('#chkPrecio').prop('checked');
        if (value) {
            $("#ContentPlaceHolder1_txtPrecio").val("0.00")
        }
        else {
            $("#ContentPlaceHolder1_txtPrecio").val("")
        }
    });
});
