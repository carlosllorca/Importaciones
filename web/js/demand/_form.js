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
    $('.field-payment_method').on('mouseenter',function(){
        createTooltips(this);
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
var createTooltips = function(obj){

    $data = $('#payment_method').children('option')

    var resp={};
    for(var i = 0; i<$data.length;i++){


        resp[$($data[i]).attr('label')]={
            'value':$($data[i]).attr('value'),
            'label':$($data[i]).attr('label'),

            'desc':$($data[i]).attr('description'),

        }
    }
    console.warn(resp)

    var items = $('#payment_method').val();
    var  element= $('#select2-payment_method-container');
    console.warn(element)
    $(element).on('mouseenter',function(){

        if($(element).attr('title')!=undefined&&resp[$(element).attr('title')]){
            let message = resp[$(element).attr('title')];
            $(element).popover({
                'content':'<div class="row">'+
                    '                        <div class="col-sm-12" style="font-size: 20px!important">'+message.desc+'</div>' +
                    '                 </div>',
                'html':true,

                'placement':'top',
                'container':'body',

            }).popover('show')
        }


    })
    $(element).on('mouseleave',function(){
        $(element).popover('hide')
    })


    //console.log($('#ofert-project_type').val());
}
