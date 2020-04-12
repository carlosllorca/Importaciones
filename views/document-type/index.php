<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
/* @var $this yii\web\View */
/* @var $searchModel app\models\DocumentTypeSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Tipos de documento';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="buy-request-status-index">

    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?=$this->title?></h4>
            <p class="card-category">Documentos que componen un expediente.</p>
        </div>
        <div class="card-body" style="padding: 15px">
            <div class="p-3">
                <p>
                    <?= Html::a('Nuevo', ['create'], ['class' => 'btn btn-success']) ?>
                </p>

                <?php Pjax::begin(); ?>
                <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

                <?= GridView::widget([
                    'dataProvider' => $dataProvider,
                    'rowOptions' => function($model){
                        if(!$model->active){
                            return ['class'=>'danger'];
                        }
                    },
                    'filterModel' => $searchModel,
                    'columns' => [
                        ['class' => 'yii\grid\SerialColumn'],


                        'label',
                        'responsable',
                        [
                                'attribute' => 'buy_request_type_id',
                            'filter' => \app\models\BuyRequestType::combo(),
                                'value' => 'buyRequestType.label'
                        ],
                        'responsable',
                        'order_doc',
                        'active:boolean',

                        [
                                'class' => 'rce\material\grid\ActionColumn',
                                'template' => '{update} {delete}'
                        ],
                    ],
                ]); ?>

                <?php Pjax::end(); ?>
            </div>
        </div>
    </div>



</div>

