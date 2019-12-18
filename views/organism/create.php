<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Organism */

$this->title = 'Create Organism';
$this->params['breadcrumbs'][] = ['label' => 'Organisms', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="organism-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
