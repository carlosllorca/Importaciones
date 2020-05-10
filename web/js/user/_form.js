$(function() {
  hideElement();
  $('#user-rol').on('change',function(){
      if($('#user-rol').val()!='ueb'){
          $('#ueb').addClass('hidden')
      }else{
          $('#ueb').removeClass('hidden')
      }
  })

});
var hideElement=function(){

}
var loadUpdateAccess = function(id){
    $('#update-access-file-data').load(`/user/update-document-access?id=${id}`)
}
