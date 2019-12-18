<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\BuyRequestStatus */

$this->title = 'Create Buy Request Status';
$this->params['breadcrumbs'][] = ['label' => 'Buy Request Statuses', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="buy-request-status-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
