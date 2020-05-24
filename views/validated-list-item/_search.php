<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\ValidatedListItemSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="validated-list-item-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
        'options' => [
            'data-pjax' => 1
        ],
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'seisa_code') ?>

    <?= $form->field($model, 'product_name') ?>

    <?= $form->field($model, 'tecnic_description') ?>

    <?= $form->field($model, 'price') ?>

    <?php // echo $form->field($model, 'validated_list_id') ?>

    <?php // echo $form->field($model, 'um_id') ?>

    <?php // echo $form->field($model, 'subfamily_id') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-outline-secondary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
