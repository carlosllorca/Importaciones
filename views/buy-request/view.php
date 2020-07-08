<?php

use app\models\User;
use yii\helpers\Html;
use miloschuman\highcharts\Highcharts;

/* @var $this yii\web\View */
/* @var $model app\models\BuyRequest */

$this->title = 'Detalles de la solicitud de compra';
$this->params['breadcrumbs'][] = ['label' => 'Solicitudes de compra', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
$seriesData = \app\models\DataGraphics::linearComparativeBuyRequest($model->id);
?>
<?= $model->buy_request_type_id == \app\models\BuyRequestType::$NACIONAL_ID || $model->buy_request_type_id == \app\models\BuyRequestType::$TYPE_711 ?
    Html::input('hidden', null, json_encode(User::combo(\app\models\Rbac::$COMPRADOR,$model->buy_request_type_id)), ['id' => 'data_comprador']) : null ?>
<?= $model->buy_request_type_id == \app\models\BuyRequestType::$INTERNACIIONAL_ID ?
    Html::input('hidden', null, json_encode(User::combo(\app\models\Rbac::$COMPRADOR,$model->buy_request_type_id)), ['id' => 'data_comprador']) : null ?>
<?= Html::input('hidden', null, json_encode(User::combo(\app\models\Rbac::$ESP_TECNICO,$model->buy_request_type_id)), ['id' => 'data_tecnico']) ?>

    <div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?= $this->title ?></h4>

    </div>
    <div class="card-body" style="padding: 15px">
        <p style="text-align: right">
            <?= Yii::$app->user->can('buyrequest/golapproved') && !$model->approved_by ? Html::a("<span class='fa fa-ckeck'></span>",
                ['gol-approved', 'id' => $model->id],
                ['class' => 'btn btn-success',
                    'data-confirm' => '¿Confirma que desea aprobar esta solicitud?',
                    'title' => 'Dar aprobación técnica.']) : null ?>
            <?= Yii::$app->user->can('buyrequest/assignbuyer') ? Html::a("<span class='fa fa-user'></span> Comprador",
                '#',
                [
                    'class' => "btn btn-primary",
                    'title' => 'Asignar/Reasignar el comprador que gestionará esta orden.',
                    'onclick' => 'assignUser(' . $model->id . ',"comprador")'
                ]) : null ?>
            <?= Yii::$app->user->can('buyrequest/buyapproved') && !$model->buy_approved_by && $model->buyer_assigned ?
                Html::a("<span class='fa fa-check'></span>",
                    ['buy-approved', 'id' => $model->id],
                    ['class' => 'btn btn-success',
                        'data-confirm' => '¿Confirma que desea aprobar esta solicitud?',
                        'title' => 'Dar aprobación técnica.']) : null ?>
            <?= Yii::$app->user->can('buyrequest/dtapproved') && !$model->dt_approved_by && $model->dt_specialist_assigned ?
                Html::a("<span class='fa fa-check'></span>",
                    ['dt-approved', 'id' => $model->id],
                    ['class' => 'btn btn-success',
                        'data-confirm' => '¿Confirma que desea aprobar esta solicitud?',
                        'title' => 'Dar aprobación técnica.']) : null ?>
            <?= Yii::$app->user->can('buyrequest/assignet') ? Html::a("<span class='fa fa-user'></span> ET",
                '#',
                [
                    'class' => 'btn btn-success',
                    'title' => 'Asignar/Reasignar el especialista técnico que evaulará las ofertas.',
                    'onclick' => 'assignUser(' . $model->id . ',"et")'
                ]) : null ?>

            <?= Yii::$app->user->can('buyrequest/update') ? Html::a("<span class='fa fa-pencil'></span>",
                ['update', 'id' => $model->id],
                [
                    'class' => 'btn btn-success',
                    'title' => 'Modificar orden de compra',

                ]) : null ?>
            <?php
            if ($model->buy_request_status_id != \app\models\BuyRequestStatus::$SIN_TRAMITAR_ID && $model->buy_request_status_id != \app\models\BuyRequestStatus::$BORRADOR_ID && $model->buy_request_status_id != \app\models\BuyRequestStatus::$CANCELADA_ID) {
                ?>

                <?= Yii::$app->user->can('buyrequest/export') ? Html::a("<i class='center_fa fa fa-download '></i>",
                    ['export', 'id' => $model->id], ['class' => 'btn btn-success', 'target' => '_blank', 'title' => 'Exportar solicitud de compra']) : null ?>
                <?php
            }
            ?>
            <span CLASS="text-title" style="margin-left: 10px; ">ESTADO:</span>
            <b CLASS="text-title text-uppercase <?=$model->classByStatus()?>" ><?=$model->buyRequestStatus->label?></b>
        </p>
        <div class="row">
            <div class="col-sm-8 card" style="padding-right: 20px">
                <div class="card-header card-header-primary">
                    Datos Generales
                </div>
                <div class="card-body" style="padding: 15px!important;">
                    <div class="row">
                        <div class="col-sm-3">
                            <b class="text-title">Código:</b>
                        </div>
                        <div class="col-sm-9"><p class="text-subtitle"><?= $model->code ?></p></div>
                    </div>
                    <div class="row" class="border-bottom">
                        <div class="col-sm-3">
                            <b class="text-title">Tipo:</b>
                        </div>
                        <div class="col-sm-9"><p
                                    class="text-subtitle"> <?php foreach ($model->getDemandsType() as $type) echo $type->label . "<br>" ?></p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-3">
                            <b class="text-title">Fecha creación:</b>
                        </div>
                        <div class="col-sm-9"><p
                                    class="text-subtitle"><?= Yii::$app->formatter->asDate($model->created) ?></p></div>
                    </div>
                    <div class="row">
                        <div class="col-sm-3">
                            <b class="text-title">Creado por:</b>
                        </div>
                        <div class="col-sm-9"><p class="text-subtitle"><?= $model->createdBy->full_name ?></p></div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <label>Especialista tecnico asignado</label>
                            <?php
                            if ($model->dt_specialist_assigned) {
                                echo "<p>{$model->dtSpecialistAssigned->full_name}</p>";
                            } else {
                                echo "<p class='text-danger'>(No asignado)</p>";
                            }
                            ?>
                        </div>
                        <div class="col-md-4">
                            <label>Comprador asignado</label>
                            <?php
                            if ($model->buyer_assigned) {
                                echo "<p>{$model->buyerAssigned->full_name}</p>";
                            } else {
                                echo "<p class='text-danger'>(No asignado)</p>";
                            }
                            ?>
                        </div>
                        <div class="col-md-2">
                            <label>Total de productos</label>
                            <p><?= count($model->getProducts()) ?></p>
                        </div>
                        <div class="col-md-2">
                            <label>Monto</label>
                            <p><?= $model->ammount(true) ?></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4 card">
                <div class="card-header card-header-primary">
                    Estado de la contratación
                </div>
                <div class="card-body" style="padding: 15px!important;">
                    <div class="row">

                        <div class="col-sm-12">
                            <?= Highcharts::widget([
                                'scripts' => [
                                    'themes/grid-light',
                                ],
                                'options' => [
                                    'credits' => 'false',
                                    'title' => false,
                                    'xAxis' => [
                                        'categories' => $seriesData[0],
                                        'visible' => false
                                    ],
                                    'yAxis' => [
                                        'title' => [
                                            "text" => 'Tiempo en días'
                                        ],
                                        'min' => 0
                                    ],
                                    'legend' => [
                                        'reversed' => false
                                    ],
                                    'plotOptions' => [
                                        'series' => [
                                            'label' => [
                                                'connectorAllowed' => false
                                            ]
                                        ]
                                    ],
                                    'series' => $seriesData[1],

                                ]
                            ]); ?>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-sm-6 card">
                <div class="card-header card-header-primary">
                    Productos
                </div>
                <div class="card-body" style="padding: 15px!important;">
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table table-condensed">
                                <thead>
                                <tr>
                                    <th style="width: 60%">
                                        Nombre del producto
                                    </th>
                                    <th style="width: 10%">Cantidad</th>
                                    <th style="width: 10%">Precio</th>
                                    <th style="width: 20%">Importe</th>
                                </tr>
                                </thead>
                                <tbody>
                                <?php
                                foreach ($model->getProducts() as $product) {
                                    ?>
                                    <tr>
                                        <th style="width: 60%">
                                            <?= $product->product_name ?>
                                        </th>
                                        <td><?= $product->quantity ?></td>
                                        <td><?= $product->price ?></td>
                                        <td><?= Yii::$app->formatter->asCurrency($product->quantity * $product->price) ?></td>
                                    </tr>
                                    <?php
                                }
                                ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 card">

                <div class="card-header card-header-primary">
                    Demandas asociadas
                </div>
                <div class="card-body" style="padding: 15px!important;">
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table table-condensed">
                                <thead>
                                <tr>
                                    <th>
                                        Código
                                    </th>
                                    <th>Fecha envío</th>

                                    <th>UEB</th>
                                    <th>Cliente/Organismo</th>
                                    <th>Estado</th>
                                </tr>
                                </thead>
                                <tbody>
                                <?php
                                foreach ($model->getDemands() as $demand) {
                                    ?>
                                    <tr>
                                        <th>
                                            <?= $demand->demand_code ?>
                                        </th>
                                        <td><?= Yii::$app->formatter->asDate($demand->sending_date) ?></td>
                                        <td><?= $demand->client->provinceUeb->label ?></td>
                                        <td><?= $demand->client->name ?>/<br><?= $demand->client->organism->name ?></td>
                                        <td><?= $demand->demandStatus->label ?></td>
                                    </tr>
                                    <?php
                                }
                                ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <?php
            if (Yii::$app->user->can('buyrequest/viewpropuestas') &&$model->buy_request_type_id==\app\models\BuyRequestType::$INTERNACIIONAL_ID&& $model->buy_request_status_id != \app\models\BuyRequestStatus::$BORRADOR_ID) {
                ?>
                <div class="col-sm-6 card">

                    <div class="card-header card-header-primary">
                        Información de la licitación
                    </div>
                    <div class="card-body" style="padding: 15px!important;">
                        <div class="row">
                            <div class="col-md-12">
                                <?php
                                if ($model->buyRequestInternational && $model->buyRequestInternational->bidding_start) {
                                    ?>
                                    <div class="row">
                                        <div class="col-sm-2 text-center">
                                            <label>Fecha inicio</label>
                                            <p><?= Yii::$app->formatter->asDate($model->buyRequestInternational->bidding_start) ?></p>
                                        </div>
                                        <div class="col-sm-2 text-center">
                                            <label>Fecha Fin</label>
                                            <p><?= Yii::$app->formatter->asDate($model->buyRequestInternational->bidding_end) ?></p>
                                        </div>
                                        <div class="col-sm-3 text-center">
                                            <label>Instrumento de pago</label>
                                            <p><?= $model->buyRequestInternational->paymentInstrument->label ?></p>
                                        </div>
                                        <div class="col-sm-3 text-center">
                                            <label>Destino</label>
                                            <p><?= $model->buyRequestInternational->destiny->label ?></p>
                                        </div>
                                        <div class="col-sm-2 text-center">
                                            <label>Condición de la compra</label>
                                            <p><?= $model->buyRequestInternational->buyCondition->label ?></p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table class="table table-condensed">
                                                <thead>
                                                <tr>
                                                    <th>
                                                        Proveedor
                                                    </th>
                                                    <th>Estado</th>
                                                    <th>Ganador</th>

                                                </tr>
                                                </thead>
                                                <tbody>
                                                <?php
                                                foreach ($model->buyRequestProviders as $buyRequestProvider) {
                                                    ?>
                                                    <tr>
                                                        <th>
                                                            <?= $buyRequestProvider->provider->name ?>
                                                        </th>
                                                        <td><?= $buyRequestProvider->providerStatus->label ?></td>
                                                        <td><?= $buyRequestProvider->winner ? 'Si' : 'No' ?></td>

                                                    </tr>
                                                    <?php
                                                }
                                                ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <?php
                                } else {
                                    ?>
                                    <p class="noData">
                                        Sin información.
                                    </p>
                                    <?php
                                }
                                ?>

                            </div>
                        </div>
                    </div>
                </div>
                <?php
            }
            ?>
            <?php
            if (Yii::$app->user->can('buyrequest/viewpropuestas') &&$model->buy_request_type_id==\app\models\BuyRequestType::$INTERNACIIONAL_ID && $model->buy_request_status_id != \app\models\BuyRequestStatus::$BORRADOR_ID) {
                ?>
                <div class="col-sm-6 card">

                    <div class="card-header card-header-primary">
                        Notificaciones a proveedores
                    </div>
                    <div class="card-body" style="padding: 15px!important;">
                        <div class="row">
                            <div class="col-md-12">
                                <?php
                                if ($model->emailNotifies) {
                                    ?>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table class="table table-condensed">
                                                <thead>
                                                <tr>
                                                    <th>Fecha</th>
                                                    <th>Inicio licitación</th>
                                                    <th>Fin licitación</th>
                                                    <th>Mensaje</th>
                                                    <th>Adjunto enviado</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <?php
                                                foreach ($model->emailNotifies as $emailNotify) {
                                                    ?>
                                                    <tr>
                                                        <th><?= Yii::$app->formatter->asDate($emailNotify->sended_date) ?></th>
                                                        <th><?= Yii::$app->formatter->asDate($emailNotify->bidding_start) ?></th>
                                                        <th><?= Yii::$app->formatter->asDate($emailNotify->bidding_end) ?></th>
                                                        <th><?= $emailNotify->body ?></th>
                                                        <th><a href="/<?= $emailNotify->attachment ?>"><i
                                                                        class="fa fa-download"
                                                            </a></th>

                                                    </tr>
                                                    <?php
                                                }
                                                ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <?php

                                } else {
                                    ?>
                                    <p class="noData">
                                        Sin información.
                                    </p>
                                    <?php
                                }
                                ?>


                            </div>
                        </div>
                    </div>
                </div>
                <?php
            }
            ?>
            <?php
            if (Yii::$app->user->can('buyrequest/viewdocuments')) {
                ?>
                <div class="col-sm-6 card">

                    <div class="card-header card-header-primary">
                        Documentos
                    </div>
                    <div class="card-body" style="padding: 15px!important;">
                        <div class="row">
                            <div class="col-md-12">
                                <?php
                                $porciento = $model->documentUploadStatus();
                                ?>
                                <div class="progress" title="Estado de los documentos necesarios aprobados." style="margin: 10px">
                                    <div class="progress-bar" role="progressbar" style="width: <?=$porciento?>%;" aria-valuenow="<?=$porciento?>" aria-valuemin="0" aria-valuemax="100"><?=$model->documentUploadStatus()?>%</div>
                                </div>
                                <table class="table table-striped table-bordered" style="margin: 5px">
                                    <thead>
                                    <tr>
                                        <th>Documento</th>

                                        <th>Estado</th>

                                        <th>Subido por</th>
                                        <th>Fecha</th>
                                        <th class="<?=$model->buy_request_status_id!=\app\models\BuyRequestStatus::$CERRADA?'':'hidden'?>"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php
                                    if(count($model->documentsUser())==0){
                                        ?>
                                        <tr>
                                            <th colspan="5"><p style="text-align: center;color: #cecece">Usted no tiene acceso a ningún documento de este expediente.
                                                    Pongase en contacto con la administración si cree que esto es un error.</p> </th>
                                        </tr>
                                        <?php
                                    }
                                    foreach ($model->documentsUser() as $buyRequestDocument) {
                                        ?>
                                        <tr>
                                            <th><?=$buyRequestDocument->documentType? $buyRequestDocument->documentType->label:$buyRequestDocument->custom_file ?></th>

                                            <th><b class="<?=$buyRequestDocument->documentStatus->classByStatus()?>"><?=$buyRequestDocument->documentStatus->label?></b></th>

                                            <th><?= $buyRequestDocument->url_to_file ? $buyRequestDocument->lastUpdatedBy->full_name : '-' ?></th>
                                            <th><?= $buyRequestDocument->url_to_file ? Yii::$app->formatter->asDate($buyRequestDocument->last_update) : '-' ?></th>
                                            <th class="">
                                                <?= $buyRequestDocument->url_to_file ? Html::a("<span class='fa fa-download'></span>", $buyRequestDocument->url_to_file, ['target' => '_blank', 'title' => 'Descargar']) : '' ?>

                                            </th>
                                        </tr>
                                        <?php
                                    } ?>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <?php
            }
            if(Yii::$app->user->can('buyrequest/viewtransportation')){
                ?>
                <div class="col-sm-6 card">

                    <div class="card-header card-header-primary">
                        Estado del ciclo de transportación
                    </div>
                    <div class="card-body" style="padding: 15px!important;">
                        <div class="row">
                            <div class="col-md-12">
                                <?php
                                $porciento = $model->percentCompletedStages();
                                ?>
                                <div class="progress" title="Cumplimiento del ciclo de transportación." style="margin: 10px">
                                    <div class="progress-bar" role="progressbar" style="width: <?=$porciento?>%;" aria-valuenow="<?=$porciento?>" aria-valuemin="0" aria-valuemax="100"><?=$model->documentUploadStatus()?>%</div>
                                </div>
                                <?php
                                if ($model->requestStages) {
                                    ?>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table class="table table-condensed">
                                                <thead>
                                                <tr>
                                                    <th>Inicio</th>
                                                    <th>Fin</th>
                                                    <th>Hito</th>
                                                    <th>Cumplido</th>

                                                </tr>
                                                </thead>
                                                <tbody>
                                                <?php
                                                foreach ($model->requestStageOrdenados() as $requestStageOrdenado) {
                                                    ?>
                                                    <tr>
                                                        <th><?= Yii::$app->formatter->asDate($requestStageOrdenado->date_start) ?></th>
                                                        <th><?= Yii::$app->formatter->asDate($requestStageOrdenado->date_end) ?></th>
                                                        <th><?= $requestStageOrdenado->stage->label ?></th>
                                                        <th><?=$requestStageOrdenado->real_end?"<i style='color: darkgreen' class='fa fa-check'></i>":null?></th>


                                                    </tr>
                                                    <?php
                                                }
                                                ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <?php

                                } else {
                                    ?>
                                    <p class="noData">
                                        No iniciado.
                                    </p>
                                    <?php
                                }
                                ?>


                            </div>
                        </div>
                    </div>
                </div>
                <?php
            }

            ?>

        </div>
    </div>
<?php
$this->registerJsFile('/js/buy-request/view.js', ['depends' => \yii\web\JqueryAsset::className()])
?>