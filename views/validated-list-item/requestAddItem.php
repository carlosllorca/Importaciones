<?php
use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this \yii\web\View */
/* @var $model \app\models\RequestAddItemForm */
?>

<?php $form = ActiveForm::begin([
    'id'=>'711-form'
]); ?>

<div class="row">
    <div class="col-sm-12">
        <?= $form->field($model, 'name')->textInput() ?>
    </div>
    <div class="col-sm-12">
        <?= $form->field($model, 'description')->textarea([
            'placeholder'=>'Escriba aquí toda la información posible del producto...',
            'rows'=>6
        ]) ?>
    </div>

</div>

    <div class="modal-footer">
        <?= Html::submitButton('Enviar', ['class' => 'btn btn-success']) ?>
    </div>

<?php ActiveForm::end(); ?>