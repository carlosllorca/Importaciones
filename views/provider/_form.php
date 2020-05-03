<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\Provider */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="provider-form">
    <?php $form = ActiveForm::begin(); ?>
    <div class="row">
        <div class="col-sm-6 col-md-4"> <?= $form->field($model, 'name')->textInput() ?></div>
        <div class="col-sm-6 col-md-4"><?= $form->field($model, 'country_id')->widget(\kartik\select2\Select2::className(),[
                'data'=>\app\models\Country::combo(),
                'options' => ['placeholder'=>'Seleccione']
            ]) ?></div>
        <div class="col-sm-6 col-md-4"><?= $form->field($model, 'buy_request_type_id')->widget(\kartik\select2\Select2::className(),[
                'data' => \app\models\BuyRequestType::combo(),
                'options' => ['placeholder'=>'Seleccione ...']
            ]) ?></div>

    </div>
    <div class="row">
        <div class="col-sm-12 col-md-8">
            <?= $form->field($model, 'address')->textarea(['rows' => 3])?>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 col-md-8">
            <?= $form->field($model, 'validated_list_associated')->widget(\kartik\select2\Select2::className(),[
                'data'=>\app\models\ValidatedList::combo(),
                'options' => ['placeholder'=>'Seleccione','multiple'=>true]

            ]) ?>
        </div>
    </div>
  <div class="row">
        <div class="col-sm-6 col-md-4">  <?= $form->field($model, 'contact_name')->textInput() ?></div>
        <div class="col-sm-6 col-md-4">  <?= $form->field($model, 'contact_email')->textInput() ?></div>
        <div class="col-sm-6 col-md-4">  <?= $form->field($model, 'observation')->textInput() ?></div>
        <div class="col-sm-12"> <?= $form->field($model, 'active')->checkbox() ?></div>

  </div>

    <div class="form-group">
        <?= Html::submitButton('Guardar', ['class' => 'btn btn-success']) ?>
    </div>
    <?php
    ActiveForm::end()
    ?>

</div>
