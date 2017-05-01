$(document).ready(function () {

});

function sbSuccess(element, data, contentType) {
    if (element.Logueo !== null && element.Logueo !== undefined) {
        switch (element.Logueo) {
            case 'OK':
                if (element.Configuracion === false) {
                    window.location.href = GetIndex;
                }
                else {
                    window.location.href = GetIndex;
                }
                showSuccess(element.result)
                break;
            case 'NO':
                showErrorMessage(element.result);
        }
    }
}

function Begin(element, data, contentType) {
    if (element.Logueo !== null && element.Logueo !== undefined) {
        switch (element.Logueo) {
            case 'OK':
                if (element.Configuracion === false) {
                    //window.location.href = '';
                }
                else {
                    //window.location.href = ''
                }
                showSuccess(element.result)
                break;
            case 'NO':
                showErrorMessage(element.result);
        }
    }
}

function sbErrorHandler(element, data, contentType) {

    showErrorMessage(contentType + ': ' + data);
}

function complete(element, data, contentType) {

}