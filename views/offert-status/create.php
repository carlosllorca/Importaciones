<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\OffertStatus */

$this->title = 'Create Offert Status';
$this->params['breadcrumbs'][] = ['label' => 'Offert Statuses', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="offert-status-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
