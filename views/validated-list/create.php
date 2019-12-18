<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\ValidatedList */

$this->title = 'Create Validated List';
$this->params['breadcrumbs'][] = ['label' => 'Validated Lists', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="validated-list-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
