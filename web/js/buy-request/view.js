var assignUser=(buyRequest,role)=>{

    var compradores = JSON.parse($('#data_comprador').val())
    var tecnicos = JSON.parse($('#data_tecnico').val())
    let title ='';
    let data =[];
    switch(role){
        case 'et':
            title =  "Asignar especialista técnico a la solicitud"
            data=tecnicos
            break;
        case 'comprador':
            title =  "Asignar comprador a la solicitud"
            data=compradores
            break;
        default:
            break;
    }
    swal({
        title: title,
        input: 'select',
        inputOptions: data,
        preConfirm: async (part) => {
            return new Promise(async (resolve,reject)=>{

                if(!part){
                    reject(`Debe seleccionar una órden de compra de la lista.`)
                }
                else{
                    try{
                        let result = await axios.post('/buy-request/assign-user',
                            {


                                solicitud:buyRequest,
                                action:role,
                                user:part
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

               window.location.reload();
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
}