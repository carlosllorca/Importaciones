<?php

use yii\widgets\ActiveForm;
use yii\helpers\Url;

/* @var $this \yii\web\View */
/* @var $model \app\models\Offert|null */?>
<div class="row">
    <?php
    $form = ActiveForm::begin([
    'options' => ['enctype'=>'multipart/form-data'],
   // 'action' => 'save-ofert',
        'id'=>'evaluate-ofert'
    ]);
    ?>

    <div class="col-sm-12">

            <div class="hidden">

            </div>
            <div class="row">
                <div class="col-sm-12">
                    <?= $form->field($model, 'approved')->checkbox()->label(false) ?>
                </div>

                <div class="col-sm-12" style="padding-left: 10px">
                    <?= $form->field($model, 'evaluacion')->widget(\kartik\file\FileInput::className(),[

                        'options'=>['required'=>true],
                        'pluginOptions' =>[
                            'uploadUrl' => Url::to(['/site/file-upload']),
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
                    ])->label('Adjunte su evaluación de la oferta') ?>
                </div>

            </div>


        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
            <button type="submit" data-confirm="¿Confirma que desea enviar la evaluación?" class="btn btn-success">Guardar evaluación</button>
        </div>
    </div>
    <?php ActiveForm::end(); ?>
</div>
