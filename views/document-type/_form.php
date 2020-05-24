<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\DocumentType */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="document-type-form">

    <?php $form = ActiveForm::begin(); ?>
    <div class="row">
        <div class="col-sm-6"><?= $form->field($model, 'label')->textInput(['maxlength' => true]) ?></div>
        <div class="col-sm-6"><?= $form->field($model, 'order_doc')->textInput(['maxlength' => true,'type'=>'number']) ?></div>
        <div class="col-sm-6"><?= $form->field($model, 'responsable')->textInput(['maxlength' => true]) ?></div>
        <div class="col-sm-6"><?= $form->field($model, 'buy_request_type_id')->widget(\kartik\select2\Select2::className(),[
                'data' => \app\models\BuyRequestType::combo(),
                'options' => ['placeholder'=>'Seleccione ...']
            ]) ?></div>


        <div class="col-sm-6">
            <?= $form->field($model, 'active')->checkbox() ?>
        </div>
        <div class="col-sm-6">
            <?= $form->field($model, 'required')->checkbox() ?>

        </div>
    </div>





    <div class="form-group">
        <?= Html::submitButton('Guardar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
