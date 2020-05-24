<?php

use miloschuman\highcharts\Highcharts;
use yii\web\JsExpression;

/**
 * @var $this \yii\web\View;
 */

$estados = [];
$uebEstado = [];
$demandasActivasXUEB = \app\models\DataGraphics::demandasActivasXUEB();
$solicitudesXTipoYEstado =\app\models\DataGraphics::solicitudesActivasxTipoYEstado();

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
                                    'modules/drilldown',
                                    'themes/grid-light',
                                ],
                                'options' => [
                                    'lang' => [
                                        'drillUpText' => 'Regresar',
                                    ],

                                    'credits' => 'false',
                                    'title' => [
                                        'text' => 'Demandas activas por UEB y estado.'
                                    ],
                                    'chart' => [
                                        'type' => 'column'
                                    ],
                                    'yAxis' => [
                                        'title' => [
                                            "text" => 'Demandas activas'
                                        ],


                                    ],
                                    'xAxis' => [
                                        'title' => [
                                            "text" => 'Establecimientos (UEB)'
                                        ],
                                        'type' => 'category',

                                    ],
                                    'legend' => [
                                        'enabled' => false
                                    ],
                                    'type' => 'column',
                                    'accessibility' => [
                                        'announceNewData' => [
                                            'enabled' => true
                                        ]
                                    ],

                                    'series' => [

                                        [
                                            'name' => 'Demandas',
                                            'colorByPoint' => true,
                                            'data' => $demandasActivasXUEB[1],
                                        ],
                                        [
                                            'type' => 'pie',
                                            'name' => 'Estados',
                                            'data' => \app\models\DataGraphics::demandasActivasXEstado(),
                                            'center' => [100, 80],
                                            'size' => 100,
                                            'showInLegend' => false,
                                            'dataLabels' => [
                                                'enabled' => false,
                                            ],
                                        ],


                                    ],
                                    'drilldown' => [
                                        'drillUpText' => 'Regresar',
                                        'series' => \app\models\DataGraphics::demandasActivasXUEBXESTADO()
                                    ]
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
                                        'text' => 'Antiguedad máxima de las demandas arribadas'
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
                                        'max' => 20,
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
                                            'to' => 8,
                                            'color' => '#55BF3B' // green
                                        ], [
                                            'from' => 8,
                                            'to' => 12,
                                            'color' => '#DDDF0D' // yellow
                                        ], [
                                            'from' => 12,
                                            'to' => 50,

                                            'color' => '#DF5353' // red
                                        ]]
                                    ],

                                    'legend' => [
                                        'enabled' => true
                                    ],
                                    'series' => [[
                                        'name' => 'Tiempo máximo',
                                        'data' => \app\models\DataGraphics::edadMaximaDemandaPendiente(),
                                        'tooltip' => [
                                            'valueSuffix' => 'Días'
                                        ]
                                    ]]
                                ]
                            ]); ?>
                        </div>
                    </div>
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
                                    'categories'=>$solicitudesXTipoYEstado[0]


                                ],
                                'yAxis' => [
                                    'title' => [
                                        "text" => 'Total de solicitudes activas'
                                    ],
                                    'min'=>0
                                ],
                                'legend' => [
                                    'reversed' => false
                                ],
                                'plotOptions'=>[
                                        'series'=>[
                                                'stacking'=>'normal'
                                        ]
                                ],
                                'series' => $solicitudesXTipoYEstado[1],

                            ]
                        ]); ?>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>