<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\UserAccount */

$this->title = Yii::t('app', 'Crear rol');

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Control de acceso'), 'url' => ['rbac']];
$this->params['breadcrumbs'][] = $this->title;
?>


<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?=$this->title?></h4>

    </div>
    <div class="card-body" style="padding: 15px">
        <div class="p-3">
            <?= $this->render('_formRole', [
                'model' => $model,
            ]) ?>
        </div>
    </div>
</div>




