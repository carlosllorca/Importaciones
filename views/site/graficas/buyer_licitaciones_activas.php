<?php
/**
 * @var $this \yii\web\View
 */
use miloschuman\highcharts\Highcharts;

$gaugeInternacional = \app\models\DataGraphics::gaugeCInternacional(\app\models\User::userLogged()->id);

?>
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
]):$this->render('/site/graficas/noData',['name'=>'Licitaciones activas.']); ?>
