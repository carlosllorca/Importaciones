/**
 * Created by carlos on 15/04/16.
 */
function deleteRol(rol){

    $.ajax({
        data: {action: 'delete', auth: rol.name,role:$('#roleName').val()},
        method:'GET',
        url: 'modify-rol',
        type: 'post',
        success:function(resp){


            var btn=$('#'+rol.id);
            var div=btn.parent().parent();
                div.removeClass('success');
                var result=div.find('button');
            console.log(rol);
                for(var i=0;i<result.length;i++ ){
                    if(i==0){
                        $('#'+result[i].id).removeClass('hide');
                        $('#'+result[i].id).addClass('show');
                    }else{
                        $('#'+result[i].id).removeClass('show');
                        $('#'+result[i].id).addClass('hide');
                    }
                }

        },
        failure:function(){
            swal(
                'Data verification failed',
                'Error',
                'error',
            )

        }
    });


}
function addRol(rol){

    $.ajax({
        data: {action: 'add', auth: rol.name,role:$('#roleName').val()},
        method:'GET',
        url: 'modify-rol',
        type: 'post',
        success:function(resp){

                var btn=$('#'+rol.id);
                var div=btn.parent().parent().addClass('success');

                var result=div.find('button');

                for(var i=0;i<result.length;i++ ){

                    if(i==0){
                        $('#'+result[i].id).removeClass('show');
                        $('#'+result[i].id).addClass('hide');
                    }else{

                        $('#'+result[i].id).addClass('show');
                    }
                }




        },
        failure:function(){
            swal(
                'Data verification failed',
                'Error',
                'error'
            )
        }
    });


}
