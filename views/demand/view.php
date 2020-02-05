<?php

use yii\helpers\Html;
use yii\widgets\DetailView;
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
            <h4 class="card-title"><?=$this->title?></h4>
            <p class="card-category"></p>
        </div>
        <?php Pjax::begin(['id'=>'titulos','timeout' => 5000])?>
        <div class="card-body" >
            <div class="row">
                <div class="col-md-3">
                    <label>Código</label>
                    <h5><?=$model->demand_code?></h5>
                </div>
                <div class="col-md-3">
                    <label>Cliente</label>
                    <h5><?=$model->client->name?></h5>
                </div>
                <div class="col-md-3">
                    <label>Organismo</label>
                    <h5><?=$model->client->organism->name?></h5>
                </div>
                <div class="col-md-3">
                    <label>Estado</label>
                    <h5 class="text-uppercase <?=$model->classByStatus()?>" style="font-family: Roboto-bold"><?=$model->demandStatus->label?></h5>
                </div>
                <div class="col-md-3">
                    <label>Fecha</label>
                    <h5><?=Yii::$app->formatter->asDate($model->sending_date)?></h5>
                </div>
                <div class="col-md-3">
                    <label>UEB</label>
                    <h5><?=$model->client->provinceUeb->label?></h5>
                </div>
                <div class="col-md-3">
                    <label>Listado validado</label>
                    <h5><?=$model->validatedList->label?></h5>
                </div>
                <div class="col-md-3">
                    <label>Importe</label>
                    <h5><?=Yii::$app->formatter->asCurrency($model->totalAmount())?></h5>
                </div>
            </div>

                  <div class="row p-0 m-0 mt-3">
                <div class="card-nav-tabs" style="width: 100%">
                    <div class="card-header m-0 p-0">
                        <div class="nav-tabs-navigation">

                            <div class="nav-tabs-wrapper">
                                <ul class="nav nav-tabs" data-tabs="tabs">
                                    <li class="<?=$active=='requirements'?'active':null?>">
                                        <a href="#requirements"  data-toggle="tab">Requerimientos</a>
                                    </li>
                                    <li class="">
                                        <a  href="#details" class="" data-toggle="tab">Otros detalles</a>
                                    </li>
                                    <li class="<?=$active=='items'?'active':null?>">
                                        <a href="#items"  data-toggle="tab">Relación de productos<span class="badge badge-inma-tab <?=count($model->sinClasificar())?'':'hidden'?>"><?=count($model->sinClasificar())?></span></a>
                                    </li>
                                </ul>
                            </div>

                        </div>
                    </div>

                    <div class="card-content p-0" style="background: #F2F2F2;min-height: 500px">
                        <div class="tab-content">
                            <div class="tab-pane <?=$active=='requirements'?'active':null?>" id="requirements">
                                <?php echo $this->render('_requerimientos',['model'=>$model]); ?>
                            </div>
                            <div class="tab-pane " id="details">
                                <?php echo $this->render('_details',['model'=>$model]); ?>
                            </div>
                            <div class="tab-pane <?=$active=='items'?'active':null?>" id="items">
                                <?php echo $this->render('_items',['model'=>$model, 'searchModel' => $searchModel,
                                    'dataProvider' => $dataProvider]); ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>

        <?php
        echo $this->registerJsFile('/js/demand/items.js',['depends'=>\yii\web\JqueryAsset::className()])
        ?>
        <?php Pjax::end()?>

    </div>
</div>
