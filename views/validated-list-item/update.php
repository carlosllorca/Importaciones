<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\ValidatedListItem */

$this->title = 'Actualizar producto: ' . $model->product_name;
$this->params['breadcrumbs'][] = ['label' => 'Listados validados', 'url' => ['/validated-list/index']];
$this->params['breadcrumbs'][] = ['label' => $model->subfamily->validatedList->label, 'url' => ['validated-list/update', 'id' => $model->subfamily->validated_list_id]];

$this->params['breadcrumbs'][] = 'Actualizar producto';
?>

<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?=$this->title?></h4>

    </div>
    <div class="card-body" style="padding: 15px">
        <div class="p-3">
            <?= $this->render('_form', [
                'model' => $model,
                'vl'=>$model->subfamily->validatedList
            ]) ?>
        </div>
    </div>
</div>
