<?php



/* @var $this \yii\web\View */
$this->title='Módulo de informes'
?>

<div class="site-index">

    <div class="row">
        <div class="col-sm-12" style="margin: auto">
            <div class="card">
                <div class="card-header card-header-primary">
                    <h4 class="card-title"><?=$this->title?></h4>
                    <p class="card-category">Resumen de los elementos más significativos de la actividad.</p>
                </div>
                <div class="card-body" style="padding: 15px">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header card-header-primary">
                                    <b class="card-title">Demandas</b>
                                </div>
                                <div class="card-body" style="padding: 15px">
                                    <table class="table">
                                        <tbody>
                                        <tr><th> Productos más demandados en el último año.</th><th><a TARGET="_blank" href="/inform/demandas-productos-mas-solicitados"><i class="fa fa-download"></i></a> </th></tr>
                                        <tr><th> Productos más demandados en el último trimestre.</th><th><a target="_blank" href="/inform/demandas-productos-mas-solicitados-trimestre"><i class="fa fa-download"></i></a> </th></tr>
                                        <tr><th> Demandas pendientes con más de 1 mes.</th><th><a target="_blank" href="/inform/demandas-pendientes"><i class="fa fa-download"></i></a> </th></tr>
                                        <tr><th> Relación de demandas rechazadas.</th><th><a target="_blank" href="/inform/demandas-rechazadas"><i class="fa fa-download"></i></a> </th></tr>
                                        </tbody>
                                    </table>
                                </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header card-header-primary">
                                    <b class="card-title">Solicitudes de compra</b>
                                </div>
                                <div class="card-body" style="padding: 15px">
                                    <table class="table">
                                        <tbody>
                                        <tr><th> Solicitudes activas.</th><th><a target="_blank" href="/inform/solicitudes-activas"><i class="fa fa-download"></i></a> </th></tr>
                                        <tr><th> Solicitudes en fase de contratación con tiempo superior al establecido para cada etapa.</th><th><a target="_blank" href="/inform/solicitudes-fuera-fecha"><i class="fa fa-download"></i></a></th> </tr>
                                        <tr><th> Valor de las órdenes de compra completadas en el último año distribuidas por meses.</th><th><a target="_blank" href="/inform/ventas"><i class="fa fa-download"></i></a> </th></tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header card-header-primary">
                                    <b class="card-title">Ciclo de transportación</b>
                                </div>
                                <div class="card-body" style="padding: 15px">
                                    <table class="table">
                                        <tbody>
                                        <tr><th> Ordenes activas por hito en que se encuentran.</th><th><a target="_blank" href="/inform/solicitudes-en-transportacion"><i class="fa fa-download"></i></a> </th></tr>
                                        <tr><th> Ordenes de compra con hitos vencidos.</th><th><a target="_blank" href="/inform/solicitudes-en-transportacion-vencidas"><i class="fa fa-download"></i></a> </th></tr>
                                        <tr><th> Tiempo medio de respuesta de proveedores a solicitudes de oferta.</th></tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
