<?php
use miloschuman\highcharts\Highcharts;
$solicitudesXTipoYEstado = \app\models\DataGraphics::barBuyRequestByBuyerAndStatus(\app\models\User::userLogged()->id);
?>
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
