<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\DocumentTypePermission */

$this->title = 'Create Document Type Permission';
$this->params['breadcrumbs'][] = ['label' => 'Document Type Permissions', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="document-type-permission-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
