<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\select2\Select2;
/* @var $this yii\web\View */
/* @var $model app\models\Subfamily */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="subfamily-form">

    <?php $form = ActiveForm::begin(); ?>
    <div class="row">
        <div class="col-md-6">
            <?= $form->field($model, 'label')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-md-6">

            <?= $form->field($model, 'validated_list_id')->widget(Select2::classname(), [
                'data' => \app\models\ValidatedList::combo(),
                'options' => ['placeholder' => 'Seleccione ...'],
                'pluginOptions' => [
                    'allowClear' => true
                ],
            ]);?>
        </div>
    </div>




    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
