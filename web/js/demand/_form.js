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
var createTooltips = function(el){

    $data = $('#payment_method').children('option')

    var resp={};
    for(var i = 0; i<$data.length;i++){


        resp[$($data[i]).attr('value')]={
            'value':$($data[i]).attr('value'),
            'label':$($data[i]).attr('label'),

            'desc':$($data[i]).attr('description'),

        }
    }
   let message = resp[el];
    var items = $('#payment_method').val();
    var  element= $('#select2-payment_method-container');


    $(element).on('mouseenter',function(){
            console.warn( message.desc)

            $(element).popover({
               // 'content':()=>'',
                'html':true,
                'title':()=>'',

                'placement':'top',
                'container':'body',

            });
        var popover =$('#select2-payment_method-container').data('bs.popover');
        popover.config.content = message.desc;
        popover.config.title = message.desc;
        $(element).popover('show')





    })
    $(element).on('mouseleave',function(){
        $(element).popover('hide')

        //popover.config.content = 'caca';

    })


    //console.log($('#ofert-project_type').val());
}
