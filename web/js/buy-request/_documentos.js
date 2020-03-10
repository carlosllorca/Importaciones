$(function () {

})
function uploadFileExpedient(id,expediente=false){
    if(expediente){
        $('#bodyUploadFile').load(`/buy-request/upload-file-expedient?id=false&expediente=${expediente}`)
    }else{
        $('#bodyUploadFile').load(`/buy-request/upload-file-expedient?id=${id}`)
    }

}