<?php

use kartik\select2\Select2;
use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\Stage */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="stage-form">

    <?php $form = ActiveForm::begin(); ?>
    <div class="row">
        <div class="col-md-8">
            <?= $form->field($model, 'label')->textInput()?>

        </div>
        <div class="col-md-4">
            <?= $form->field($model, 'buy_request_type_id')->widget(Select2::className(),[
                    'data' => \app\models\BuyRequestType::combo(),
                    'options' => ['placeholder'=>'Seleccione...']

            ]) ?>
        </div>

        <div class="col-md-3">
            <?= $form->field($model, 'duration')->textInput()?>

        </div>
        <div class="col-md-3">
            <?= $form->field($model, 'order')->textInput()?>

        </div>
    </div>

        <?= $form->field($model, 'active')->checkbox()->label(false)?>




    <div class="form-group">
        <?= Html::submitButton('Guardar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
