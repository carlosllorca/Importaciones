<?php


use miloschuman\highcharts\Highcharts;

/* @var $this \yii\web\View */
$data = [];
$data2 = [];
foreach ($query1 as $result) {
    array_push($data, [
        'name' => $result['label'],
        'y' => $result['count'],
        'color' => $result['color'], // Jane's color

    ]);
}
$q2x = [];
$q2y = [];
foreach ($query2 as $result) {
    array_push($q2x, $result['fecha']);
    array_push($q2y, $result['total']);

}

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
                        <div class="col-md-5">
                            <?php
                            echo Highcharts::widget([

                                'options' => [
                                    'title' => [
                                        'text' => 'Estado de sus demandas.',
                                    ],
                                    'credits' => 'false',
                                    'tooltip' => [
                                        'pointFormat' => '<b>Total: {point.y} ({point.percentage:.1f}%)</b>'
                                    ],
                                    'plotOptions' => [
                                        'pie' => [
                                            'allowPointSelect' => true,
                                            'cursor' => 'pointer',
                                            'dataLabels' => [
                                                'enabled' => true,
                                                'format' => '<b>{point.name}</b>: {point.percentage:.1f} %'
                                            ]
                                        ]
                                    ],
                                    'series' =>
                                        [
                                            [
                                                'type' => 'pie',
                                                'name' => 'Cantidad de demandas',
                                                'data' => $data,
                                                // 'center' => [100, 80],
                                                //  'size' => 250,
                                                'showInLegend' => true,
                                                'dataLabels' => [
                                                    'enabled' => false,
                                                ],
                                            ],
                                        ]
                                ]
                            ]);
                            ?>

                        </div>
                        <div class="col-md-7">
                            <?php
                            echo Highcharts::widget([

                                'options' => [
                                    'title' => [
                                        'text' => 'Comportamiento de las demandas en el año.',
                                    ],
                                    'credits' => 'false',
                                    'xAxis' => [
                                        'categories' => $q2x,
                                    ],
                                    'yAxis' => [
                                        'min' => 0,
                                        'title' => [
                                            'text' => 'Demandas enviadas'
                                        ]
                                    ],

                                    'series' =>
                                        [
                                            [
                                                'name' => 'Demandas realizadas',

                                                'data' => $q2y,
                                            ],
                                        ]
                                ]
                            ]);
                            ?>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


