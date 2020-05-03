<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\DocumentTypePermission */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="document-type-permission-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'document_type_id')->textInput() ?>

    <?= $form->field($model, 'role')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'allow_view')->checkbox() ?>

    <?= $form->field($model, 'allow_update')->checkbox() ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
