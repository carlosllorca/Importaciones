<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\WarrantyTime */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="warranty-time-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'label')->textInput(['maxlength' => true]) ?>

    <div class="form-group">
        <?= Html::submitButton('Guardar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
