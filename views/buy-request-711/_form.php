<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\BuyRequest711 */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="buy-request711-form">

    <?php $form = ActiveForm::begin([
            'id'=>'711-form'
    ]); ?>



    <?= $form->field($model, 'final_destiny_id')->widget(\kartik\select2\Select2::className(),[
            'data'=>\app\models\FinalDestiny::combo(),
        'options' => ['prompt'=>'Seleccione ...']
    ]) ?>

    <?= $form->field($model, 'plan')->textInput(['type'=>'number']) ?>

    <?= $form->field($model, 'general_description')->textarea(['rows' => 2]) ?>

    <?= $form->field($model, 'other_operation')->textInput(['type'=>'number','step'=>0.01]) ?>

    <?= $form->field($model, 'deployment_place')->textarea(['rows' => 2]) ?>

    <div class="modal-footer">
        <?= Html::submitButton('Guardar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
