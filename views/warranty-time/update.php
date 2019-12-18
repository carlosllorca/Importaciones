<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\WarrantyTime */

$this->title = 'Update Warranty Time: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Warranty Times', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="warranty-time-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
