<?php

use miloschuman\highcharts\Highcharts;


/* @var $this \yii\web\View */
$documentsPending = \app\models\DataGraphics::documentsPendingByUser(\app\models\User::userLogged()->id);
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
                                        'text' => 'Documentos pendientes.'
                                    ],
                                    'chart' => [
                                        'type' => 'bar'
                                    ],
                                    'xAxis' => [
                                        'categories' => $documentsPending[0]


                                    ],
                                    'yAxis' => [
                                        'title' => [
                                            "text" => 'Total de documentos pendientes'
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
                                    'series' => $documentsPending[1],

                                ]
                            ]); ?>
                        </div>
                        <div class="col-sm-3">
                            <?= Highcharts::widget([
                                'scripts' => [
                                    'themes/grid-light',
                                ],
                                'options' => [
                                    'credits' => 'false',
                                    'title' => [
                                        'text' => 'Solicitudes de compra con documentos pendientes.'
                                    ],
                                    'chart' => [
                                        'plotBackgroundColor' => null,
                                        'plotBorderWidth' => null,
                                        'plotShadow' => false,
                                        'type' => 'pie'
                                    ],
                                    'tooltip' => [
                                        'pointFormat' => '{series.name}: <b>{point.y}</b>'
                                    ],
                                    'accesibility' => [
                                        'point' => [
                                            'valueSuffix' => '%'
                                        ]
                                    ],
                                    'plotOptions' => [
                                        'pie' => [
                                            'allowPointSelect' => true,
                                            'cursor' => 'pointer',
                                            'dataLabels' => [
                                                'enabled' => true,
                                                'format' => '<b>{point.name}</b>: {point.y} '
                                            ]
                                        ]
                                    ],
                                    'series'=>\app\models\DataGraphics::pieDocumentsPendingOrderType(\app\models\User::userLogged()->id)
                                ]

                            ])
                            ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
