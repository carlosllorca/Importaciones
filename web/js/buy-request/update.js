
function closeHito(id){
    renderAjaxForm('Actualizar Hito',`/buy-request/stage-success?id=${id}`)



}function updateHito(id){
    renderAjaxForm('Actualizar Hito',`/buy-request/stage-success?id=${id}&setSuccess=false`)



}