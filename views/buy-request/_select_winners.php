<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;


/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */
?>

<!-- Modal -->
<div class="modal fade" style="margin-top: 20%" id="select-winners-modal" tabindex="-1" role="dialog" aria-labelledby="Seleccionar ganadores" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <?php
        $form = ActiveForm::begin([
            'options' => ['enctype'=>'multipart/form-data'],
            'action' => 'select-winners?id='.$model->id,'id'=>'select-winners'
        ]);
        ?>
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Seleccionar ganador(es)</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="hidden">
                        <?= $form->field($model, 'ganadores')->dropDownList($model->comboFinalistas(),['multiple'=>true])?>
                    </div>
                    <div class="col-sm-12">
                        <table class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th></th>
                                <th>Proveedor</th>
                                <th>País</th>
                                <th>Oferta aprobada</th>
                                <th>Evaluación técnica</th>

                            </tr>
                            </thead>
                            <tbody>
                            <?php
                                foreach ($model->getFinalistas() as $buyRequestProvider){
                                    ?>
                                    <tr>
                                        <th><?=Html::checkbox($buyRequestProvider->id,false,['class'=>'check_provider','provider'=>$buyRequestProvider->id])?></th>
                                        <th><?=$buyRequestProvider->provider->name?></th>
                                        <th><?=$buyRequestProvider->provider->country->label?></th>
                                        <th><?= Html::a('Descargar',$buyRequestProvider->approvedOffert->url_file,['target'=>'_blank'])?></th>
                                        <th><?= Html::a('Descargar',$buyRequestProvider->approvedOffert->url_evaluation,['target'=>'_blank'])?></th>

                                    </tr>
                                    <?php
                                }
                            ?>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-6 p-3">
                        <?= $form->field($model, 'blank_contract')->widget(\kartik\file\FileInput::className(),[
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
                        ])->label('Preforma de contrato') ?>
                    </div>
                    <div class="col-sm-6 p-3">
                        <?= $form->field($model, 'pliego')->widget(\kartik\file\FileInput::className(),[
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
                        ])->label('Pliego de concurrencias') ?>
                    </div>
                    <div class="col-sm-6 p-3">
                        <?= $form->field($model, 'buyer_fundamentation')->widget(\kartik\file\FileInput::className(),[
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
                        ])->label('Fundamentación de la compra') ?>
                    </div>


                </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-success">Presentar</button>
            </div>
        </div>
        <?php ActiveForm::end(); ?>
    </div>
</div>

