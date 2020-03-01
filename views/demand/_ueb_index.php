<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
/* @var $this yii\web\View */
/* @var $searchModel app\models\ProviderStatusSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Demandas';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="buy-request-status-index">

    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?=$this->title?></h4>
            <p class="card-category">Estados por los que transita una oferta</p>
        </div>
        <div class="card-body" style="padding: 15px">
            <div class="p-3">
                <p>
                    <?= Html::a('<span class="glyphicon glyphicon-plus"/>', ['create'], ['class' => 'btn btn-success','title'=>'Nueva demanda']) ?>
                </p>

                <?php Pjax::begin(); ?>
                <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

                <?= GridView::widget([
                    'dataProvider' => $dataProvider,
                    'filterModel' => $searchModel,
                    'columns' => [
                        ['class' => 'yii\grid\SerialColumn'],


                        'demand_code',
                        [
                            'label' => 'Cliente',
                            'attribute' => 'client_id',
                            'filter' => \app\models\Client::comboUeb(),
                            'value' => 'client.name'
                        ],
                        [
                                'attribute' => 'payment_method_id',
                                'header' => 'Método de pago',
                                'value'=>'paymentMethod.label',
                                'filter' => \app\models\PaymentMethod::combo(),

                        ],

                        [
                            'attribute' => 'validated_list_id',
                            'value'=>'validatedList.label',
                            'header' => 'Listado validado',
                            'filter' => \app\models\ValidatedList::combo(),

                        ],
                        [
                            'attribute' => 'demand_status_id',
                            'value'=>'demandStatus.label',
                            'header' => 'Estado de la demanda',
                            'filter' => \app\models\DemandStatus::combo(),

                        ],



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

                        [
                                'class' => 'yii\grid\ActionColumn',
                                'visibleButtons' => [
                                    'update'=>function ($model, $key, $index) {
                                        return ($model->demand_status_id === \app\models\DemandStatus::BORRADOR_ID||$model->demand_status_id === \app\models\DemandStatus::RECHAZADA_ID);
                                    },
                                    'delete'=>function ($model, $key, $index) {
                                        return ( $model->demand_status_id === \app\models\DemandStatus::BORRADOR_ID||$model->demand_status_id === \app\models\DemandStatus::RECHAZADA_ID);
                                    }
                                ]
                        ],
                    ],
                ]); ?>

                <?php Pjax::end(); ?>
            </div>
        </div>
    </div>



</div>
