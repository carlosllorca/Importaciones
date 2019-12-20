<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\User */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="user-form">
    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <div class="col-sm-6 col-md-4">
            <?= $form->field($model, 'username')->textInput(['maxlength' => true,'disabled'=>!$model->isNewRecord]) ?>
        </div>
        <div class="col-sm-6 col-md-4">
            <?= $form->field($model, 'full_name')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-sm-6 col-md-4">
            <?= $form->field($model, 'email')->textInput(['maxlength' => true]) ?>
        </div>


        <div class="col-sm-6 col-md-4">
            <?= $form->field($model, 'rol')->dropDownList(\app\models\Rbac::comboRoles()) ?>
        </div>
        <?php
            if($model->isNewRecord){
                ?>
                <div class="col-sm-6 col-md-4">
                    <?= $form->field($model, 'password')->passwordInput() ?>
                </div>
                <div class="col-sm-6 col-md-4">
                    <?= $form->field($model, 'confirm_password')->passwordInput() ?>
                </div>
                <?php
            }
        ?>


        <div class="col-sm-6 col-md-4" id="ueb" class="<?=$model->rol!=\app\models\Rbac::$UEB?"":"hidden"?>">
            <?= $form->field($model, 'province_ueb')->dropDownList(\app\models\ProvinceUeb::combo(),['prompt'=>'Seleccione']) ?>
        </div>
    </div>









    <div class="form-group">
        <?= Html::submitButton('Guardar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
<?php
$this->registerJsFile('/js/user/_form.js',['depends'=>\yii\web\JqueryAsset::className()]);
?>
