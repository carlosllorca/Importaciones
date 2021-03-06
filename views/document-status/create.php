<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Um */

$this->title = 'Crear';
$this->params['breadcrumbs'][] = ['label' => 'Estados de los documentos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?=$this->title?></h4>

    </div>
    <div class="card-body" style="padding: 15px">
        <div class="p-3">
            <?= $this->render('_form', [
                'model' => $model,
            ]) ?>
        </div>
    </div>
</div>
