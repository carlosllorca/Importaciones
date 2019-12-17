<?php

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model app\models\LoginForm */

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

$this->title = 'Autenticar';
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
                    <div class="p-3">
                        <?php $form = ActiveForm::begin([
                            'id' => 'login-form',

                           // 'layout' => 'horizontal',
//                            'fieldConfig' => [
//                                'template' => "{label}\n<div class=\"col-lg-3\">{input}</div>\n<div class=\"col-lg-8\">{error}</div>",
//                                'labelOptions' => ['class' => 'col-lg-1 control-label'],
//                            ],
                        ]); ?>

                        <?= $form->field($model, 'username')->textInput(['autofocus' => true,['maxlength' => true]])->label('Nombre de Usuario') ?>

                        <?= $form->field($model, 'password')->passwordInput([['maxlength' => true]])->label('Contraseña') ?>

                        <?= $form->field($model, 'rememberMe')->checkbox()->label('Recuérdame!') ?>

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
