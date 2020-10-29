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
                div.removeClass('text-success');
                div.addClass('text-danger');
                var result=div.find('button');
                for(var i=0;i<result.length;i++ ){
                    if(i==0){
                        $('#'+result[i].id).removeClass('hidden');
                    }else{
                        $('#'+result[i].id).addClass('hidden');
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
                var div=btn.parent().parent().addClass('text-success');
                var div=btn.parent().parent().removeClass('text-danger');
                var result=div.find('button');
                for(var i=0;i<result.length;i++ ){
                    if(i==0){
                        $('#'+result[i].id).addClass('hidden');
                    }else{
                        $('#'+result[i].id).removeClass('hidden');
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
