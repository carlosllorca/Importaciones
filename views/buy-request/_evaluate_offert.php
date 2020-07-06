<?php

use yii\helpers\Url;
use yii\widgets\ActiveForm;

/* @var $this \yii\web\View */
/* @var $model \app\models\Offert|null */ ?>
<div class="row">
    <?php
    $form = ActiveForm::begin([
        'options' => ['enctype' => 'multipart/form-data'],
        // 'action' => 'save-ofert',
        'id' => 'evaluate-ofert',


        'validationUrl' => Url::toRoute('/buy-request/validate-evaluate-ofert?id=' . $model->id)
    ]);

    ?>

    <div class="col-sm-12">

        <div class="hidden">

        </div>
        <div class="row">
            <div class="col-sm-8">
                <?= $form->field($model, 'approved')->widget(\kartik\select2\Select2::className(), [
                    'data' => [0 => 'No', 1 => 'Si'],
                    'pluginOptions' => ['allowEmpty'=>false],
                    'options' => ['placeholder' => 'Seleccione..']
                ]) ?>
            </div>
            <?= $form->field($model, 'ganadores')->dropDownList($model->buyRequest->comboFinalistas(),['multiple'=>true,'id'=>'select-ganadores','class'=>'hidden'])->label(false)?>

            <div class="col-sm-12" style="padding-left: 10px">
                <?= $form->field($model, 'evaluacion')->widget(\kartik\file\FileInput::className(), [
                     'options' => ['placeholder' => 'Seleccione..'],
                    'pluginOptions' => [
                            'required'=>true,
                            'msgFileRequired'=>'Archivo requerido',

                        'showPreview' => false,

                        'showUpload' => false,
                        'browseLabel' => 'Explorar',
                        'browseIcon' => '<i class="glyphicon glyphicon-folder-open mr-2"></i>',
                        'removeIcon' => '<i class="glyphicon glyphicon-trash"></i> ',
                        'mainClass' => 'input-group-xl',
                        'showCaption' => true,
                    ]
                ])->label('Adjunte su evaluación de la oferta') ?>
            </div>

        </div>


    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeModal()">Cancelar</button>
        <button type="submit" data-confirm="¿Confirma que desea enviar la evaluación?" class="btn btn-success">Guardar
            evaluación
        </button>
    </div>
</div>
<?php ActiveForm::end(); ?>
</div>
