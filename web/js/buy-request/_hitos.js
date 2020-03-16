$(function () {

})
function closeHito(id){

    $('#modal-content-hitos').load(`/buy-request/stage-success?id=${id}`)
    $('#ajax-modal-hitos').click();


}function updateHito(id){

    $('#modal-content-hitos').load(`/buy-request/stage-success?id=${id}&setSuccess=false`)
    $('#ajax-modal-hitos').click();


}