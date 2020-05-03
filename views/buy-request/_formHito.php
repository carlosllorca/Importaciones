<?php

use yii\widgets\ActiveForm;

/* @var $this \yii\web\View */
/* @var $model \app\models\RequestStage|null */
?>
<div>
    <?php
    $form = ActiveForm::begin([

        // 'action' => 'save-ofert',
        'id' => 'update-hito',
    ]);

    ?>
    <div class="row">
        <div class="col-sm-12">
            <?=$model->nextHitoDate?$form->field($model,'nextHitoDate')->textInput(['type'=>'date']):null?>

        </div>
        <div class="col-sm-12">
            <?=$form->field($model,'details')->textarea(['rows'=>3])?>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeModal()">Cancelar</button>
        <button type="submit" data-confirm="¿Confirma que desea enviar la evaluación?" class="btn btn-success">
            Actualizar
        </button>
    </div>

    <?php ActiveForm::end(); ?>
</div>

