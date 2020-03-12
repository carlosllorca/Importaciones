$(function () {

})
function uploadFileExpedient(id,expediente=false){
    if(expediente){
        $('#bodyUploadFile').load(`/buy-request/upload-file-expedient?id=false&expediente=${expediente}`)
    }else{
        $('#bodyUploadFile').load(`/buy-request/upload-file-expedient?id=${id}`)
    }

}
function transportForm(id){

        $('#bodyTransport').load(`/buy-request/send-to-monitoring?id=${id}`)


}