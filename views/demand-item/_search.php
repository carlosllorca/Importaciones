<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\DemandItemSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="demand-item-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
        'options' => [
            'data-pjax' => 1
        ],
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'demand_id') ?>

    <?= $form->field($model, 'validated_list_item_id') ?>

    <?= $form->field($model, 'price') ?>

    <?= $form->field($model, 'quantity') ?>

    <?php // echo $form->field($model, 'buy_request_id') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-outline-secondary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
