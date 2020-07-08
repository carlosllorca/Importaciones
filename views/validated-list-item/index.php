<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
/* @var $this yii\web\View */
/* @var $searchModel app\models\ValidatedListItemSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */
/* @var $model \app\models\ValidatedList */


?>
<div class="validated-list-item-index" style="padding: 1rem">
    <p>
        <?= Html::a('<span class="glyphicon glyphicon-plus"></span> Adicionar', ['validated-list-item/create','vl'=>$model->id], ['class' => 'btn btn-success']) ?>
    </p>

    <?php Pjax::begin(); ?>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],


            'seisa_code',
            'product_name',
            'tecnic_description:ntext',
            'price',

            //'validated_list_id',
            //'um_id',
            //'subfamily_id',

            [
                    'class' => 'rce\material\grid\ActionColumn',
                    'template' => '{update} {delete}',

                    'urlCreator' => function($action,$model,$key){
                        return '/validated-list-item/'.$action.'?id='.$key;
                    }

            ],
        ],
    ]); ?>

    <?php Pjax::end(); ?>

</div>
