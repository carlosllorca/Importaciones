<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
/* @var $this yii\web\View */
/* @var $searchModel app\models\PurchaseReasonSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Motivo de la compra';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="buy-request-status-index">
    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?=$this->title?></h4>
            <p class="card-category">Motivo de la compra seleccionable cuando se crea la demanda</p>
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
                    'filterModel' => $searchModel,
                    'columns' => [
                        ['class' => 'yii\grid\SerialColumn'],
                        'label',
                        ['class' => 'yii\grid\ActionColumn'],
                    ],
                ]); ?>
                <?php Pjax::end(); ?>
            </div>
        </div>
    </div>
</div>
