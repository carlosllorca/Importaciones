<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\ProvinceUeb */

$this->title = 'Create Province Ueb';
$this->params['breadcrumbs'][] = ['label' => 'Province Uebs', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="province-ueb-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
