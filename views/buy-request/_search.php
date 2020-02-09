<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\BuyRequestSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="buy-request-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
        'options' => [
            'data-pjax' => 1
        ],
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'code') ?>

    <?= $form->field($model, 'created') ?>

    <?= $form->field($model, 'last_update') ?>

    <?= $form->field($model, 'created_by') ?>

    <?php // echo $form->field($model, 'buy_request_status_id') ?>

    <?php // echo $form->field($model, 'bidding_start') ?>

    <?php // echo $form->field($model, 'bidding_end') ?>

    <?php // echo $form->field($model, 'buy_request_type_id') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-outline-secondary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
