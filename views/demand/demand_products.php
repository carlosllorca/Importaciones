<?php

use yii\bootstrap4\Modal;

/* @var $this \yii\web\View */
/* @var $model \app\models\Demand */
/* @var $masDemandados Array */

$this->title = 'Añadir productos';

?>
    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?= $this->title ?></h4>

        </div>
        <div class="card-body" style="padding: 15px">
            <div class="p-3">
                <div class="row">
                    <div class="col-sm-6">
                        <p style="margin: 0px">
                            <span class="text-uppercase">Productos:<b id="totalProducts"
                                                                      style="margin-left: 5px; margin-right: 10px"><?= count($model->demandItems) ?></b></span>
                            <span class="text-uppercase">Importe total:<b id="totalImport"
                                                                          style="margin-left: 5px"><?= Yii::$app->formatter->asCurrency($model->totalAmount()) ?></b></span>

                        </p>
                    </div>
                    <div class="col-sm-6">
                        <p style="text-align: right;margin: 0px">

                            <?= \yii\helpers\Html::a('<i class="fa fa-send"></i> Enviar demanda', ['send', 'id' => $model->id],
                                [
                                    'class' => 'btn btn-primary',
                                    'title' => 'Enviar demanda',

                                    'data-confirm' => '¿Confirma que desea enviar la demanda?'
                                ]) ?>


                        </p>

                    </div>
                </div>


                <div class="row">
                    <div class="col-sm-9">
                        <table class="table table-sm">
                            <thead class=" text-primary">
                            <tr>
                                <th> No.</th>
                                <th>Producto</th>

                                <th>UM</th>

                                <th>Precio</th>
                                <th>Cantidad</th>
                                <th>Importe</th>

                            </tr>
                            </thead>
                            <tbody>
                            <?php
                            $pos = 0;
                            foreach (\app\models\ValidatedListItem::validatedListItems($model->validated_list_id) as $validatedListItem) {
                                $pos++;
                                if (isset($arrayItems[$validatedListItem->id])) {
                                    $quantity = $arrayItems[$validatedListItem->id]['cantidad'];
                                    $import = $arrayItems[$validatedListItem->id]['importe'];
                                } else {
                                    $quantity = 0;
                                    $import = Yii::$app->formatter->asCurrency(0);
                                }
                                ?>
                                <tr class="<?= $quantity ? 'alert-success' : '' ?>">
                                    <th> <?= $pos++ ?></th>
                                    <td onclick="showItemDetails(<?= $validatedListItem->id ?>)"
                                        title="<?= $validatedListItem->tecnic_description ?>" style="cursor: pointer">
                                        <?= $validatedListItem->product_name ?>
                                    </td>

                                    <td><?= $validatedListItem->um->label ?></td>

                                    <td><?= Yii::$app->formatter->asCurrency($validatedListItem->price) ?></td>
                                    <td>
                                        <input value="<?= $quantity ?>" demand="<?= $model->id ?>"
                                               product="<?= $validatedListItem->id ?>" type="number"
                                               style="max-width: 70px" class="quantity"></td>
                                    <td class="import"><?= $import ?></td>

                                </tr>
                                <?php

                            } ?>


                            </tbody>
                        </table>
                    </div>
                    <div class="col-sm-3">
                        <div style="background-color: #fefefe;min-height: 300px;
                        border-radius: 5px;
                            border:1px solid #cecece;
                            width: 100%;
                         margin-top: 50px">
                            <p style="text-align: center; font-style: italic; margin-top: 10px;">PRODUCTOS MÁS DEMANDADOS</p>
                            <ul>
                                <?php
                                foreach ($masDemandados as $masDemandado){
                                    ?>
                                    <li onclick="showItemDetails(<?= $masDemandado['id'] ?>)"style="font-size: 18px; cursor: pointer"><?=$masDemandado['product_name']?></li>
                                    <?php
                                }
                                ?>
                            </ul>

                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
<?php
$this->registerJsFile('@web/js/demand/createDemand.js', ['depends' => \yii\web\JqueryAsset::className()])
?>