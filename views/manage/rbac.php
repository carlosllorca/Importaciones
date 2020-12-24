<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\OperationTypeSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Control de acceso');
$this->params['breadcrumbs'][] = $this->title;
//$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Account Management'), 'url' => ['site/settings']];
//$this->params['breadcrumbs'][] = $this->title;
?>
<div class="buy-request-status-index">
    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?=$this->title?></h4>
            <p class="card-category">Configurar los niveles de acceso a cada sección de la aplicación.</p>
        </div>
        <div class="card-body" style="padding: 15px">
            <div class="p-3">
                <p>
                    <?= Html::a(Yii::t('app', '<span class="fa fa-plus"></span> Nuevo rol'), ['create-role'], ['class' => 'btn btn-primary','title'=>'Crear un nuevo rol']) ?>

                </p>

                <table class="table table-bordered table-hover">
                    <thead>
                    <tr class="headline-blue">

                        <th>
                            <b>Rol</b>
                        </th>
                        <th>
                            <b>Descripción</b>
                        </th>
                        <th>
                            <b>Acciones</b>
                        </th>

                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach($model as $m){?>
                        <tr>
                            <td>
                                <?=$m->name;?>
                            </td>
                            <td>
                                <?=$m->description;?>
                            </td>
                            <td class="tree-action">
                                <a title="Ver" href="<?=Yii::$app->urlManager->createUrl(['manage/view','id'=>$m->name])?>"><span class=" fa fa-search"></span> </a>
                                <a title="Editar" href="<?=Yii::$app->urlManager->createUrl(['manage/update-role','id'=>$m->name])?>"><span class=" fa fa-pencil"></span> </a>
                                <?= Html::a(Yii::t('app', ''), ['delete', 'id' => $m->name], [
                                    'class' => 'fa fa-trash',
                                    "title" => 'Eliminar',
                                    'data' => [
                                        'confirm' => Yii::t('app', 'Está seguro que desea eliminar este rol?'),
                                        'method' => 'post',

                                    ],
                                ]) ?>
                            </td>
                        </tr>
                    <?php }?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
