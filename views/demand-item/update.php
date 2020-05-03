<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\DemandItem */

$this->title = 'Update Demand Item: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Demand Items', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="demand-item-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
