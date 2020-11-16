<?php
use yii\helpers\Html;

/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */
?>
<div class="row p-5">
    <?php
    if ($model->buy_request_status_id == \app\models\BuyRequestStatus::$BORRADOR_ID) {
        ?>
        <div class="col-sm-12">
            <table class="table table-striped table-bordered">
                <thead>
                <tr>

                    <th>Demanda</th>
                    <th>Modelo y/o Número de parte del producto</th>
                    <th>Cantidad</th>
                    <th>Precio (UV)</th>
                    <th>Importe</th>

                </tr>
                </thead>
                <tbody>
                <?php
                foreach ($model->demandItems as $product) {
                    ?>
                    <tr>

                        <th><?= $product->demand->demand_code ?></th>
                        <th><?= $product->validatedListItem->product_name ?></th>
                        <th><?= $product->quantity ?></th>
                        <th><?= $product->price ?></th>
                        <th><?= Yii::$app->formatter->asCurrency($product->quantity * $product->price) ?></th>
                        <th>
                            <?= Yii::$app->user->can('buyrequest/removeitem') ? \yii\helpers\Html::a(
                                '<span class="fa fa-trash">',
                                ['/buy-request/remove-item', 'item' => $product->id],
                                [
                                    'title' => 'Eliminar item de la solicitud.',
                                    'data-confirm' => '¿Está seguro que desea quitar este producto de la orden de compra?'
                                ]
                            ) : null ?>
                        </th>
                    </tr>
                    <?php
                }
                ?>
                </tbody>
            </table>
        </div>
        <?php
    } else {
        ?>
        <?= Html::input('hidden', null, json_encode(\app\models\BuyRequest::comboAvailableBuyRequest(\app\models\BuyRequestType::$TYPE_711)), ['id' => 'br711']) ?>
        <div class="col-sm-12">
            <div style="text-align: right">
                <?php
                if ($model->buyRequest711&&count($model->getProducts())>1){
                ?>
            <div class="btn-group right <?= Yii::$app->user->can('buyrequest711/separate') ? '' : 'hidden' ?>" role="group">
                <button type="button" onclick='createAnother(1,<?=$model->id?>)'
                        class="btn btn-primary dropdown-importaciones clasify" disabled
                        title="Crear una nueva orden de compra 711 con los productos seleccionados."><span
                            class="fa fa-plus"></span><b> 711</b></button>
                <div class="btn-group" role="group">
                    <button id="btnGroupDrop2" type="button"
                            class="btn btn-primary dropdown-toggle dropdown-importaciones clasify" disabled
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    </button>
                    <div class="dropdown-menu moveToLeft" aria-labelledby="btnGroupDrop2">
                        <a class="dropdown-item" onclick='createAnother(2,<?=$model->id?>)' style="cursor: pointer">Añadir a
                            un 711 existente</a>
                    </div>
                </div>
            </div>

            <?php
            } ?>
            </div>

            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <?php
                    if ($model->buyRequest711&&count($model->getProducts())>1) {
                        ?>
                        <th></th>
                        <?php
                    } ?>
                    <th>Modelo y/o Número de parte del producto</th>
                    <th>Cantidad</th>
                    <th>Precio (UV)</th>
                    <th>Importe</th>


                </tr>
                </thead>
                <tbody>
                <?php
                foreach ($model->getProducts() as $product) {
                    ?>
                    <tr>
                        <?php
                        if ($model->buyRequest711&&count($model->getProducts())>1) {
                            ?>
                            <th><?= \yii\helpers\Html::checkbox($product->id, false, ['class' => 'check_item','value'=>$product->id]) ?></th>
                            <?php
                        } ?>
                        <th><?= $product->product_name ?></th>
                        <th><?= $product->quantity ?></th>
                        <th><?= $product->price ?></th>
                        <th><?= Yii::$app->formatter->asCurrency($product->quantity * $product->price) ?></th>


                    </tr>
                    <?php
                }
                ?>
                </tbody>
            </table>
        </div>
        <?php
    }
    ?>

</div>
