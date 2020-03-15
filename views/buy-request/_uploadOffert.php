<?php

use kartik\file\FileInput;
use yii\helpers\Url;
use yii\widgets\ActiveForm;



/* @var $this \yii\web\View */
/* @var $newOffert \app\models\Offert */
?>
<?php
$form = ActiveForm::begin([
    'options' => ['enctype'=>'multipart/form-data'],
    'action' => '/buy-request/save-ofert?id='.$newOffert->buy_request_provider_id,
    'id'=>'new-ofert'
]);
?>

            <div class="hidden">
                <?= $form->field($newOffert, 'buy_request_provider_id')->textInput(['type'=>'number'])?>
                <?= $form->field($newOffert, 'upload_date')->textInput()?>
                <?= $form->field($newOffert, 'upload_by')->textInput()?>
            </div>
            <div class="row">

                <div class="col-sm-6">
                    <?= $form->field($newOffert, 'expiration_date')->textInput(['type' => 'date']) ?>
                </div>
                <div class="col-xs-12">
                    <?= $form->field($newOffert, 'oferta')->widget(FileInput::className(),[
                        'options' => ['required'=>true],

                        'pluginOptions' =>[
                            'uploadUrl' => Url::to(['/site/file-upload']),
                            'showPreview' => false,
                            'allowEmpty'=>false,
                            'showCancel'=>false,
                            'showUpload'=>false,
                            'browseLabel' => 'Explorar',
                            'browseIcon'=>'<i class="fa fa-folder-open mr-2"></i>',
                            'removeIcon' => '<i class="fa fa-trash"></i> ',
                            'mainClass' => 'input-group-xl',
                            'showCaption' => true,
                            'minFileCount'=>1
                        ]
                    ])->label('Adjunte la oferta suministrada por el proveedor') ?>
                </div>
                <div class="col-sm-12 button-container" style="text-align: right">

                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeModal()">Cancelar</button>
                    <?=\yii\helpers\Html::submitButton('Guardar oferta',['class'=>"btn btn-success",'data-confirm'=>"¿Está seguro que desea subir esta oferta?"])?>


                </div>

            </div>

<?php ActiveForm::end(); ?>