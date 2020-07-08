<?php

use yii\helpers\Html;
use app\components\TabPanel;
/* @var $this yii\web\View */
/* @var $model app\models\ValidatedList */

$this->title = 'Actualizar listado validado: ' . $model->label;
$this->params['breadcrumbs'][] = ['label' => 'Listados validados', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->label, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Actualizar';
?>
<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?=$this->title?></h4>

    </div>
    <div class="card-body" style="padding: 15px">
        <div class="p-3">
            <?php
            echo TabPanel::widget([

                'items' => [
                    [
                        'label' => 'General',
                        'content' =>$this->render('_form', ['model' => $model]),
                        'visible'=>true,
                        'active' =>  true
                    ],
                    [
                        'label' => 'Productos',
                        'content' =>$this->render('/validated-list-item/index', [
                            'searchModel' => $searchModel,
                            'dataProvider' => $dataProvider,
                            'model'=>$model
                        ]),
                        'visible'=>true,
                        'active' =>   false
                    ],



                ],
            ]);
            ?>



        </div>
    </div>
</div>
