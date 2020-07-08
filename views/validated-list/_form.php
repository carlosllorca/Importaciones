<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\ValidatedList */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="validated-list-form" style="padding: 1rem">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'label')->textInput(['maxlength' => true]) ?>
    <?= $form->field($model, 'common')->checkbox() ?>

    <div class="form-group">
        <?= Html::submitButton('Guardar', [ 'class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
