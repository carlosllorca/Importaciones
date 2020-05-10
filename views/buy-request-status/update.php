<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\BuyRequestStatus */

$this->title = 'Actualizar estado: ' . $model->label;
$this->params['breadcrumbs'][] = ['label' => 'Estado solicitud de compra', 'url' => ['index']];
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

