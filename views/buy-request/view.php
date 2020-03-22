<?php

use app\models\User;
use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\BuyRequest */

$this->title = 'Detalles de la solicitud de compra';
$this->params['breadcrumbs'][] = ['label' => 'Solicitudes de compra', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?= $this->title ?></h4>

    </div>
    <div class="card-body" style="padding: 15px">
        <p style="text-align: right">
            <?= Yii::$app->user->can('buyrequest/golapproved')&&!$model->approved_by?Html::a("<span class='fa fa-ckeck'></span>",
                ['gol-approved', 'id' => $model->id],
                ['class' => 'btn btn-success',
                    'data-confirm'=>'¿Confirma que desea aprobar esta solicitud?',
                    'title' => 'Dar aprobación técnica.']) :null?>
            <?= Yii::$app->user->can('buyrequest/assignbuyer')?Html::a("<span class='fa fa-user'></span> Comprador",
                '#',
                [
                    'class' => "btn btn-primary",
                    'title' => 'Asignar/Reasignar el comprador que gestionará esta orden.',
                    'onclick'=>'assignUser('.$model->id.',"comprador")'
                ]) :null?>
            <?= Yii::$app->user->can('buyrequest/buyapproved')&&!$model->buy_approved_by&&$model->buyer_assigned?
                Html::a("<span class='fa fa-check'></span>",
                    ['buy-approved', 'id' => $model->id],
                    ['class' => 'btn btn-success',
                        'data-confirm'=>'¿Confirma que desea aprobar esta solicitud?',
                        'title' => 'Dar aprobación técnica.']) :null?>
            <?= Yii::$app->user->can('buyrequest/dtapproved')&&!$model->dt_approved_by&&$model->dt_specialist_assigned?
                Html::a("<span class='fa fa-check'></span>",
                ['dt-approved', 'id' => $model->id],
                ['class' => 'btn btn-success',
                    'data-confirm'=>'¿Confirma que desea aprobar esta solicitud?',
                    'title' => 'Dar aprobación técnica.']) :null?>
            <?= Yii::$app->user->can('buyrequest/assignet')?Html::a("<span class='fa fa-user'></span> ET",
                '#',
                [
                    'class' => 'btn btn-success',
                    'title' => 'Asignar/Reasignar el especialista técnico que evaulará las ofertas.',
                    'onclick'=>'assignUser('.$model->id.',"et")'
                ]) :null?>

            <?= Yii::$app->user->can('buyrequest/update')?Html::a("<span class='fa fa-pencil'></span>",
                ['update','id'=>$model->id],
                [
                    'class' => 'btn btn-success',
                    'title' => 'Modificar orden de compra',

                ]) :null?>
            <?php
            if($model->buy_request_status_id!=\app\models\BuyRequestStatus::$SIN_TRAMITAR_ID&&$model->buy_request_status_id!=\app\models\BuyRequestStatus::$BORRADOR_ID&&$model->buy_request_status_id!=\app\models\BuyRequestStatus::$CANCELADA_ID){
                ?>

                <?= Yii::$app->user->can('buyrequest/export')?Html::a("<i class='center_fa fa fa-download '></i>",
                    ['export', 'id' => $model->id], ['class' => 'btn btn-success','target'=>'_blank' ,'title' => 'Exportar solicitud de compra']):null ?>
                <?php
            }
            ?>
        </p>
        <div class="row">
            <div class="col-md-12">
                <?=$model->buy_request_type_id==\app\models\BuyRequestType::$NACIONAL_ID?
                    Html::input('hidden',null,json_encode(User::combo(\app\models\Rbac::$COMPRADOR_NACIONAL)),['id'=>'data_comprador']):null?>
                <?=$model->buy_request_type_id==\app\models\BuyRequestType::$INTERNACIIONAL_ID?
                    Html::input('hidden',null,json_encode(User::combo(\app\models\Rbac::$COMPRADOR_INTERNACIONAL)),['id'=>'data_comprador']):null?>
                <?=Html::input('hidden',null,json_encode(User::combo(\app\models\Rbac::$ESP_TECNICO)),['id'=>'data_tecnico'])?>
                <table class="table table-striped table-bordered detail-view">
                    <tbody>
                    <tr>
                        <th>
                            <label>Código</label>
                            <p><?= $model->code ?></p>
                        </th>
                        <th>
                            <label>Tipo</label>
                            <p><?= $model->demandItems[0]->validatedListItem->validatedList->label ?></p>
                        </th>
                        <th>
                            <label>Cliente(s)</label>
                            <?php
                            foreach ($model->clientes() as $cliente) {
                                ?>
                                <p><?= $cliente->name . ' (' . $cliente->organism->short_name . ')' ?></p>
                                <?php
                            }
                            ?>
                        </th>
                        <th>
                            <label>Fecha de creación</label>
                            <p><?= Yii::$app->formatter->asDate($model->created) ?></p>
                        </th>
                        <th>
                            <label>Estado</label>
                            <p class="<?= $model->classByStatus() ?>"><b><?= $model->buyRequestStatus->label ?></b></p>
                        </th>
                    </tr>
                    <tr>
                        <th colspan="2">
                            <label>Comprador asignado</label>
                            <?php
                                if($model->buyer_assigned){
                                    echo "<p>{$model->buyerAssigned->full_name}</p>";
                                }else{
                                    echo "<p class='text-danger'>(No asignado)</p>";
                                }
                            ?>
                        </th>
                        <th >
                            <label>Especialista tecnico asignado</label>
                            <?php
                            if($model->dt_specialist_assigned){
                                echo "<p>{$model->dtSpecialistAssigned->full_name}</p>";
                            }else{
                                echo "<p class='text-danger'>(No asignado)</p>";
                            }
                            ?>
                        </th>
                        <th>
                            <label>Total de productos</label>
                            <p><?=count($model->getProducts())?></p>
                        </th>
                        <th>
                            <label>Monto</label>
                            <p><?=$model->ammount(true)?></p>
                        </th>

                    </tr>
                    <tr>
                        <th colspan="5">
                            <label>Productos</label><div class="p-4">
                                <table class="table table-condensed">
                                    <thead>
                                    <tr>
                                        <th style="width: 60%">
                                            Relación de productos
                                        </th>
                                        <th style="width: 10%">Cantidad</th>
                                        <th style="width: 10%">Precio</th>
                                        <th style="width: 20%">Importe</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php
                                    foreach ($model->getProducts() as $product){
                                        ?>
                                        <tr>
                                            <th style="width: 60%">
                                                <?=$product->product_name?>
                                            </th>
                                            <td><?=$product->quantity?></td>
                                            <td><?=$product->price?></td>
                                            <td><?=Yii::$app->formatter->asCurrency($product->quantity*$product->price)?></td>
                                        </tr>
                                        <?php
                                    }
                                    ?>
                                    </tbody>
                                </table>
                            </div>

                        </th>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
<?php
$this->registerJsFile('/js/buy-request/view.js',['depends'=>\yii\web\JqueryAsset::className()])
?>