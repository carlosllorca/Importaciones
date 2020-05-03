<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\UserAccount */

$this->title = Yii::t('app', 'Nuevo Rol');

//$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Access Control'), 'url' => ['index']];
//$this->params['breadcrumbs'][] = $this->title;
?>
<div class="container-fluid">
    <div class="card mt-0">
        <div class="card-content">
            <h2 class="title text-left inmaj-separator my-3 inmaj-color"><?= Html::encode($this->title) ?></h2>
            <div class="user-account-create">
                <?= $this->render('_formRole', [
                    'model' => $model,
                ]) ?>
            </div>
        </div>
    </div>
</div>


