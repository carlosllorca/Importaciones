<?php

use miloschuman\highcharts\Highcharts;
use yii\web\JsExpression;

/**
 * @var $this \yii\web\View;
 */

$estados = [];
$uebEstado = [];
$demandasActivasXUEB = \app\models\DataGraphics::demandasActivasXUEB();


?>

<div class="site-index">
    <h4 class="title">
        Bienvenido, <?= Yii::$app->user->identity->full_name ?>
    </h4>
    <div class="row">
        <div class="col-sm-11" style="margin: auto">
            <div class="card">
                <div class="card-header card-header-primary">
                    <b> Estado de la actividad</b>
                </div>
                <div class="card-body" style="padding: 15px">
                    <div class="col-sm-12">
                        <?= Highcharts::widget([
                            'scripts' => [
                                'modules/drilldown',

                                'themes/grid-light',
                            ],
                            'options' => [
                                    'lang'=>[
                                        'drillUpText'=>'Regresar',
                                    ],

                                'credits' => 'false',
                                'title' => [
                                    'text' => 'Demandas activas por UEB y por estado.'
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
                                        'center' => ['0%'  , 0],
                                        'size' => 100,
                                        'showInLegend' => false,
                                        'dataLabels' => [
                                            'enabled' => false,
                                        ],
                                    ],


                                ],
                                'drilldown' => [
                                    'drillUpText'=>'Regresar',
                                    'series' => \app\models\DataGraphics::demandasActivasXUEBXESTADO()
                                ]
                            ]
                        ]); ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>