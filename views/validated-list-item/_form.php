<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\select2\Select2;
/* @var $this yii\web\View */
/* @var $model app\models\ValidatedListItem */
/* @var $vl app\models\ValidatedList */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="validated-list-item-form">

    <?php $form = ActiveForm::begin(); ?>
    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'seisa_code')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-md-4">
            <?= $form->field($model, 'product_name')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-md-4"> <?= $form->field($model, 'price')->textInput(['type'=>'number','minValue'=>0,'step'=>'0.01']) ?></div>

    </div>
    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'um_id')->widget(Select2::classname(), [
                'data' => \app\models\Um::combo(),
                'options' => ['placeholder' => 'Seleccione ...'],
                'pluginOptions' => [
                    'allowClear' => true
                ],
            ]);?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'certificados')->widget(Select2::classname(), [
                'data' => \app\models\Certification::combo(),
                'options' => ['placeholder' => 'Seleccione ...'],
                'pluginOptions' => [
                        'multiple'=>true,
                    'allowClear' => true
                ],
            ]); ?>
        </div>

    </div>
    <div class="row">
        <div class="col-md-12">
            <?= $form->field($model, 'tecnic_description')->textarea(['rows' => 3]) ?>
        </div>
    </div>














    <div class="form-group">
        <?= Html::submitButton('Guardar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
