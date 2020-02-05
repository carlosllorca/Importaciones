$(document).ready(function () {
    itemSelected();

    initIcons();

    const checkTemplate = '<div class="checkbox" style="margin-right: 15px">' +
        '<label>' +
        '<input class="select-on-check-all" onchange="selectCommunication(event)" type="checkbox" name="selection_all" >' +
        '</label>' +
        '</div>';
    let th = $("input.select-on-check-all").parent();
    th.html(checkTemplate);
});
function selectCommunication(ev) {
    $("input.check_item").each(function (i,value) {
        value.checked = ev.target.checked;
    });
    enableAction();
}

let initIcons = function () {
    $(".area-box").each((i,value)=>{
        let image = $(value).find("img")[0];
        $(value).find(".checkbox-material").append(image);
    })
}
let itemSelected = function () {
    $('.check_item').on('change', () => {
        enableAction();
    })
}

let enableAction = function () {
    if (actives().length) {
        $('.clasify').attr('disabled', false);

    } else {
        $('.clasify').attr('disabled', true);
    }
}
var actives = function () {
    let selected = [];
    for (let i = 0; i < $('.check_item').length; i++) {
        if ($($('.check_item')[i]).is(':checked')) {
            selected.push($($('.check_item')[i]).val())
        }
    }
    ;
    return selected;
}
var clasify = function(type,demand){
    switch (type) {
        case 1:
            swal({
                title: "¿Está seguro que desea clasificar los elementos seleccionados como distribución interna?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Si',
                cancelButtonText: 'No',
                allowOutsideClick: true
            }).then(result=>{
                if(result.value){
                    let timerInterval
                    let message = swal({
                        title: 'Clasificando, por favor espere...',
                        timer: 10000000,
                        onBeforeOpen: async () => {
                            Swal.showLoading()
                            let result = await axios.post('/demand/clasify',
                                {
                                    items:actives(),
                                    demand:demand,
                                    action:'internal_distribution'
                                });
                            reloadTab();
                            if(result.data.success){
                                swal({
                                    title: "Elementos clasificados.",
                                    type: 'success',
                                    confirmButtonText: 'Aceptar',
                                    allowOutsideClick: true
                                });

                            }else{
                                swal({
                                    title: "Ocurrió un error al procesar su solicitud. Inténtelo de nuevo más tarde.",
                                    type: 'error',
                                    confirmButtonText: 'Si',
                                    allowOutsideClick: true
                                })
                            }
                        },
                        onClose: () => {
                            clearInterval(timerInterval);
                        }
                    })
                }
            });
            break
        case 2:
            swal({
                title: "¿Está seguro que desea crear una solicitud nacional con los elementos seleccionados?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Si',
                cancelButtonText: 'No',
                allowOutsideClick: true
            }).then(result=>{
                if(result.value){
                    let timerInterval
                    let message = swal({
                        title: 'Generando solicitud, por favor espere...',
                        timer: 10000000,
                        onBeforeOpen: async () => {
                            Swal.showLoading()
                            try{
                                let result = await axios.post('/demand/clasify',
                                    {
                                        items:actives(),
                                        demand:demand,
                                        action:'nacional_request'
                                    });
                                if(result.data.success){
                                    swal({
                                        title: `Solicitud creada correctamente con código ${result.data.request_number}.`,
                                        type: 'success',
                                        confirmButtonText: 'Aceptar',
                                        allowOutsideClick: true
                                    });
                                    reloadTab();

                                }else{
                                    swal({
                                        title: "Ocurrió un error al procesar su solicitud. Inténtelo de nuevo más tarde.",
                                        type: 'error',
                                        confirmButtonText: 'Si',
                                        allowOutsideClick: true
                                    })
                                }
                            }catch (e) {
                                swal({
                                    title: "Ocurrió un error al procesar su solicitud. Inténtelo de nuevo más tarde.",
                                    type: 'error',
                                    confirmButtonText: 'Aceptar',
                                    allowOutsideClick: true
                                })
                                return false;
                            }



                        },
                        onClose: () => {
                            clearInterval(timerInterval);
                        }
                    })
                }
            });
            break
        default:
            swal({
                title: 'Error interno de la aplicación.',
                type: 'error',
                confirmButtonText: 'Aceptar',
                allowOutsideClick: true
            })
    }
}
async function reloadTab(){


   // $.pjax.reload({url:'/demand/view?id=3',container: '#items',timeout: 5000,type:'GET'});
    $.pjax.reload({url:document.URL,container: '#titulos',timeout: 5000,type:'GET'});
}