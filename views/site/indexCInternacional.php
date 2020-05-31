<?php



/* @var $this \yii\web\View */
use miloschuman\highcharts\Highcharts;
$gaugeInternacional = \app\models\DataGraphics::gaugeCInternacional(\app\models\User::userLogged()->id);

$solicitudesHitosActivos = \app\models\DataGraphics::solicitudesConHitosActivosXTiempo(\app\models\User::userLogged()->id);
$solicitudesXTipoYEstado = \app\models\DataGraphics::barBuyRequestByBuyerAndStatus(\app\models\User::userLogged()->id);

?>

<div class="site-index">

    <div class="row">
        <div class="col-sm-12" style="margin: auto">
            <div class="card" style="min-height: 80vh">
                <div class="card-header card-header-primary">
                    <b> Estado de la actividad</b>
                </div>
                <div class="card-body" style="padding: 15px">
                    <div class="row">
                        <div class="col-sm-9">
                            <?=count($solicitudesXTipoYEstado[0])? Highcharts::widget([
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
                            ]):$this->render('noData',['name'=>'Solicitudes activas por tipo y estado.'])

                            ; ?>
                        </div>
                        <div class="col-sm-3">

                            <?=count($gaugeInternacional)? Highcharts::widget([
                                'scripts' => [
                                    'themes/grid-light',
                                    'highcharts-more',
                                ],
                                'options' => [
                                    'credits' => 'false',
                                    'title' => [
                                        'text' => 'Licitaciones activas.'
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
                                        'center' => ['50%', '60%'],
                                        // 'size' => '140%',
                                        'endAngle' => 120,
                                        'background' => false
                                    ],
                                    'yAxis' => [
                                        'min' => 0,
                                        'max' => 110,
                                        'width' => 80,
                                        'height' => 80,
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
                                        ],
                                        'title' => [
                                            'text' => '% cumplido <br>del tiempo de licitación'
                                        ],
                                        'plotBands' => [[
                                            'from' => 0,
                                            'to' => 90,
                                            'color' => '#55BF3B' // green
                                        ], [
                                            'from' => 90,
                                            'to' => 100,
                                            'color' => '#DDDF0D' // yellow
                                        ], [
                                            'from' => 100,
                                            'to' => 110,
                                            'color' => '#DF5353' // red
                                        ]]
                                    ],
                                    'legend' => [
                                        'enabled' => true
                                    ],
                                    'series' => $gaugeInternacional
                                ]
                            ]):$this->render('noData',['name'=>'Licitaciones activas.']); ?>
                        </div>
                        <div class="col-sm-12">
                            <?= count($solicitudesHitosActivos[0])?Highcharts::widget([
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
                            ]):$this->render('noData',['name'=>'Solicitudes de compra con hitos activos.']); ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
