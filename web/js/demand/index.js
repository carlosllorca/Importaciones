let rejectDemand = function (item) {
    swal({
        title: 'Motivo del rechazo de la demanda',
        input: 'textarea',
        inputAttributes: {
            autocapitalize: 'off'
        },
        showCancelButton: true,
        confirmButtonText: 'Rechazar',
        cancelButtonText:'Cancelar',
        showLoaderOnConfirm: true,
        preConfirm: (reason) => {
            return axios.post('/demand/reject',{demand:item,reason:reason})
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