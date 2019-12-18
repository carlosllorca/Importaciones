<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\DemandStatus */

$this->title = 'Update Demand Status: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Demand Statuses', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="demand-status-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
