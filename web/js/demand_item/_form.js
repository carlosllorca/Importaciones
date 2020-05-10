

function cargarDetalles(name){
    var val = ($('#'+name).val());
    $('#product-details').load('/demand-item/product-details?product='+val)

}