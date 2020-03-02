$(function () {
    selectWinners();
})
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
function selectWinners() {
    $('.check_provider').on('change', (event) => {
        let values = [];
        for (let i = 0; i < $('.check_provider').length; i++) {
            if ($($('.check_provider')[i]).is(':checked')) {
                values.push($($('.check_provider')[i]).attr('provider'))
            }
        }
        console.log(values)
        $('#buyrequest-ganadores').val(values)

    })
}