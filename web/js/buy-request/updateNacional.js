$(function () {
    selectWinners();

})
function renderAjaxForm(title,ajaxRequest){
    $('.modal-title').text(title);
    $('#modal-content-nacional').load(ajaxRequest,()=>{
        selectWinners();
    })
    $('#ajax-modal-nacional').click();
}
function selectWinners() {
    $('.check_provider').on('change', (event) => {
        let values = [];
        for (let i = 0; i < $('.check_provider').length; i++) {
            if ($($('.check_provider')[i]).is(':checked')) {
                values.push($($('.check_provider')[i]).attr('provider'))
            }
        }
        $('#select-ganadores').val(values)

    });
}
function subirArchivo(id,expediente=false){
    $('.modal-title').text('Subir documento');

    if(expediente){
        renderAjaxForm('Subir archivo',`/buy-request/upload-file-expedient?id=false&expediente=${expediente}`)
     //  # $('#modal-content-documents').load(`/buy-request/upload-file-expedient?id=false&expediente=${expediente}`)
    }else{
        renderAjaxForm('Subir archivo',`/buy-request/upload-file-expedient?id=${id}`)
   //    # $('#modal-content-documents').load()
    }
 //   $('#ajax-modal-documents').click();

}
function transportForm(id){
    renderAjaxForm('Enviar a seguimiento',`/buy-request/send-to-monitoring?id=${id}`)

}
function closeHito(id){
    renderAjaxForm('Actualizar Hito',`/buy-request/stage-success?id=${id}`)



}function updateHito(id){
    renderAjaxForm('Actualizar Hito',`/buy-request/stage-success?id=${id}&setSuccess=false`)



}