<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\OffertStatus */

$this->title = 'Actualizar: ' . $model->label;
$this->params['breadcrumbs'][] = ['label' => 'Estados de proveedor', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->label, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Actualizar';
?>
<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?=$this->title?></h4>

    </div>
    <div class="card-body" style="padding: 15px">
        <div class="p-3">
            <?= $this->render('_form', [
                'model' => $model,
            ]) ?>
        </div>
    </div>
</div>
