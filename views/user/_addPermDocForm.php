<?php

use kartik\select2\Select2;
use yii\widgets\ActiveForm;


/* @var $this \yii\web\View */
/* @var $model  \app\models\DocumentTypePermission */
/* @var $user  \app\models\User */

?>

<!-- Modal -->
<div class="modal fade" style="margin-top: 20%" id="add-file-access-modal" tabindex="-1" role="dialog" aria-labelledby="Seleccionar ganadores" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <?php
        $form = ActiveForm::begin([

            'action' => 'add-file-access'
        ]);
        ?>
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Añadir acceso a tipo de documento</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="hidden">
                        <?= $form->field($model, 'user_id')->textInput(['type'=>'number'])?>
                    </div>
                    <div class="col-sm-12">
                        <?= $form->field($model, 'document_type_id')->widget(Select2::className(),[
                            'data' => \app\models\DocumentType::combo($user->arrayDocumentType()),
                            'options' => [
                                'multiple'=>true,
                                'style'=>[
                                    'width'=>'100%'
                                ],
                                'placeholder'=>'Seleccione...'
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
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-success">Guardar</button>
            </div>
        </div>
        <?php ActiveForm::end(); ?>
    </div>
</div>


