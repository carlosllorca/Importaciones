<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
/* @var $this yii\web\View */
/* @var $searchModel app\models\DemandSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Mis demandas';
$this->params['breadcrumbs'][] = $this->title;
?>

<div class="buy-request-status-index">

    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?=$this->title?></h4>
            <p class="card-category">Demandas de productos realizadas a la empresa.</p>
        </div>
        <div class="card-body" style="padding: 15px">
            <div class="p-3">
                <p>
                    <?= Html::a("<span class='glyphicon glyphicon-plus'/> <b>Nueva demanda</b>", ['create'], ['class' => 'btn btn-success']) ?>
                </p>

                <?php Pjax::begin(); ?>
                <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

                <?= GridView::widget([
                    'dataProvider' => $dataProvider,
                    'filterModel' => $searchModel,
                    'columns' => [
                        ['class' => 'yii\grid\SerialColumn'],


                        'client_contract_number',
                        [
                                'label' => 'Cliente',
                                'attribute' => 'client_id',
                                'value' => 'client.name'
                        ],

                        'payment_method_id',
                        'other_execution:ntext',
                        //'deployment_part_id',
                        //'other_deploy:ntext',
                        //'waranty_time_id:datetime',
                        //'warranty_specification:ntext',
                        //'purchase_reason_id',
                        //'require_replacement_part:boolean',
                        //'replacement_part_details:ntext',
                        //'require_post_warranty:boolean',
                        //'post_warranty_details:ntext',
                        //'require_technic_asistance:boolean',
                        //'technic_asistance_details:ntext',
                        //'created_date',
                        //'sending_date',
                        //'rejected_reason:ntext',
                        //'observation:ntext',
                        //'validated_list_id',
                        //'seller_requirement_id',
                        //'demand_status_id',
                        //'created_by',

                        ['class' => 'rce\material\grid\ActionColumn'],
                    ],
                ]); ?>

                <?php Pjax::end(); ?>
            </div>
        </div>
    </div>



</div>
