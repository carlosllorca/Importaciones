
/**
 * Created by carlos on 29/03/17.
 */
/**
 * Override the default yii confirm dialog. This function is
 * called by yii when a confirmation is requested.
 *
 * @param string message the message to display
 * @param string ok callback triggered when confirmation is true
 * @param string cancelCallback callback triggered when cancelled
 */

yii.confirm = function (message, okCallback, cancelCallback) {
    swal({
        title: message,
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Aceptar',
        cancelButtonText: 'Cancelar',

        allowOutsideClick: true
    }).then(result=>{
        if(result.value){
            okCallback()
        }
    });
};
$(function() {
    $('.form-control').on('focusout',function(){
        dontHideMessage(this)

    })
    $('.has-error').addClass('is-focused');


});
let dontHideMessage=function(element){
    setTimeout(()=>{
        if($($(element).parent()).hasClass('has-error')){
            $($(element).parent()).addClass('is-focused')
        }
    },500)
}
function openToogleMenu(ev){
    if($(ev.target).parent().hasClass("open")){
        $(ev.target).parent().removeClass("open")
    }else{
        $(ev.target).parent().addClass("open")
    }
}
function closeModal() {

    var restos = $('.modal-backdrop');

    for(var i = 0; i<restos.length;i++){
        $($('.modal-backdrop')[i]).remove();
    }
    var restos = $('.modal-backdrop');

    for(var i = 0; i<restos.length;i++){
        $($('.modal-backdrop')[i]).remove();
    }

}
function renderAjaxForm(title,ajaxRequest,largeModal=false){
    $('.modal-title').text(title);
    if(largeModal){
        $($('#modal-documentos').find('.modal-dialog')).addClass('modal-lg')
    }else{
        $($('#modal-documentos').find('.modal-dialog')).removeClass('modal-lg')
    }
    $('#modal-content-nacional').load(ajaxRequest,()=>{
        selectWinners();
    })
    $('#ajax-modal-nacional').click();
}
