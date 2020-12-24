<?php

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
                        Html::a('<i class="fa fa-check"></i>', ["approve", 'id' => $model->id, 'return' => '/demand/view?id=' . $model->id],
                            [
                                'title' => 'Aprobar demanda',
                                'class' => 'btn btn-success',
                                'data-confirm' => '¿Confirma que desea aprobar la demanda?'
                            ]) : null
                    ?>
                    <?= Yii::$app->user->can('demand/reject') && $model->demand_status_id == \app\models\DemandStatus::ENVIADA_ID ?
                        Html::a('<i class="fa fa-remove"></i>', "#",
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
                    <div class="col-xs-12 " style="width: 100%">
                        <nav>
                            <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
                                <a class="nav-item nav-link <?= $active == 'requirements' ? 'active' : null ?>"
                                   id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab"
                                   aria-controls="nav-home" aria-selected="true">Requerimientos</a>
                                <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile"
                                   role="tab" aria-controls="nav-profile" aria-selected="false">Otros detalles</a>
                                <a class="nav-item nav-link <?= $active == 'items' ? 'active' : null ?>"
                                   id="nav-contact-tab"  data-toggle="tab"
                                   href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Productos</a>

                            </div>
                        </nav>
                        <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
                            <div class="tab-pane fade <?= $active == 'requirements' ? 'show active' : null ?>"
                                 id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                                <?= $this->render('_requerimientos', ['model' => $model]) ?>
                            </div>
                            <div class="tab-pane fade <?= $active == 'details' ? 'show active' : null ?>"
                                 id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                                <?= $this->render('_details', ['model' => $model]) ?>
                            </div>
                            <div class="tab-pane fade <?= $active == 'items' ? 'show active' : null ?>" id="nav-contact"
                                 role="tabpanel" aria-labelledby="nav-contact-tab">
                                <?= $this->render('_items', ['model' => $model, 'searchModel' => $searchModel,
                                    'dataProvider' => $dataProvider]) ?>
                            </div>

                        </div>

                    </div>

            </div>


        </div>
    </div>


</div>

<?php
echo $this->registerJsFile('/js/demand/items.js', ['depends' => \yii\web\JqueryAsset::className()]);
echo $this->registerCssFile('/css/tabs.css');
if ($model->demand_status_id == \app\models\DemandStatus::ENVIADA_ID) {
    echo $this->registerJsFile('/js/demand/index.js', ['depends' => \yii\web\JqueryAsset::className()]);
}
?>
<?php Pjax::end() ?>

</div>
</div>
