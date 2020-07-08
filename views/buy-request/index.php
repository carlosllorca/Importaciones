<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
/* @var $this yii\web\View */
/* @var $searchModel app\models\BuyRequestSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Solicitudes de compra';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="buy-request-status-index">

    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?=$this->title?></h4>
            <p class="card-category">Estas son las solicitudes de compra generadas a partir de las demandas de los clientes.</p>
        </div>
        <div class="card-body" style="padding: 15px">
            <div class="p-3">

                <p>
                    <?=Yii::$app->user->can('buyrequest/create')? Html::a('Crear solicitud', ['create'], ['class' => 'btn btn-success']):null ?>
                </p>


                <?php // echo $this->render('_search', ['model' => $searchModel]); ?>
                <?= GridView::widget([
                    'dataProvider' => $dataProvider,
                    'filterModel' => $searchModel,
                    'columns' => [
                        ['class' => 'yii\grid\SerialColumn'],


                        'code',
                        [
                            'attribute' => 'buy_request_type_id',
                            'filter'=>\app\models\BuyRequestType::comboUserCanBuyRequestType(),
                            'value' => function($model){
                                /**
                                 * @var $model \app\models\BuyRequest
                                 */
                                return $model->buyRequestType->label;
                            }
                        ],
                        'created:date',


                        [
                            'attribute' => 'created_by',
                            'filter'=>\app\models\User::comboAuthorBuyRequest(),
                            'value' => function($model){
                                /**
                                 * @var $model \app\models\BuyRequest
                                 */
                                return $model->createdBy->full_name;
                            }
                        ],
                        'created:date',
                        [
                            'attribute' => 'buy_request_status_id',
                            'filter'=>\app\models\BuyRequestStatus::combo(),
                            'format' => 'raw',
                            'value' => function($model){
                                /**
                                 * @var $model \app\models\BuyRequest
                                 */
                                return "<b class='{$model->classByStatus()}'>{$model->buyRequestStatus->label}</b>";
                            }
                        ],



                        //'buy_request_status_id',
                        //'bidding_start',
                        //'bidding_end',
                        //'buy_request_type_id',

                        [
                            'class' => 'rce\material\grid\ActionColumn',
                            'visibleButtons' => [
                                'view'=>function(){
                                    return Yii::$app->user->can('buyrequest/view');
                                },
                                'update'=>function(){
                                    return Yii::$app->user->can('buyrequest/update');
                                },
                                'delete'=>function($model){
                                    /**
                                     * @var $model \app\models\BuyRequest
                                     */
                                    return Yii::$app->user->can('buyrequest/delete')&$model->buy_request_status_id==\app\models\BuyRequestStatus::$BORRADOR_ID;
                                }
                            ]
                        ],
                    ],
                ]); ?>



            </div>
        </div>
    </div>
</div>