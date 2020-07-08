<?php

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model app\models\ContactForm */

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use yii\captcha\Captcha;

$this->title = 'Reportar un problema';
$this->params['breadcrumbs'][] = $this->title;
?>


<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?=$this->title?></h4>

    </div>
    <div class="card-body" style="padding: 15px">
        <div class="p-3">
            <?php if (Yii::$app->session->hasFlash('contactFormSubmitted')): ?>

                <div class="alert alert-success">
                    Gracias por contactarnos. Le responderemos lo antes posible.
                </div>


            <?php else: ?>

                <p>
                    Si usted tiene una duda sobre como utilizar el sistema o ha detectado una falla en su funcionamiento;
                    por favor, complete el siguiente formulario e informenos de sus inquietudes.

                </p>
                <?php $form = ActiveForm::begin(['id' => 'contact-form']); ?>
                        <div class="row">
                            <div class="col-sm-6 col-md-4"><?= $form->field($model, 'name')->textInput(['autofocus' => true]) ?></div>
                            <div class="col-sm-6 col-md-4"><?= $form->field($model, 'email') ?></div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-6"> <?= $form->field($model, 'subject') ?></div>

                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-6"> <?= $form->field($model, 'body')->textarea(['rows' => 6]) ?></div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-6">
                                <?= $form->field($model, 'verifyCode')->widget(Captcha::className(), [
                                    'template' => '<div class="row"><div class="col-lg-3">{image}</div><div class="col-lg-6">{input}</div></div>',
                                ]) ?></div>
                        </div>
                        <div class="form-group">
                            <?= Html::submitButton('Enviar', ['class' => 'btn btn-primary', 'name' => 'contact-button']) ?>
                        </div>

                <?php ActiveForm::end(); ?>

            <?php endif; ?>
        </div>
    </div>
</div>

