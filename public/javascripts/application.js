// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function validarArchivo(id){
    valid = true;
    if ($(id).value == null) {
        alert('Debes seleccionar un archivo que cargar');
        valid = false;
    }

    return valid;
}