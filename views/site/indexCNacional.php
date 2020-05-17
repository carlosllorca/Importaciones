<?php



/* @var $this \yii\web\View */
use miloschuman\highcharts\Highcharts;
$solicitudesXTipoYEstado = \app\models\DataGraphics::barBuyRequestByBuyerAndStatus(\app\models\User::userLogged()->id);
$solicitudesHitosActivos = \app\models\DataGraphics::solicitudesConHitosActivosXTiempo(\app\models\User::userLogged()->id)
?>

<div class="site-index">

    <div class="row">
        <div class="col-sm-12" style="margin: auto">
            <div class="card">
                <div class="card-header card-header-primary">
                    <b> Estado de la actividad</b>
                </div>
                <div class="card-body" style="padding: 15px">
                    <div class="row">
                        <div class="col-sm-12">
                            <?= Highcharts::widget([
                                'scripts' => [
                                    'themes/grid-light',
                                ],
                                'options' => [
                                    'credits' => 'false',
                                    'title' => [
                                        'text' => 'Solicitudes activas por tipo y estado.'
                                    ],
                                    'chart' => [
                                        'type' => 'bar'
                                    ],
                                    'xAxis' => [
                                        'categories' => $solicitudesXTipoYEstado[0]


                                    ],
                                    'yAxis' => [
                                        'title' => [
                                            "text" => 'Total de solicitudes activas'
                                        ],
                                        'min' => 0
                                    ],
                                    'legend' => [
                                        'reversed' => false
                                    ],
                                    'plotOptions' => [
                                        'series' => [
                                            'stacking' => 'normal'
                                        ]
                                    ],
                                    'series' => $solicitudesXTipoYEstado[1],

                                ]
                            ]); ?>
                        </div>

                        <div class="col-sm-12">
                            <?= Highcharts::widget([
                                'scripts' => [
                                    'themes/grid-light',
                                ],
                                'options' => [
                                    'credits' => 'false',
                                    'chart' => [
                                        'type' => 'column'
                                    ],
                                    'title' => [
                                        'text' => 'Solicitudes de compra con hitos activos.'
                                    ],

                                    'xAxis' => [
                                        'categories' => $solicitudesHitosActivos[0]
                                    ],
                                    'yAxis' => [
                                        'title' => [
                                            "text" => 'Días'
                                        ],
                                        'min' => 0
                                    ],
                                    'legend' => [
                                        'shadow' => false
                                    ],
                                    'tooltip'=>[
                                            'shared'=>true
                                    ],

                                    'plotOptions' => [
                                        'column' => [
                                            'grouping' => false,
                                            'shadow' => false,
                                            'borderWidth' => 0,
                                        ]
                                    ],
                                    'series' => $solicitudesHitosActivos[1],

                                ]
                            ]); ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
