<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\SellerRequirement */

$this->title = 'Actualizar requerimiento: ' . $model->label;
$this->params['breadcrumbs'][] = ['label' => 'Requerimientos del vendedor', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->label, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Actualizar';
?>
<div class="seller-requirement-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
