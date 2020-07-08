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
            <p class="card-category">Demandas realizadas por las UEB</p>
        </div>
        <div class="card-body" style="padding: 15px">
            <div class="p-3">
                <p>
                    <?= Yii::$app->user->can('demand/create')?Html::a('<span class="fa fa-plus"/>', ['create'], ['class' => 'btn btn-success','title'=>'Nueva demanda']):null ?>
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
                            'filter' => \app\models\Client::combo(),

                            'value' => 'client.name'
                        ],
                        [
                            'label' => 'UEB',
                            'attribute' => 'ueb',
                            'filter' => \app\models\ProvinceUeb::combo(),
                            'value' => 'client.provinceUeb.label'
                        ],



                        [
                            'attribute' => 'validated_list_id',
                            'value'=>'validatedList.label',
                            'label' => 'Tipo',
                            'filter' => \app\models\ValidatedList::combo(),

                        ],
                        [
                            'attribute' => 'approved_by',
                            'value'=>function($model){
                                /**
                                 * @var $model \app\models\Demand
                                 */
                                if($model->demand_status_id==\app\models\DemandStatus::ACEPTADA_ID){
                                 //   return $model->approvedBy->full_name;
                                }else{
                                    return ' - ';
                                }
                            },

                            'filter' => \app\models\User::combo(\app\models\Rbac::$ESP_TECNICO),

                        ],

                        [
                            'attribute' => 'demand_status_id',
                            'format'=>'raw',

                            'value'=>function($model){
                                /**
                                 * @var $model \app\models\Demand
                                 */
                                    return "<b class='{$model->classByStatus()}'>{$model->demandStatus->label}</b>";
                                    },
                            'label' => 'Estado de la demanda',
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
                                'class' => 'rce\material\grid\ActionColumn',
                                'template' => '{view}{approve}{reject}{update}{delete}',
                                'visibleButtons' => [
                                    'update'=>function ($model, $key, $index) {
                                        return Yii::$app->user->can('demand/update');
                                    },
                                    'approve'=>function ($model, $key, $index) {
                                        /**
                                         * @var $model \app\models\Demand
                                         */
                                        return Yii::$app->user->can('demand/approve')&&$model->demand_status_id==\app\models\DemandStatus::ENVIADA_ID;
                                    },
                                    'reject'=>function ($model, $key, $index) {
                                        return Yii::$app->user->can('demand/reject')&&$model->demand_status_id==\app\models\DemandStatus::ENVIADA_ID;
                                    },

                                    'view'=>function ($model, $key, $index) {
                                        return Yii::$app->user->can('demand/view')  ;
                                    },
                                    'delete'=>function ($model, $key, $index) {
                                        return Yii::$app->user->can('demand/delete');
                                    }
                                ],
                            'buttons'=>[
                                'approve'=>function($url,$model){
                                    /**
                                     * @var $model \app\models\Demand
                                     */
                                    return Html::a("<span  class='glyphicon glyphicon-ok'></span>",
                                        $url,[
                                            'data-confirm'=>'¿Está seguro que desea aprobar esta demanda?',
                                            'data-method'=>'POST',
                                            'title'=>'Aprobar demanda'
                                        ]);
                                },
                                'reject'=>function($url,$model){
                                    /**
                                     * @var $model \app\models\Demand
                                     */
                                    return Html::a("<span  class='glyphicon glyphicon-remove'></span>",
                                        '#',[

                                            'title'=>'Rechazar demanda',
                                            'onclick'=>"rejectDemand({$model->id})"
                                        ]);
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
<?php
$this->registerJsFile('@web/js/demand/index.js',['depends'=>\yii\web\JqueryAsset::className()]);
?>
