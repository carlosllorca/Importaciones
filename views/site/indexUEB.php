<?php


use miloschuman\highcharts\Highcharts;
use yii\web\JsExpression;
/* @var $this \yii\web\View */
$data = [];
foreach ($query1 as $result){
    array_push($data,[
        'name'=>$result['label'],
        'y'=>$result['count'],
        'color' => $result['color'], // Jane's color

    ]);
}
echo Highcharts::widget([
    'scripts' => [
        'modules/exporting',
        'themes/grid-light',
    ],
    'options' => [
        'title' => [
            'text' => 'Estado de sus demandas.',
        ],
         'tooltip'=> [
        'pointFormat'=> '{series.name}: <b>{point.percentage:.1f}%</b>'
        ],
        'plotOptions'=>[
            'pie'=>[
                 'allowPointSelect'=> true,
                 'cursor'=> 'pointer',
                'dataLabels'=> [
                    'enabled'=> true,
                    'format'=> '<b>{point.name}</b>: {point.percentage:.1f} %'
                ]
            ]
        ],
        'series'=>
        [
            [
                'type' => 'pie',
                'name' => 'Cantidad de demandas',
                'data' => $data,
               // 'center' => [100, 80],
                'size' => 200,
                'showInLegend' => true,
                'dataLabels' => [
                    'enabled' => false,
                ],
            ],
        ]
    ]
]);
?>


