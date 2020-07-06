$(function() {


    var urlParams = new URLSearchParams(window.location.search);
    if(urlParams.has('provider'))
    {
        showProvider(urlParams.get('provider'))
    }

    modifyProviders();


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
    renderAjaxForm('Evaluar oferta',`/buy-request/evaluate-offert?id=${id}`)

}
function generateOffert(id){
    renderAjaxForm('Genear oferta',`/buy-request/save-ofert?id=${id}`)


}
function ganadores(id){
    renderAjaxForm('Seleccionar ganador',`/buy-request/select-winners?id=${id}`)

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
function modifyProviders() {
    $('.provider_item').on('change', (event) => {

        let values = [];
        for (let i = 0; i < $('.provider_item').length; i++) {
            if ($($('.provider_item')[i]).is(':checked')) {
                values.push($($('.provider_item')[i]).attr('provider'))
            }
        }
        console.log(values)
        $('#proveedores').val(values)

    })
}