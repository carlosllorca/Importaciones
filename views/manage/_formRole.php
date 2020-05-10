<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\User */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="user-account-form container">
    <?php $form = ActiveForm::begin(); ?>
    <div class="row">
        <div class="col-md-4 col-sm-4 col-xs-12">
            <?php
            if($model->isNewRecord){
               echo $form->field($model, 'name')->textInput(['maxlength' => true,'style'=>'width:300px'])->label('Nombre:*');
            }
            else{
                echo $form->field($model, 'name')->textInput(['maxlength' => true,'disabled'=>true,'style'=>'width:300px'])->label('Nombre:*') ;
            }
            ?>
        </div>
        <div class="col-md-4 col-sm-4 col-xs-12"><?= $form->field($model, 'description')->textInput(['maxlength' => true,'style'=>'width:300px'])->label('Descripción:*') ?></div>
    </div>

    <div class="form-group row">
        <div class="col-md-12 col-sm-12 col-xs-12 p-0 m-0"><?= Html::submitButton($model->isNewRecord ? Yii::t('app', 'Create') : Yii::t('app', 'Update'), ['class' => $model->isNewRecord ? 'btn btn-inmaj-color' : 'btn btn-inmaj-color']) ?></div>
    </div>
    <?php ActiveForm::end(); ?>

</div>
