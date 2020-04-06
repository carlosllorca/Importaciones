<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\BuyRequest711Search */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Buy Request711s';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="buy-request711-index">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Create Buy Request711', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'buy_request_id',
            'final_destiny_id',
            'plan',
            'general_description:ntext',
            //'other_operation',
            //'deployment_place:ntext',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>


</div>
