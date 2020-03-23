<?php

use app\components\TabPanel;
use yii\helpers\Html;
use yii\bootstrap4\Modal;
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
                        Html::a("<span class='fa fa-check'></span>",['approve','id'=>$model->id],
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
                    if($model->buy_request_status_id!=\app\models\BuyRequestStatus::$SIN_TRAMITAR_ID&&$model->buy_request_status_id!=\app\models\BuyRequestStatus::$BORRADOR_ID&&$model->buy_request_status_id!=\app\models\BuyRequestStatus::$CANCELADA_ID){
                        ?>

                        <?= Yii::$app->user->can('buyrequest/export')?Html::a("<i class='center_fa fa fa-download '></i>",
                            ['export', 'id' => $model->id], ['class' => 'btn btn-success','target'=>'_blank' ,'title' => 'Exportar solicitud de compra']):null ?>
                        <?php
                    }
                    ?>

                    <?=Yii::$app->user->can('buyrequest/delete')&$model->buy_request_status_id==\app\models\BuyRequestStatus::$BORRADOR_ID?
                        Html::a("<span class='fa fa-trash'></span>",['delete','id'=>$model->id],
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
                        Html::a("<span class='fa fa-remove'></span>",'#',
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
                <div class="col-xs-12" style="width: 100%">

                    <?php
                    echo TabPanel::widget([
                            'items' => [
                                [
                                    'label' => 'Demandas asociadas',
                                    'content' =>$this->render('_demands_asociated', ['model' => $model]),
                                    'visible'=>Yii::$app->user->can('buyrequest/viewassociateddemands'),
                                    'active' =>  $active == 'demands_associated'
                                ],
                                [
                                    'label' => 'Productos',
                                    'content' =>$this->render('_products', ['model' => $model]),
                                    'visible'=>Yii::$app->user->can('buyrequest/viewproducts'),
                                    'active' =>   $active == 'products'
                                ],
                                [
                                    'label' => 'Propuestas',
                                    'content' =>Yii::$app->user->can('buyrequest/viewpropuestas')&&$model->buy_request_status_id!=\app\models\BuyRequestStatus::$BORRADOR_ID?
                                        $this->render('_propuestas_nacional', ['model' => $model]):'',
                                    'visible'=>Yii::$app->user->can('buyrequest/viewpropuestas')&&$model->buy_request_status_id!=\app\models\BuyRequestStatus::$BORRADOR_ID,
                                    'active'=>$active == 'propuestas'
                                ],
                                [
                                    'label' => 'Documentos',
                                    'content' =>Yii::$app->user->can('buyrequest/viewdocuments')&&$model->buyRequestDocuments?$this->render('_documentos', ['model' => $model]):'',
                                    'visible'=>Yii::$app->user->can('buyrequest/viewdocuments')&&$model->buyRequestDocuments,
                                    'active'=>$active == 'documentos'
                                ],
                                [
                                    'label' => 'Hitos',
                                    'content' =>Yii::$app->user->can('buyrequest/viewtransportation')&&$model->requestStages?$this->render('_hitos', ['model' => $model]):'',
                                    'visible'=>Yii::$app->user->can('buyrequest/viewtransportation')&&$model->requestStages,
                                    'active'=>$active == 'transportation'
                                ]

                            ]
                    ])
                    ?>
                </div>
            </div>
        </div>
    </div>


<?php
$this->registerJsFile('js/buy-request/updateNacional.js',['depends'=>\yii\web\JqueryAsset::className()])
?>