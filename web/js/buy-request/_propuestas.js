$(function() {


    var urlParams = new URLSearchParams(window.location.search);
    if(urlParams.has('provider'))
    {
        showProvider(urlParams.get('provider'))
    }


})
function showForm(){
    $('#licitacion_form').removeClass('hidden');
    $('#no-data').addClass('hidden');
    $('#details-licitation').addClass('hidden');

}
function cancelarLicitacion(){
    $('#licitacion_form').addClass('hidden');
    $('#no-data').removeClass('hidden');
    $('#details-licitation').removeClass('hidden');

}
function showProvider(id){
    $('#view-content').removeClass('hidden');
    $('#view-content').load(`/buy-request/provider-details?id=${id}`)
}
function evaluateOffert(id){
    $('#modal-content').load(`/buy-request/evaluate-offert?id=${id}`);
    $('#ajax-modal').click();


}
function generateOffert(id){

    $('#modal-content').load(`/buy-request/save-ofert?id=${id}`);
    $('#ajax-modal').click();
}
function ganadores(id){

    $('#modal-content').load(`/buy-request/select-winners?id=${id}`,()=>{
       selectWinners()
    });
    $('#ajax-modal').click();


}
function selectWinners() {
    $('.check_provider').on('change', (event) => {
        let values = [];
        for (let i = 0; i < $('.check_provider').length; i++) {
            if ($($('.check_provider')[i]).is(':checked')) {
                values.push($($('.check_provider')[i]).attr('provider'))
            }
        }
        console.log(values)
        $('#select-ganadores').val(values)

    })
}