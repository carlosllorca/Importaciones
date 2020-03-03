<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\BuyRequest */
/* @var $active string */

$this->title = 'Actualizar solicitud de compra ';
$this->params['breadcrumbs'][] = ['label' => 'Solicitudes de compra', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->code, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Actualizar';
?>
<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?=$this->title?></h4>
    </div>


    <div class="card-body" style="padding: 15px">
        <div class="row" style="padding-left: 3rem; padding-right: 3rem;">
            <div class="col-sm-12" style="text-align: right">
                <?=Yii::$app->user->can('buyrequest/approve')&$model->buy_request_status_id==\app\models\BuyRequestStatus::$BORRADOR_ID||$model->buy_request_status_id==\app\models\BuyRequestStatus::$CANCELADA_ID?
                    Html::a("<span class='glyphicon glyphicon-ok'></span>",['approve','id'=>$model->id],
                        [
                            'title'=>'Aprobar solicitud',
                            'data'=>[
                                'confirm'=>'¿Está seguro que desea aprobar esta solicitud?',
                                'method'=>'POST'
                            ],
                            'class'=>'btn btn-success'
                        ])
                    :null?>
                <?php
                    if($model->buy_request_status_id!=\app\models\BuyRequestStatus::$BORRADOR_ID&&$model->buy_request_status_id!=\app\models\BuyRequestStatus::$CANCELADA_ID){
                        ?>

                        <?= Yii::$app->user->can('buyrequest/export')?Html::a("<i class='center_fa fa fa-file-pdf-o '></i>",
                            ['export', 'id' => $model->id,'format'=>'pdf'], ['class' => 'btn btn-success','target'=>'_blank' ,'title' => 'Exportar a PDF']):null ?>
                        <?= Yii::$app->user->can('buyrequest/export')?Html::a("<i class='center_fa fa fa-file-excel-o'></i>",
                            ['export', 'id' => $model->id,'format'=>'xls'], ['class' => "btn btn-success disabled",'target'=>'_blank' ,'title' => 'Exportar a Excel']):null ?>
                        <?php
                    }
                ?>

                <?=Yii::$app->user->can('buyrequest/delete')&$model->buy_request_status_id==\app\models\BuyRequestStatus::$BORRADOR_ID?
                    Html::a("<span class='glyphicon glyphicon-trash'></span>",['delete','id'=>$model->id],
                        [
                            'title'=>'Eliminar solicitud',
                            'data'=>[
                                    'confirm'=>'¿Está seguro que desea eliminar?',
                                    'method'=>'POST'
                            ],
                            'class'=>'btn btn-danger'
                        ])
                    :null?>
                <?=Yii::$app->user->can('buyrequest/reject')&($model->buy_request_status_id!=\app\models\BuyRequestStatus::$BORRADOR_ID&$model->buy_request_status_id!=\app\models\BuyRequestStatus::$CANCELADA_ID&$model->buy_request_status_id!=\app\models\BuyRequestStatus::$CERRADA)?
                    Html::a("<span class='glyphicon glyphicon-remove'></span>",'#',
                        [
                            'title'=>'Cancelar solicitud',
                            'onClick'=>"reject({$model->id})",
                            'class'=>'btn btn-danger'
                        ])
                    :null?>


            </div>
            <div class="col-sm-4 col-md-3">
                <label>Código</label>
                <h5><?=$model->code?></h5>
            </div>
            <div class="col-sm-4 col-md-3">
                <label>Creado</label>
                <h5><?=Yii::$app->formatter->asDate($model->created)?></h5>
            </div>
            <div class="col-sm-4 col-md-3">
                <label>Importe</label>
                <h5><?=$model->ammount(true)?></h5>
            </div>
            <div class="col-sm-4 col-md-3">
                <label>Estado</label>
                <h5 class="<?=$model->classByStatus()?>"><b><?=$model->buyRequestStatus->label?></b></h5>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12" style="padding-left: 3rem;">
                <?php
                if($model->buy_request_status_id==\app\models\BuyRequestStatus::$CANCELADA_ID){
                    ?>
                    <p class="text-danger" style="margin: 0px"><b><?=$model->buyRequestStatus->label?>: </b><?=$model->cancel_reason?></p>
                    <?php
                }
                ?>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="row p-0 m-0 mt-3">
                    <div class="card-nav-tabs" style="width: 100%">
                        <div class="card-header m-0 p-0">
                            <div class="nav-tabs-navigation">
                                <div class="nav-tabs-wrapper">
                                    <ul class="nav nav-tabs" data-tabs="tabs">
                                        <?php
                                                if(Yii::$app->user->can('buyrequest/viewassociateddemands')){
                                                    ?>
                                                    <li class="<?= $active == 'demands_associated' ? 'active' : null ?>">
                                                        <a href="#demands_associated" data-toggle="tab">Demandas asociadas</a>
                                                    </li>
                                                    <?php
                                                }
                                        ?>
                                        <?php
                                        if(Yii::$app->user->can('buyrequest/viewproducts')){
                                            ?>
                                            <li class="<?= $active == 'products' ? 'active' : null ?>">
                                                <a href="#products" class="" data-toggle="tab">Productos</a>
                                            </li>
                                            <?php
                                        }
                                        ?>
                                        <?php
                                        if(Yii::$app->user->can('buyrequest/viewpropuestas')&&$model->buy_request_status_id!=\app\models\BuyRequestStatus::$BORRADOR_ID){
                                            ?>
                                            <li class="<?= $active == 'propuestas' ? 'active' : null ?>">
                                                <a href="#propuestas" data-toggle="tab">Propuestas de proveedores</a>
                                            </li>
                                            <?php
                                        }
                                        ?>
                                        <?php
                                        if(Yii::$app->user->can('buyrequest/viewdocuments')&&$model->buyRequestDocuments){
                                            ?>
                                            <li class="<?= $active == 'documentos' ? 'active' : null ?>">
                                                <a href="#documentos" data-toggle="tab">Documentos</a>
                                            </li>
                                            <?php
                                        }
                                        ?>
                                    </ul>
                                </div>

                            </div>
                        </div>

                        <div class="card-content p-0" style="background: #F2F2F2;min-height: 500px">
                            <div class="tab-content">
                                <?php
                                if(Yii::$app->user->can('buyrequest/viewassociateddemands')){
                                    ?>
                                    <div class="tab-pane <?= $active == 'demands_associated' ? 'active' : null ?>" id="demands_associated">
                                        <?php echo $this->render('_demands_asociated', ['model' => $model]); ?>
                                    </div>
                                    <?php
                                }
                                ?>
                                <?php
                                if(Yii::$app->user->can('buyrequest/viewproducts')){
                                    ?>
                                    <div class="tab-pane <?= $active == 'products' ? 'active' : null ?>" id="products">
                                        <?php echo $this->render('_products', ['model' => $model]); ?>
                                    </div>
                                    <?php
                                }
                                ?>
                                <?php
                                if(Yii::$app->user->can('buyrequest/viewpropuestas')){
                                    ?>
                                    <div class="tab-pane <?= $active == 'propuestas' ? 'active' : null ?>" id="propuestas">
                                        <?php echo $this->render('_propuestas', ['model' => $model]); ?>
                                    </div>
                                    <?php
                                }
                                ?>

                                <?php
                                if(Yii::$app->user->can('buyrequest/viewdocuments')){
                                    ?>
                                    <div class="tab-pane <?= $active == 'documentos' ? 'active' : null ?>" id="documentos">
                                        <?php echo $this->render('_documentos', ['model' => $model]); ?>
                                    </div>
                                    <?php
                                }
                                ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<?php
$this->registerJsFile('js/buy-request/update.js',['depends'=>\yii\web\JqueryAsset::className()])
?>