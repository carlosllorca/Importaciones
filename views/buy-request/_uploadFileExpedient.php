<?php


use yii\widgets\ActiveForm;
/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequestDocument|null */

?>
<div>

    <?php
    $form = ActiveForm::begin([
        'options' => ['enctype'=>'multipart/form-data'],
        'id'=>'upload_file'
    ]);
    ?>
    <div class="row">

        <div class="col-sm-12 <?=$model->document_type_id?null:"hidden"?>">
            <?= $form->field($model, 'evaluation')->checkbox()->label(false)?>
        </div>
        <div class="col-sm-12 <?=$model->document_type_id?"hidden":""?>">
            <?= $form->field($model, 'custom_file')->textInput(['maxlength'=>true])?>
        </div>
        <div class="col-sm-12">
            <?= $form->field($model, 'documento')->widget(\kartik\file\FileInput::className(),[
                //'options'=>['required'=>true],
                'pluginOptions' =>[
                    'showPreview' => false,
                    'allowEmpty'=>false,
                    'showCancel'=>false,
                    'showUpload'=>false,
                    'browseLabel' => 'Explorar',
                    'browseIcon'=>'<i class="fa fa-folder-open mr-2"></i>',
                    'removeIcon' => '<i class="fa fa-trash"></i> ',
                    'mainClass' => 'input-group-xl',
                    'showCaption' => true,
                ]
            ])->label('Adjunte el documento al expediente') ?>
        </div>

    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeModal()">Cancelar</button>
        <button type="submit" data-confirm="¿Confirma que desea subir el documento?" class="btn btn-success">
            Guardar
        </button>
    </div>

    <?php

    ActiveForm::end(); ?>
</div>
