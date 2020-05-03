<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */


$this->title = 'Actualizar rol '.$model->name;
//$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Account Management'), 'url' => ['site/settings']];
//$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Control de rutas'), 'url' => ['index']];
//$this->params['breadcrumbs'][] = $this->title;

?>
<div class="container-fluid">
    <div class="card mt-0">
        <div class="card-content">
            <h2 class="title text-left inmaj-separator my-3 inmaj-color"><b>Rol: </b><?=Html::encode($model->name)?></h2>

            <div class="level-access-view">
                <p class="text-right">
                    <?= Html::a(Yii::t('app', 'Update Permissions'), ['manage/update-perm', 'role'=>$model->name], ['class' => 'btn btn-inmaj-color']) ?>
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

                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <h3>Permitted actions:</h3>
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
                        <h3>Users with this role:</h3>
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
    </div>
</div>