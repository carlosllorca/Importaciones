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

}
function cancelarLicitacion(){
    $('#licitacion_form').addClass('hidden');
    $('#no-data').removeClass('hidden');

}
function showProvider(id){
    $('#view-content').removeClass('hidden');
    $('#view-content').load(`/buy-request/provider-details?id=${id}`)
}
function evaluateOffert(id){

    $('#bodyEvaluarOferta').load(`/buy-request/evaluate-offert?id=${id}`)
}
