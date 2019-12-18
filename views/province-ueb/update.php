<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\ProvinceUeb */

$this->title = 'Update Province Ueb: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Province Uebs', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
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
