$(function () {
    selectWinners();
    itemSelected();

})

function selectWinners() {
    $('.check_provider').on('change', (event) => {
        let values = [];
        for (let i = 0; i < $('.check_provider').length; i++) {
            if ($($('.check_provider')[i]).is(':checked')) {
                values.push($($('.check_provider')[i]).attr('provider'))
            }
        }
        $('#select-ganadores').val(values)

    });
}
function subirArchivo(id,expediente=false){
    $('.modal-title').text('Subir documento');

    if(expediente){
        renderAjaxForm('Subir archivo',`/buy-request/upload-file-expedient?id=false&expediente=${expediente}`)
     //  # $('#modal-content-documents').load(`/buy-request/upload-file-expedient?id=false&expediente=${expediente}`)
    }else{
        renderAjaxForm('Subir archivo',`/buy-request/upload-file-expedient?id=${id}`)
   //    # $('#modal-content-documents').load()
    }
 //   $('#ajax-modal-documents').click();

}
function transportForm(id){
    renderAjaxForm('Enviar a seguimiento',`/buy-request/send-to-monitoring?id=${id}`)

}
function convert711(id){
    renderAjaxForm('Convertir solicitud nacional a 711',`/buy-request-711/create?request=${id}`)

}

function closeHito(id){
    renderAjaxForm('Actualizar Hito',`/buy-request/stage-success?id=${id}`)



}function updateHito(id){
    renderAjaxForm('Actualizar Hito',`/buy-request/stage-success?id=${id}&setSuccess=false`)
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
function createAnother(type=false,demand){
    switch (type) {
        case 1://Generar una nueva solcictud 711 con los productos seleccionados.
            swal({
                title: "¿Está seguro que desea crear una nueva solicitud con los elementos seleccionados?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Si',
                cancelButtonText: 'No',
                allowOutsideClick: true
            }).then(result=>{
                if(result.value){
                    let timerInterval
                    let message = swal({
                        title: 'Generando, por favor espere...',
                        timer: 10000000,
                        onBeforeOpen: async () => {
                            Swal.showLoading()
                            let result = await axios.post('/buy-request-711/separate',
                                {
                                    items:actives(),
                                    demand:demand,
                                    action:'separarte_to_new'
                                });
                            reloadTab();
                            if(result.data.success){
                                swal({
                                    title: `Orden de compra generada con código ${result.data.request_number}.`,
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
            var data = JSON.parse($('#br711').val())
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
                                let result = await axios.post('/buy-request-711/separate',
                                    {
                                        items:actives(),
                                        demand:demand,
                                        solicitud:part,
                                        action:'insert_into_exist'
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

    }
}
async function reloadTab(){


    location.reload();
}
let reject = function (item) {
    swal({
        title: 'Indique el motivo.',
        input: 'textarea',
        inputAttributes: {
            autocapitalize: 'off'
        },
        showCancelButton: true,
        confirmButtonText: 'Aceptar',
        cancelButtonText:'Cancelar',
        showLoaderOnConfirm: true,
        preConfirm: (reason) => {
            return axios.post('/buy-request/reject',{request:item,reason:reason})
                .then(result => {


                    if (result.data.success) {
                        location.reload();

                        swal({
                            title: `Operación realizada con éxito`,
                            type: 'success',
                            timer:3000,
                            showCancelButton: false,
                            closeOnConfirm: true,
                            allowOutsideClick: true
                        })
                    } else {
                        swal({
                            title: `Ocurrió un error al procesar su solicitud.`,
                            text: 'Inténtelo denuevo más tarde',
                            type: 'error',
                            showCancelButton: false,
                            closeOnConfirm: true,
                            allowOutsideClick: true
                        })
                    }

                })
                .catch(error => {
                    Swal.showValidationMessage(
                        `Request failed: ${error}`
                    )
                })
        },
        allowOutsideClick: false
    }).then((result) => {

    })




}