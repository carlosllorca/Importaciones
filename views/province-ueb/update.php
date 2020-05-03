<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\ProvinceUeb */

$this->title = 'Actualizar UEB: ' . $model->label;
$this->params['breadcrumbs'][] = ['label' => 'UEB', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->label, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="province-ueb-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
