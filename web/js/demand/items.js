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
        case 3:
            var data = JSON.parse($('#sn').val())
            swal({
                title: "Asignar los pruductos a una solicitud existente",
                input: 'select',
                inputOptions: data,
                preConfirm: async (part) => {
                    return new Promise(async (resolve,reject)=>{

                        if(!part){
                            reject(`Debe seleccionar una órden de compra de la lista.`)
                        }
                       else{
                            try{
                                let result = await axios.post('/demand/clasify',
                                    {
                                        items:actives(),
                                        demand:demand,
                                        solicitud:part,
                                        action:'nacional_exist'
                                    });
                                if(result.status==200){
                                    if(result.data.success){
                                        resolve(result.data);
                                    }else{
                                        throw new Error(result.data.error)
                                    }}
                            }catch (e) {
                                reject(e)
                            }
                        }


                    }).then(response=>{

                        reloadTab();
                    }).catch(error=>{
                        Swal.showValidationMessage(
                            error
                        )
                    })
                },

                showCancelButton: true,
                confirmButtonText: 'Asignar',
                cancelButtonText: 'Cancelar',
                allowOutsideClick: true
            })
            break
        case 4:
            swal({
                title: "¿Está seguro que desea crear una solicitud internacional con los elementos seleccionados?",
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
                                        action:'internacional_request'
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
        case 5:
            var data = JSON.parse($('#si').val())
            swal({
                title: "Asignar los pruductos a una solicitud existente",
                input: 'select',
                inputOptions: data,
                preConfirm: async (part) => {
                    return new Promise(async (resolve,reject)=>{

                        if(!part){
                            reject(`Debe seleccionar una órden de compra de la lista.`)
                        }
                        else{
                            try{
                                let result = await axios.post('/demand/clasify',
                                    {
                                        items:actives(),
                                        demand:demand,
                                        solicitud:part,
                                        action:'internacional_exist'
                                    });
                                if(result.status==200){
                                    if(result.data.success){
                                        resolve(result.data);
                                    }else{
                                        throw new Error(result.data.error)
                                    }}
                            }catch (e) {
                                reject(e)
                            }
                        }


                    }).then(response=>{

                        reloadTab();
                    }).catch(error=>{
                        Swal.showValidationMessage(
                            error
                        )
                    })
                },

                showCancelButton: true,
                confirmButtonText: 'Asignar',
                cancelButtonText: 'Cancelar',
                allowOutsideClick: true
            })
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


    location.reload();
}
function divide(item,maxValue){
    Swal.fire({
        title: 'Dividir las cantidades del producto',
        input: 'number',
        inputAttributes: {
            autocapitalize: 'off'
        },
        showCancelButton: true,
        confirmButtonText: 'Dividir',
        showLoaderOnConfirm: true,
        preConfirm: async (part) => {
            return new Promise(async (resolve,reject)=>{
                let val = maxValue-1;
                if(part==maxValue){
                    reject(`No se puede dividir el producto en la misma cantidad original.`)
                }
                else if(part<1||part>=maxValue){
                   reject(`El valor introducido debe estar entre 1 y ${val}`)
                }else{
                    try{
                        let result = await axios.post('/demand/divide',
                            {
                                items:item,
                                part:part,
                            });
                        if(result.status==200){
                            if(result.data.success){
                                resolve(result.data);
                            }else{
                                throw new Error(result.data.error)
                            }}
                    }catch (e) {
                        reject(e)
                    }
                }


            }).then(response=>{
                return {success:true};
            }).catch(error=>{
                Swal.showValidationMessage(
                    error
                )
            })
        },
        allowOutsideClick: () => !Swal.isLoading()
    }).then((result) => {

        if(result.dismiss){


        }else{
            swal({
                title: 'Producto dividido',
                type: 'success',
                confirmButtonText: 'Aceptar',
                allowOutsideClick: true
            })
            reloadTab()

        }

    })
}