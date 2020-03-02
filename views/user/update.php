<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\User */

$this->title = 'Actualizar usuario: ' . $model->full_name;
$this->params['breadcrumbs'][] = ['label' => 'Usuarios', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->full_name, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Actualizar';
?>
<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?=$this->title?></h4>

    </div>
    <div class="card-body" style="padding: 15px">

        <div class="p-3">
            <p style="text-align: right">
                <?php
                if(Yii::$app->user->can('user/logs')){

                    echo Html::a(
                        "<i class=\"material-icons\">transfer_within_a_station</i>",['user/logs','id'=>$model->id],
                        [
                            'class'=>'btn btn-primary',
                            'title'=>'Trazas del usuario'
                        ]);

                }
                if(Yii::$app->user->can('user/disable')){
                    if($model->active){
                        $msg = "¿Confirma que desea desactivar este usuario?";
                        echo Html::a(
                            "<span class='glyphicon glyphicon-remove'/>",['user/disable','id'=>$model->id],
                            [
                                'data-confirm'=>$msg,
                                'class'=>'btn btn-danger',
                                'title'=>'Desactivar usuario'
                            ]);
                    }else{
                        $msg = "¿Confirma que desea activar este usuario?";
                        echo Html::a(
                            "<span class='glyphicon glyphicon-ok'/>",['user/disable','id'=>$model->id],
                            [
                                'data-confirm'=>$msg,
                                'class'=>'btn btn-success',
                                'title'=>'Activar usuario'
                            ]);
                    }
                }

                ?>

            </p>

            <?= $this->render('_form', [
                'model' => $model,
                'newPerm'=>$newPerm
            ]) ?>

        </div>
    </div>
</div>
