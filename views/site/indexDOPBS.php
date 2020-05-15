<?php
use miloschuman\highcharts\Highcharts;


/* @var $this \yii\web\View */
$solicitudesXTipoYEstado =\app\models\DataGraphics::barBuyRequestByDTSpecialistAndStatus(\app\models\User::userLogged()->id);
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
                        <div class="col-sm-9">
                            <?= Highcharts::widget([
                                'scripts' => [
                                    'themes/grid-light',
                                ],
                                'options' => [
                                    'credits' => 'false',
                                    'title' => [
                                        'text' => 'Solicitudes activas.'
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
                        <div class="col-sm-3">
                            <?= Highcharts::widget([
                                'scripts' => [
                                    'modules/drilldown',
                                    'themes/grid-light',
                                    'highcharts-more',
                                ],
                                'options' => [

                                    'credits' => 'false',
                                    'title' => [
                                        'text' => 'Antiguedad de las ofertas pendientes de evaluación.'
                                    ],
                                    'chart' => [
                                        'type' => 'gauge',
                                        'plotBackgroundColor' => '#fff',
                                        'plotBackgroundImage' => null,
                                        'plotBorderWidth' => 0,
                                        'plotShadow' => false,
                                    ],
                                    'pane' => [
                                        'startAngle' => -120,
                                        'center'=>['50%','60%'],
                                        // 'size' => '140%',
                                        'endAngle' => 120,
                                        'background' => false


                                    ],
                                    'yAxis' => [
                                        'min' => 0,
                                        'max' => 10,
                                        'width'=>80,
                                        'height'=>80,
                                        //'minorTickInterval' => 'auto',
                                        'minorTickWidth' => 1,
                                        'minorTickLength' => 10,
                                        // 'minorTickPosition' => 'outside',
                                        'minorTickColor' => '#253090',
                                        'tickPixelInterval' => 5,
                                        'tickWidth' => 0,
                                        'tickPosition' => 'inside',
                                        'tickLength' => 15,
                                        'tickColor' => '#cecece',
                                        'labels' => [
                                            'step' => 10,
                                            //'rotation' => 'auto'
                                        ],
                                        'title' => [
                                            'text' => 'días'
                                        ],
                                        'plotBands' => [[
                                            'from' => 0,
                                            'to' => 2,
                                            'color' => '#55BF3B' // green
                                        ], [
                                            'from' => 2,
                                            'to' => 3,
                                            'color' => '#DDDF0D' // yellow
                                        ], [
                                            'from' => 3,
                                            'to' => 10,

                                            'color' => '#DF5353' // red
                                        ]]
                                    ],

                                    'legend' => [
                                        'enabled' => true
                                    ],
                                    'series' => \app\models\DataGraphics::gaugeEspTecnico(\app\models\User::userLogged()->id)
                                ]
                            ]); ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
