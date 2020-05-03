<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\BuyRequest711Search */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="buy-request711-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'buy_request_id') ?>

    <?= $form->field($model, 'final_destiny_id') ?>

    <?= $form->field($model, 'plan') ?>

    <?= $form->field($model, 'general_description') ?>

    <?php // echo $form->field($model, 'other_operation') ?>

    <?php // echo $form->field($model, 'deployment_place') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-outline-secondary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
