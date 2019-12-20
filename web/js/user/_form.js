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
