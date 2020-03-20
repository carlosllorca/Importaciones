$(function () {

})
function subirArchivo(id,expediente=false){
    $('.modal-title').text('Subir documento');

    if(expediente){
        $('#modal-content-documents').load(`/buy-request/upload-file-expedient?id=false&expediente=${expediente}`)
    }else{
        $('#modal-content-documents').load(`/buy-request/upload-file-expedient?id=${id}`)
    }
    $('#ajax-modal-documents').click();

}
function transportForm(id){
    $('.modal-title').text('Enviar a seguimiento');

        $('#modal-content-documents').load(`/buy-request/send-to-monitoring?id=${id}`)
    $('#ajax-modal-documents').click();


}