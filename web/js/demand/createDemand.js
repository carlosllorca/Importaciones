$(function() {
$('.quantity').on('change',async function(){
    let cantidad = $(this).val()
    let demand = $(this).attr('demand')
    let product = $(this).attr('product')
    let result = await updateDemand(product,cantidad,demand,$(this))
    if(result){
        $($($(this).parent()).parent()).removeClass('alert-danger');
        if(cantidad==0){
            $($($(this).parent()).parent()).removeClass('alert-success');
        }else{
            $($($(this).parent()).parent()).addClass('alert-success');
        }

        $($($(this).parent()).parent()).find('.import').text(result.import)

        $('#totalProducts').text(result.totalProducts)
        $('#totalImport').text(result.totalAmount)

    }else{
        swal({
            title: "Ocurrió un error al modificar la cantidad.",
            type: 'error',
            confirmButtonText: 'Si',
            allowOutsideClick: true
        })
        $($($(this).parent()).parent()).addClass('alert-danger');
    }

})
});
let updateDemand= async function(item,quantity,demand,) {
    try{
        let result = await axios.post('/demand-item/add-item', {
            item,
            quantity, demand
        });
        if (result.status == 200) {
            return result.data;
        } else {

            return false;
        }
    }catch (e) {
        return false;
    }


}
let showItemDetails = function(item){
    renderAjaxForm('Detalles del producto',
        `/validated-list-item/modal-detail?item=${item}`,true)
}
