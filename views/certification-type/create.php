<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\CertificationType */

$this->title = 'Create Certification Type';
$this->params['breadcrumbs'][] = ['label' => 'Certification Types', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="certification-type-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
