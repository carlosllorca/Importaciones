<?php
use miloschuman\highcharts\Highcharts;
use app\models\User;
$solicitudesHitosActivos = \app\models\DataGraphics::solicitudesConHitosActivosXTiempo(User::userLogged()->id);

?>
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
