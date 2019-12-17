<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\OperationTypeSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Control de acceso');
//$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Account Management'), 'url' => ['site/settings']];
//$this->params['breadcrumbs'][] = $this->title;
?>

<div class="operation-type-index">
    <h2 class="title text-left inmaj-separator my-3 inmaj-color mb-5"><?= Html::encode($this->title) ?></h2>
    <p>
        <?= Html::a(Yii::t('app', 'Nuevo Rol'), ['create-role'], ['class' => 'btn btn-inmaj-color']) ?>
    </p>
    <table class="table table-bordered table-hover">
        <thead>
        <tr class="headline-blue">

            <th>
                Rol
            </th>
            <th>
                Descripción
            </th>
            <th>
                Acciones
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
                    <a title="Ver" href="<?=Yii::$app->urlManager->createUrl(['manage/view','id'=>$m->name])?>"><span class=" glyphicon glyphicon-search"></span> </a>
                    <a title="Editar" href="<?=Yii::$app->urlManager->createUrl(['manage/update-role','id'=>$m->name])?>"><span class=" glyphicon glyphicon-pencil"></span> </a>
                    <?= Html::a(Yii::t('app', ''), ['delete', 'id' => $m->name], [
                        'class' => 'glyphicon glyphicon-trash',
                        "title" => 'Eliminar',
                        'data' => [
                            'confirm' => Yii::t('app', 'Está seguro que desea eliminar este Rol?'),
                            'method' => 'post',

                        ],
                    ]) ?>
                </td>
            </tr>
        <?php }?>
        </tbody>
    </table>
</div>