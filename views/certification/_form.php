<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\Certification */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="certification-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'label')->textInput() ?>

    <?= $form->field($model, 'certification_type_id')->dropDownList(\app\models\CertificationType::combo()) ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
