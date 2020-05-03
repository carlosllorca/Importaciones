<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\BuyRequest */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="buy-request-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'code')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'created')->textInput() ?>

    <?= $form->field($model, 'last_update')->textInput() ?>

    <?= $form->field($model, 'created_by')->textInput() ?>

    <?= $form->field($model, 'buy_request_status_id')->textInput() ?>

    <?= $form->field($model, 'bidding_start')->textInput() ?>

    <?= $form->field($model, 'bidding_end')->textInput() ?>

    <?= $form->field($model, 'buy_request_type_id')->textInput() ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
