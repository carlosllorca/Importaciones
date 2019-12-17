
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
        setTimeout(()=>{
            if($($(this).parent()).hasClass('has-error')){
                $($(this).parent()).addClass('is-focused')
            }
        },500)

    })
})
