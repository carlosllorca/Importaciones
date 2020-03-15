<?php

use app\models\DemandItem;
use yii\bootstrap4\Html;
use yii\grid\GridView;
use yii\web\JqueryAsset;

/* @var $this \yii\web\View */
/* @var $model \app\models\Demand|\yii\db\ActiveRecord */
/* @var $searchModel app\models\DemandItemSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

?>

<div class="row p-5">
    <div class="col-12 ">
        <div style="text-align: right" class="disabled">


            <?= Html::input('hidden', null, json_encode(\app\models\BuyRequest::comboAvailableBuyRequest(\app\models\BuyRequestType::$INTERNACIIONAL_ID)), ['id' => 'si']) ?>
            <?= Html::input('hidden', null, json_encode(\app\models\BuyRequest::comboAvailableBuyRequest(\app\models\BuyRequestType::$NACIONAL_ID)), ['id' => 'sn']) ?>


            <?= Yii::$app->user->can('demand/clasify') ? Html::button('<b>Distribución interna</b>', ['class' => 'btn btn-primary clasify', 'onclick' => 'clasify(1,' . $model->id . ')', 'style' => ['margin-left' => '5px'], 'disabled' => true, 'title' => 'Trasladar los productos seleccionados desde otra UEB.']) : null ?>
            <div class="btn-group <?= Yii::$app->user->can('demand/clasify') ? '' : 'hidden' ?>" role="group">
                <button type="button" onclick='clasify(2,<?= $model->id ?>)'
                        class="btn btn-primary dropdown-importaciones clasify"
                        title="Crear una solicitud de compra nacional con los productos seleccionados." disabled><span
                            class="glyphicon glyphicon-plus"></span> <b> Solicitud Nacional</b></button>
                <div class="btn-group " role="group">
                    <button id="btnGroupDrop1" type="button"
                            class="btn btn-primary dropdown-toggle dropdown-importaciones clasify"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" disabled=true>
                    </button>
                    <div class="dropdown-menu moveToLeft" aria-labelledby="btnGroupDrop1">
                        <a class="dropdown-item" onclick='clasify(3,<?= $model->id ?>)' style="cursor: pointer">Añadir a
                            una solicitud existente</a>
                    </div>
                </div>
            </div>
            <div class="btn-group right <?= Yii::$app->user->can('demand/clasify') ? '' : 'hidden' ?>" role="group">
                <button type="button" onclick='clasify(4,<?= $model->id ?>)'
                        class="btn btn-primary dropdown-importaciones clasify" disabled
                        title="Crear una solicitud de compra internacional con los productos seleccionados."><span
                            class="glyphicon glyphicon-plus"></span><b> Solicitud internacional</b></button>
                <div class="btn-group" role="group">
                    <button id="btnGroupDrop2" type="button"
                            class="btn btn-primary dropdown-toggle dropdown-importaciones clasify" disabled
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    </button>
                    <div class="dropdown-menu moveToLeft" aria-labelledby="btnGroupDrop2">
                        <a class="dropdown-item" onclick='clasify(5,<?= $model->id ?>)' style="cursor: pointer">Añadir a
                            una solicitud existente</a>
                    </div>
                </div>
            </div>

        </div>


            <?= GridView::widget([
                'dataProvider' => $dataProvider,
                'rowOptions'=>function($model,$key){
                    /**
                     * @var $model \app\models\DemandItem
                     */
                    if($model->cancelled){
                        return ['class'=>'gray'];
                    }

                },

                'columns' => [
                    ['class' => 'yii\grid\SerialColumn'],
                    [
                        'class' => 'yii\grid\CheckboxColumn',
                        'checkboxOptions' => function ($model, $key, $index, $column) {
                            /**
                             * @var $model DemandItem
                             */


                            if ($model->status() == 'Sin clasificar'&&$model->demand->demand_status_id!=\app\models\DemandStatus::RECHAZADA_ID) {
                                return ['class' => 'check_item'];
                            } else {
                                return ['class' => 'hidden'];
                            }

                        },
                        'content' => function ($model, $key, $index, $column) {
                            $myClass = $model->status() == 'Sin clasificar'&&$model->demand->demand_status_id!=\app\models\DemandStatus::RECHAZADA_ID
                                ? "check_item" : "hidden";
                            return "<div class=\"checkbox {$myClass}\"> <label><input type=\"checkbox\" value='{$key}' class='{$myClass}' name=\"optionsCheckboxes\"></label></div>";
                        }
                    ],


                    [
                        'attribute' => 'validated_list_item_id',
                        'value' => 'validatedListItem.product_name',
                        'filter' => \app\models\ValidatedListItem::comboDemand($model->id)
                    ],

                    'price:currency',
                    'quantity',
                    [
                        'attribute' => 'status',
                        'label' => 'Destino',
                        'format' => 'raw',
                        'value' => function ($model) {
                            /**
                             * @var $model DemandItem
                             */
                            return $model->status(true);

                        }
                    ],
                    $model->demand_status_id==\app\models\DemandStatus::RECHAZADA_ID?['value'=>function(){return 'Demanda rechazada';}]:
                    [
                        'class' => 'yii\grid\ActionColumn',
                        'template' => '{divide} {cancel-item}',
                        'buttons' => [
                            'divide' => function ($url, $model) {
                                /**
                                 * @var $model DemandItem
                                 */
                                return $model->status() == 'Sin clasificar' ? Html::a('<span class="glyphicon glyphicon-duplicate"></span>', '#',
                                    [
                                        'title' => 'Dividir. Al dividir puedes enviar un mismo producto a dos destinos diferentes.',
                                        'onclick' => 'divide(' . $model->id . ',' . $model->quantity . ')'
                                    ]) : null;
                            },
                            'cancel-item' => function ($url, $model) {
                                /**
                                 * @var $model DemandItem
                                 */
                                return $model->status() == 'Sin clasificar' ? Html::a('<span class="glyphicon glyphicon-remove"></span>', '#',
                                    [
                                        'title' => 'Cancelar un producto.',
                                        'onclick' => 'cancel_item(' . $model->id . ')'
                                    ]) : null;
                            }
                        ],
                        'visibleButtons' => [
                            'divide' => function () {
                                return Yii::$app->user->can('demand/divide');
                            },
                            'cancel-item' => function () {
                                return Yii::$app->user->can('demand/cancelitem');
                            }
                        ]

                    ],

                    //'buy_request_id',


                ],
            ]); ?>


    </div>


</div>
<?php
$this->registerJsFile('@web/js/openModal.js', ['depends' => JqueryAsset::className()])
?>

