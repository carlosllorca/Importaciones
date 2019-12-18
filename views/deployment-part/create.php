<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\DeploymentPart */

$this->title = 'Create Deployment Part';
$this->params['breadcrumbs'][] = ['label' => 'Deployment Parts', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="deployment-part-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
