<?php

use kartik\select2\Select2;
use yii\widgets\ActiveForm;


/* @var $this \yii\web\View */
/* @var $model  \app\models\DocumentTypePermission */


$form = ActiveForm::begin([


]);
?>
<div class="row">

    <div class="col-sm-12">
        <?= $form->field($model, 'document_type_id')->widget(Select2::className(), [
            'data' => \app\models\DocumentType::combo(),
            'id'=>'otro',
            'disabled' => true,

            'options' => [
                    'id'=>'otro',


                'style' => [
                    'width' => '100%'
                ],
                'placeholder' => 'Seleccione...'
            ]
        ]) ?>
    </div>
    <div class="col-sm-6" style="padding-left: 20px">
        <?= $form->field($model, 'allow_view')->checkbox() ?>
    </div>
    <div class="col-sm-6">
        <?= $form->field($model, 'allow_update')->checkbox() ?>
    </div>
</div>

<div class="button-container">
    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
    <button type="submit" class="btn btn-success">Guardar</button>
</div>

<?php ActiveForm::end(); ?>


