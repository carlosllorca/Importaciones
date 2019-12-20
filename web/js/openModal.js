 function openModal (modalId) {
     $('#'+modalId).click();
     $('.form-modal')[0].reset()
};
function closeModal(){
     $('.modal.in').modal('hide')
}
function openModalAndSetValue(modalId,itemId,value){
          openModal(modalId)
          $('#'+itemId).val(value);

 }
 function openModalAjax (modalId,Url) {

     $('#'+modalId).click();
     $('#modal-content' ).load(Url)

 };