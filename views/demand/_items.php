<?php

use app\models\DemandItem;
use yii\grid\GridView;
use yii\widgets\Pjax;

/* @var $this \yii\web\View */
/* @var $model \app\models\Demand|\yii\db\ActiveRecord */
/* @var $searchModel app\models\DemandItemSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */
?>

<div class="row p-5">
    <div class="col-12">
        <div style="text-align: right">

            <?=\yii\bootstrap4\Html::button('<b>Distribución interna</b>',['class'=>'btn btn-primary clasify','onclick'=>'clasify(1)','style'=>['margin-left'=>'5px'],'disabled'=>true,'title'=>'Trasladar los productos seleccionados desde otra UEB.'])?>
            <div class="btn-group " role="group">
                <button type="button" class="btn btn-primary dropdown-importaciones clasify" title="Crear una solicitud de compra nacional con los productos seleccionados." disabled><span class="glyphicon glyphicon-plus"></span> <b> Solicitud Nacional</b></button>
                <div class="btn-group " role="group" >
                    <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle dropdown-importaciones clasify"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" disabled=true>
                    </button>
                    <div class="dropdown-menu moveToLeft" aria-labelledby="btnGroupDrop1">
                        <a class="dropdown-item" href="#">Añadir a una solicitud existente</a>
                    </div>
                </div>
            </div>
            <div class="btn-group right" role="group">
                <button type="button" class="btn btn-primary dropdown-importaciones clasify" disabled title="Crear una solicitud de compra internacional con los productos seleccionados."><span class="glyphicon glyphicon-plus"></span><b> Solicitud internacional</b></button>
                <div class="btn-group" role="group">
                    <button id="btnGroupDrop2" type="button" class="btn btn-primary dropdown-toggle dropdown-importaciones clasify" disabled  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    </button>
                    <div class="dropdown-menu moveToLeft" aria-labelledby="btnGroupDrop2">
                        <a class="dropdown-item" href="#">Añadir a una solicitud existente</a>
                    </div>
                </div>
            </div>

        </div>





        <?= GridView::widget([
            'dataProvider' => $dataProvider,

            'columns' => [
                ['class' => 'yii\grid\SerialColumn'],
                [
                    'class' => 'yii\grid\CheckboxColumn',
                    'checkboxOptions' => function ($model, $key, $index, $column) {
                        /**
                         * @var $model DemandItem
                         */


                        if (!$model->buy_request_id!=null ) {
                            return ['class' => 'hidden'];
                        } else {
                            return ['class' => 'check_item'];
                        }

                    },
                    'content' => function ($model, $key, $index, $column) {
                        $myClass = $model->buy_request_id!=null||$model->internal_distribution==true
                            ? "hidden" : "check_item";
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
                        'value'=>function($model){
                            /**
                             * @var $model DemandItem
                             */
                            return $model->status(true);

                        }
                ]
                //'buy_request_id',


            ],
        ]); ?>
    </div>


</div>

<?php
echo $this->registerJsFile('/js/demand/items.js',['depends'=>\yii\web\JqueryAsset::className()])
?>