<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\select2\Select2;

/* @var $this yii\web\View */
/* @var $model app\models\Client */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="client-form">

    <?php $form = ActiveForm::begin(); ?>
    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'client_code')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-md-4">
            <?= $form->field($model, 'name')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-md-4">
            <?= $form->field($model, 'organism_id')->widget(Select2::classname(), [
                'data' => \app\models\Organism::combo(),
                'options' => ['placeholder' => 'Seleccione ...'],
                'pluginOptions' => [
                    'allowClear' => true
                ],
            ]); ?>
        </div>
        <?php
            if(\app\models\Rbac::getRole()!==\app\models\Rbac::$UEB){
                ?>
                <div class="col-md-4">
                    <?= $form->field($model, 'province_ueb')->widget(Select2::classname(), [
                        'data' => \app\models\ProvinceUeb::combo(),
                        'options' => ['placeholder' => 'Seleccione ...'],
                        'pluginOptions' => [
                            'allowClear' => true
                        ],
                    ]); ?>

                </div>
                <?php
            }
        ?>
        <div class="col-md-12">
            <?= $form->field($model, 'address')->textarea(['rows' => 3]) ?>
        </div>

    </div>











    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
