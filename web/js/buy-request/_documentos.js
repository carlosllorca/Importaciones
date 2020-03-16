$(function () {

})
function subirArchivo(id,expediente=false){


    if(expediente){
        $('#modal-content-documents').load(`/buy-request/upload-file-expedient?id=false&expediente=${expediente}`)
    }else{
        $('#modal-content-documents').load(`/buy-request/upload-file-expedient?id=${id}`)
    }
    $('#ajax-modal-documents').click();

}
function transportForm(id){

        $('#bodyTransport').load(`/buy-request/send-to-monitoring?id=${id}`)


}