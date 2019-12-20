<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\DemandSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="demand-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
        'options' => [
            'data-pjax' => 1
        ],
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'client_contract_number') ?>

    <?= $form->field($model, 'client_id') ?>

    <?= $form->field($model, 'payment_method_id') ?>

    <?= $form->field($model, 'other_execution') ?>

    <?php // echo $form->field($model, 'deployment_part_id') ?>

    <?php // echo $form->field($model, 'other_deploy') ?>

    <?php // echo $form->field($model, 'waranty_time_id') ?>

    <?php // echo $form->field($model, 'warranty_specification') ?>

    <?php // echo $form->field($model, 'purchase_reason_id') ?>

    <?php // echo $form->field($model, 'require_replacement_part')->checkbox() ?>

    <?php // echo $form->field($model, 'replacement_part_details') ?>

    <?php // echo $form->field($model, 'require_post_warranty')->checkbox() ?>

    <?php // echo $form->field($model, 'post_warranty_details') ?>

    <?php // echo $form->field($model, 'require_technic_asistance')->checkbox() ?>

    <?php // echo $form->field($model, 'technic_asistance_details') ?>

    <?php // echo $form->field($model, 'created_date') ?>

    <?php // echo $form->field($model, 'sending_date') ?>

    <?php // echo $form->field($model, 'rejected_reason') ?>

    <?php // echo $form->field($model, 'observation') ?>

    <?php // echo $form->field($model, 'validated_list_id') ?>

    <?php // echo $form->field($model, 'seller_requirement_id') ?>

    <?php // echo $form->field($model, 'demand_status_id') ?>

    <?php // echo $form->field($model, 'created_by') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-outline-secondary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
