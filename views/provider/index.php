<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
/* @var $this yii\web\View */
/* @var $searchModel app\models\ProviderSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Proveedores';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="buy-request-status-index">
    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?=$this->title?></h4>
            <p class="card-category">Empresas que producen/comercializan los productos solicitados por los clientes.</p>
        </div>
        <div class="card-body" style="padding: 15px">
            <div class="p-3">
                <p>
                    <?=Yii::$app->user->can('provider/create')?
                        Html::a('Nuevo', ['create'], ['class' => 'btn btn-success']):null ?>
                </p>

                <?php Pjax::begin(); ?>
                <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

                <?= GridView::widget([
                    'dataProvider' => $dataProvider,
                    'filterModel' => $searchModel,
                    'columns' => [
                        ['class' => 'yii\grid\SerialColumn'],
                        'name',

                        [
                            'attribute' => 'country_id',
                            'filter' => \app\models\Country::combo(),
                            'value' => 'country.label'
                        ],
                        [
                            'attribute' => 'buy_request_type_id',
                            'filter' => \app\models\BuyRequestType::combo(),
                            'value' => 'buyRequestType.label'
                        ],
                        'address:ntext',
                        'contact_name',
                        //'contact_email:email',
                        'active:boolean',

                        [
                            'class' => 'rce\material\grid\ActionColumn',
                            'template' => '{update}'
                        ],
                    ],
                ]); ?>
                <?php Pjax::end(); ?>
            </div>
        </div>
    </div>
</div>
