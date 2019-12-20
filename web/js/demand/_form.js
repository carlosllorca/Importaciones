$(function() {
    $('#demand-require_replacement_part').on('click',function(){
        if($(this). prop("checked") == true){
            $('#field-demand-replacement_part_details').removeClass('hidden')
        }else{
            $('#field-demand-replacement_part_details').addClass('hidden')
        }
    })
    $('#demand-require_post_warranty').on('click',function(){
        if($(this). prop("checked") == true){
            $('#field-demand-require_post_warranty').removeClass('hidden')
        }else{
            $('#field-demand-require_post_warranty').addClass('hidden')
        }
    })
    $('#demand-require_technic_asistance').on('click',function(){
        if($(this). prop("checked") == true){
            $('#field-require_technic_asistance').removeClass('hidden')
        }else{
            $('#field-require_technic_asistance').addClass('hidden')
        }
    })

})

function validar(name){
    var val = ($('#'+name).val());
    switch (name) {
        case 'payment_method':
            if(val =='5'){
                $('#details-'+name).removeClass('hidden')
            }else{
                $('#details-'+name).addClass('hidden')
            }
            break;
        case 'deployment_parts':
            if(val =='5'){
                $('#details-'+name).removeClass('hidden')
            }else{
                $('#details-'+name).addClass('hidden')
            }
            break;

    }
}