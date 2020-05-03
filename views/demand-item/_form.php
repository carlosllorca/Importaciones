<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\select2\Select2;
/* @var $this yii\web\View */
/* @var $model app\models\DemandItem */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="demand-item-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <div class="col-sm-6">
            <?= $form->field($model, 'validated_list_item_id')->widget(Select2::classname(), [
                'data' => \app\models\ValidatedListItem::combo($vl),

                'options' => ['placeholder' => 'Seleccione ...','id'=>'validated_list_item_id'],
                'pluginEvents'=>[
                    "change" => "function(el) { cargarDetalles('validated_list_item_id') }",
                ]
            ]);?>
        </div>
        <div class="col-sm-6">
            <?= $form->field($model, 'quantity')->textInput(['type'=>'number'])->label('Cantidad') ?>
        </div>
    </div>


    <div id="product-details">

    </div>

    <?= $form->field($model, 'price')->hiddenInput()->label(false) ?>





    <div class="form-group">
        <?= Html::submitButton('Añadir', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
<?php
$this->registerJsFile('/js/demand_item/_form.js')
?>