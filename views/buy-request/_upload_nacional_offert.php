<?php

use app\models\Provider;
use yii\widgets\ActiveForm;
use yii\helpers\ArrayHelper;
use kartik\file\FileInput;
/* @var $this \yii\web\View */
/* @var $model \app\models\FormPropuesta */
?>
<?php $form=ActiveForm::begin(['options' => ['enctype' => 'multipart/form-data'],
    // 'action' => 'save-ofert',
    'id' => 'upload',]) ?>
<div class="row">

    <div class="col-sm-12">
        <?=$form->field($model,'provider')->widget(\kartik\select2\Select2::className(),
            [
                'data' =>ArrayHelper::map(Provider::related($model->buyRequest()->arrayValidatedList(),$model->buyRequest()->buy_request_type_id),'id','name'),
                'options' => ['placeholder'=>'Seleccione ...']
            ]
        )?>
    </div>
    <div class="col-sm-12">
        <?=$form->field($model,'expiration_date')->textInput(['type'=>'date'])?>
    </div>
    <div class="col-sm-12">
        <?= $form->field($model, 'oferta')->widget(FileInput::className(),[
            'pluginOptions' =>[
                'showPreview' => false,
                'allowEmpty'=>false,
                'showCancel'=>false,
                'showUpload'=>false,
                'browseLabel' => 'Explorar',
                'browseIcon'=>'<i class="fa fa-folder-open mr-2"></i>',
                'removeIcon' => '<i class="fa fa-trash"></i> ',

                'showCaption' => true,


            ]
        ])->label('Adjunte la oferta suministrada por el proveedor') ?>
    </div>
    <div class="col-sm-12">
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeModal()">Cancelar</button>
            <button type="submit" data-confirm="¿Confirma que desea enviar la evaluación?" class="btn btn-success">Guardar
                evaluación
            </button>
        </div>
    </div>

</div>
<?php ActiveForm::end();?>