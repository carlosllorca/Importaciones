<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this \yii\web\View */
/* @var $model \app\models\FormCloseNationalBidding */
$form = ActiveForm::begin([
    'id' => 'close-nacional',
    'options' => ['enctype' => 'multipart/form-data'],
]);
?>
    <div class="row">
        <div class="col-sm-12">
            <?= $form->field($model, 'ganadores')->dropDownList($model->buyRequest()->comboFinalistas(), ['multiple' => true, 'id' => 'select-ganadores','class'=>'hidden'
                ])->label(false) ?>
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
                foreach ($model->buyRequest()->getFinalistas() as $buyRequestProvider) {
                    ?>
                    <tr>
                        <th><?= Html::checkbox($buyRequestProvider->id, false, ['class' => 'check_provider', 'provider' => $buyRequestProvider->id]) ?></th>
                        <th><?= $buyRequestProvider->provider->name ?></th>
                        <th><?= $buyRequestProvider->provider->country->label ?></th>
                        <th><?= Html::a('Descargar', $buyRequestProvider->approvedOffert->url_file, ['target' => '_blank']) ?></th>
                        <th><?= Html::a('Descargar', $buyRequestProvider->approvedOffert->url_evaluation, ['target' => '_blank']) ?></th>

                    </tr>
                    <?php
                }
                ?>
                </tbody>
            </table>
        </div>

        <div class="col-sm-6 p-3">
            <?= $form->field($model, 'blank_contract')->widget(\kartik\file\FileInput::className(), [
                //'options'=>['required'=>true],
                'pluginOptions' => [
                    'showPreview' => false,
                    'allowEmpty' => false,
                    'showCancel' => false,
                    'showUpload' => false,
                    'browseLabel' => 'Explorar',
                    'browseIcon' => '<i class="fa fa-folder-open mr-2"></i>',
                    'removeIcon' => '<i class="fa fa-trash"></i> ',
                    'mainClass' => 'input-group-xl',
                    'showCaption' => true,
                ]
            ])->label('Preforma de contrato') ?>
        </div>

        <div class="col-sm-12 modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-success">Presentar</button>
        </div>

    </div>
<?php
ActiveForm::end();
?>