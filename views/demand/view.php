<?php

use yii\bootstrap\Tabs;
use yii\helpers\Html;
use yii\widgets\Pjax;

/* @var $this yii\web\View */
/* @var $model app\models\Demand */
/* @var $active string */
/* @var $searchModel app\models\DemandItemSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = "Detalles de la demanda";
$this->params['breadcrumbs'][] = ['label' => 'Demandas', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);

?>
<div class="buy-request-status-index">

    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?= $this->title ?></h4>
            <p class="card-category"></p>
        </div>

        <?php Pjax::begin(['id' => 'titulos', 'timeout' => 5000]) ?>
        <div class="card-body">
            <div class="row">
                <div class="col-sm-12" style="text-align: right">
                    <?= Yii::$app->user->can('demand/approve') && $model->demand_status_id == \app\models\DemandStatus::ENVIADA_ID ?
                        Html::a('<i class="glyphicon glyphicon-ok"></i>', ["approve", 'id' => $model->id, 'return' => '/demand/view?id=' . $model->id],
                            [
                                'title' => 'Aprobar demanda',
                                'class' => 'btn btn-success',
                                'data-confirm' => '¿Confirma que desea aprobar la demanda?'
                            ]) : null
                    ?>
                    <?= Yii::$app->user->can('demand/reject') && $model->demand_status_id == \app\models\DemandStatus::ENVIADA_ID ?
                        Html::a('<i class="glyphicon glyphicon-remove"></i>', "#",
                            [
                                'title' => 'Rechazar demanda',
                                'class' => 'btn btn-danger',
                                'onclick' => "rejectDemand({$model->id})"
                            ]) : null
                    ?>

                </div>
                <div class="col-md-3">
                    <label>Código</label>
                    <h5><?= $model->demand_code ?></h5>
                </div>
                <div class="col-md-3">
                    <label>Cliente</label>
                    <h5><?= $model->client->name ?></h5>
                </div>
                <div class="col-md-3">
                    <label>Organismo</label>
                    <h5><?= $model->client->organism->name ?></h5>
                </div>
                <div class="col-md-3">
                    <label>Estado</label>
                    <h5 class="text-uppercase <?= $model->classByStatus() ?>"
                        style="font-family: Roboto-bold"><?= $model->demandStatus->label ?></h5>
                </div>
                <div class="col-md-3">
                    <label>Fecha</label>
                    <h5><?= Yii::$app->formatter->asDate($model->sending_date) ?></h5>
                </div>
                <div class="col-md-3">
                    <label>UEB</label>
                    <h5><?= $model->client->provinceUeb->label ?></h5>
                </div>
                <div class="col-md-3">
                    <label>Listado validado</label>
                    <h5><?= $model->validatedList->label ?></h5>
                </div>
                <div class="col-md-3">
                    <label>Importe</label>
                    <h5><?= Yii::$app->formatter->asCurrency($model->totalAmount()) ?></h5>
                </div>
            </div>
            <?php
            if ($model->demand_status_id == \app\models\DemandStatus::RECHAZADA_ID) {
                ?>
                <div class="row">
                    <div class="col-sm-12">
                        <p class="text-danger"><b style="font-weight: bold">MOTIVO DE
                                RECHAZO: </b><?= $model->rejected_reason ?> </p>
                    </div>
                </div>

                <?php
            }
            ?>

            <div class="row p-0 m-0 mt-3">
                <div class="card-nav-tabs" style="width: 100%">
                    <div class="card-header m-0 p-0">
                        <?php
                        echo Tabs::widget([
                            'items' => [
                                [
                                    'label' => 'Requerimientos',
                                    'content' => $this->render('_requerimientos', ['model' => $model]),
                                    'active' => $active == 'requirements'
                                ],
                                [
                                    'label' => 'Otros detalles',
                                    'content' => $this->render('_details', ['model' => $model]),
                                    //'headerOptions' => [...],

                                ], [
                                    'label' => 'Relación de productos',
                                    'content' => $this->render('_items', ['model' => $model, 'searchModel' => $searchModel,
                                        'dataProvider' => $dataProvider]),
                                    'active' => $active == 'items'
                                    //'headerOptions' => [...],

                                ],

                            ],
                        ]);
                        ?>

                    </div>


                </div>
            </div>


        </div>

        <?php
        echo $this->registerJsFile('/js/demand/items.js', ['depends' => \yii\web\JqueryAsset::className()]);
        if ($model->demand_status_id == \app\models\DemandStatus::ENVIADA_ID) {
            echo $this->registerJsFile('/js/demand/index.js', ['depends' => \yii\web\JqueryAsset::className()]);
        }
        ?>
        <?php Pjax::end() ?>

    </div>
</div>
