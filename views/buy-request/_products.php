<?php



/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */
?>
<div class="row p-5">
    <?php
    if($model->buy_request_status_id==\app\models\BuyRequestStatus::$BORRADOR_ID){
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
                foreach ($model->demandItems as $product){
                    ?>
                    <tr>
                        <th><?=$product->demand->demand_code?></th>
                        <th><?=$product->validatedListItem->product_name?></th>
                        <th><?=$product->quantity?></th>
                        <th><?=$product->price?></th>
                        <th><?=Yii::$app->formatter->asCurrency($product->quantity*$product->price)?></th>
                        <th>
                            <?=Yii::$app->user->can('buyrequest/removeitem')?\yii\helpers\Html::a(
                                '<span class="fa fa-trash">',
                                ['/buy-request/remove-item','item'=>$product->id],
                                [
                                    'title'=>'Eliminar item de la solicitud.',
                                    'data-confirm'=>'¿Está seguro que desea quitar este producto de la demanda?'
                                ]
                            ):null?>
                        </th>
                    </tr>
                    <?php
                }
                ?>
                </tbody>
            </table>
        </div>
        <?php
    }else{
        ?>
        <div class="col-sm-12">

            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Modelo y/o Número de parte del producto</th>
                    <th>Cantidad</th>
                    <th>Precio (UV)</th>
                    <th>Importe</th>


                </tr>
                </thead>
                <tbody>
                <?php
                foreach ($model->getProducts() as $product){
                    ?>
                    <tr>
                        <th><?=$product->product_name?></th>
                        <th><?=$product->quantity?></th>
                        <th><?=$product->price?></th>
                        <th><?=Yii::$app->formatter->asCurrency($product->quantity*$product->price)?></th>


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
