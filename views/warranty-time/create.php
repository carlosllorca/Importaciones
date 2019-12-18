<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\WarrantyTime */

$this->title = 'Create Warranty Time';
$this->params['breadcrumbs'][] = ['label' => 'Warranty Times', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="warranty-time-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
