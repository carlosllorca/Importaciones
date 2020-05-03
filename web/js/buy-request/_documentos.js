$(function () {

})
function subirArchivo(id,expediente=false){


    if(expediente){
        renderAjaxForm('Subir documento',`/buy-request/upload-file-expedient?id=false&expediente=${expediente}`)

    }else{
        renderAjaxForm('Subir documento',`/buy-request/upload-file-expedient?id=${id}`)

    }


}
function transportForm(id){

    renderAjaxForm('Enviar a seguimiento',`/buy-request/send-to-monitoring?id=${id}`)



}