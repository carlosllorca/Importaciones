<?php


use yii\widgets\ActiveForm;
/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequestDocument|null */

?>
<div>
    <?php
    $form = ActiveForm::begin([
        'options' => ['enctype'=>'multipart/form-data'],
    ]);
    ?>
    <div class="row">
        <div class="col-sm-12">
            <?= $form->field($model, 'documento')->widget(\kartik\file\FileInput::className(),[
                'options'=>['required'=>true],
                'pluginOptions' =>[
                    'showPreview' => false,
                    'allowEmpty'=>false,
                    'showCancel'=>false,
                    'showUpload'=>false,
                    'browseLabel' => 'Explorar',
                    'browseIcon'=>'<i class="glyphicon glyphicon-folder-open mr-2"></i>',
                    'removeIcon' => '<i class="glyphicon glyphicon-trash"></i> ',
                    'mainClass' => 'input-group-xl',
                    'showCaption' => true,
                ]
            ])->label('Adjunte el documento al expediente') ?>
        </div>

    </div>
    <div class="button-container">
        <?=\yii\helpers\Html::submitButton('Aceptar',['class'=>'btn btn-primary'])?>
    </div>
    <?php

    ActiveForm::end(); ?>
</div>
