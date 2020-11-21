<?php

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model app\models\LoginForm */

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

$this->title = 'Aplicación informática para la gestión del ciclo logístico';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6" style="margin: auto;float: none">
            <div class="card">
                <div class="card-header card-header-primary">
                    <h4 class="card-title"><?=$this->title?></h4>
                    <p class="card-category">Ingrese sus credenciales. Luego presione acceder.</p>
                </div>
                <div class="card-body" style="padding: 15px">
                    <div style="width: 100%; text-align: center">
                        <img src="/img/SEISA.png" width="20%" style="margin: autol "/>
                    </div>
                    <div class="p-3">
                        <?php $form = ActiveForm::begin([
                            'id' => 'login-form',
                           'options' => ['autocomplete'=>'off']

                           // 'layout' => 'horizontal',
//                            'fieldConfig' => [
//                                'template' => "{label}\n<div class=\"col-lg-3\">{input}</div>\n<div class=\"col-lg-8\">{error}</div>",
//                                'labelOptions' => ['class' => 'col-lg-1 control-label'],
//                            ],
                        ]); ?>


                        <?= $form->field($model, 'username')->
                        textInput([
                            'autofocus' => true,
                            'autocomplete'=>"off",
                            'readonly'=>true,
                            'onfocus'=>"this.removeAttribute('readonly');",

                            ['maxlength' => true]])->label('Nombre de Usuario') ?>

                        <?= $form->field($model, 'password')->passwordInput([['maxlength' => true,'autocomplete'=>"off"]])->label('Contraseña') ?>

                       <div style="display: none">
                           <?= $form->field($model, 'rememberMe')->checkbox()->label('Recuérdame!') ?>
                       </div>

                        <div class="form-group">
                            <div class="col-lg-offset-1 col-lg-11">
                                <?= Html::submitButton('Acceder', ['class' => 'btn btn-primary', 'name' => 'login-button']) ?>
                            </div>
                        </div>

                        <?php ActiveForm::end(); ?>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
