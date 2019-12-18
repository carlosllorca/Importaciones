<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\DemandStatus */

$this->title = 'Create Demand Status';
$this->params['breadcrumbs'][] = ['label' => 'Demand Statuses', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="demand-status-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
