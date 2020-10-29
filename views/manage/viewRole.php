<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */


$this->title = $model->description;
$this->params['breadcrumbs'][] = ['label' => 'Control de acceso', 'url' => ['rbac']];
$this->params['breadcrumbs'][] = $this->title;
//$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Account Management'), 'url' => ['site/settings']];
//$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Control de rutas'), 'url' => ['index']];
//$this->params['breadcrumbs'][] = $this->title;

?>




<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?=$this->title?></h4>
        <p>Información de configuración del rol.</p>

    </div>
    <div class="card-body" style="padding: 15px">
        <div class="level-access-view">
            <p class="text-right">
                <?= Html::a(Yii::t('app', 'Actualizar permisos'), ['manage/update-perm', 'role'=>$model->name], ['class' => 'btn btn-primary']) ?>
                <?php
                if(count($users)==0){
                    Html::a(Yii::t('app', 'Delete'), ['delete', 'id' => $model->name], [
                        'class' => 'btn btn-danger',
                        'data' => [
                            'confirm' => Yii::t('app', 'Está seguro que desea eliminar este rol?'),
                            'method' => 'post',
                        ],
                    ]);
                }
                ?>
            </p>


        </div>

        <div class="row">
            <div class="col-md-4 col-sm-4">
                <h3>Acciones permitidas:</h3>
                <div style="background-color:#f5f5f5">
                    <ul>
                        <?php
                        foreach($perms as $p){
                            echo "<li style='list-style: none'>$p->description</li>";
                        }
                        ?>
                    </ul>
                </div>
            </div>

            <div class="col-md-4 col-sm-4">
                <h3>Usuarios con el rol:</h3>
                <div style="background-color:#f5f5f5">
                    <ul>
                        <?php
                        foreach($users as $u){
                            echo "<li style='list-style: none'>$u</li>";
                        }
                        ?>
                    </ul>
                </div>
            </div>
        </div>

    </div>
</div>