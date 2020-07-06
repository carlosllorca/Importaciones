<?php
/**
 * @var $model BuyRequest
 * @var $fLicitacion \app\models\BuyRequestInternational
 * @var  $this \yii\web\View
 *
 */

use app\models\BuyRequest;
use app\models\Provider;
use yii\widgets\ActiveForm;
use yii\helpers\Html;
use yii\jui\DatePicker;
?>


<div class="row" style="text-align: center">

    <div class="col-sm-2"></div>


    <div class="col-sm-4" style="text-align: center; padding: 0px 12px;">
        <?= $form->field($fLicitacion, 'bidding_start')->widget(DatePicker::classname(), [
            'dateFormat' => 'dd/MM/yyyy',
            'clientOptions'=>[
                    'readOnly'=>true,
                'disabled'=>true
            ],
            'options'=>['class'=>'form-control']
        ]); ?>


    </div>
    <div class="col-sm-4" style="text-align: center; padding: 0px 12px;">
        <?= $form->field($fLicitacion, 'bidding_end')->widget(DatePicker::classname(), [
            'dateFormat' => 'dd-MM-yyyy',

            'options'=>['class'=>'form-control']
        ]); ?>
    </div>


</div>
<div class="row">
    <div class="col-sm-4">
        <?= $form->field($fLicitacion, 'destiny_id')->widget(\kartik\select2\Select2::className(),
            [

                'data' => \app\models\Destiny::combo()
            ]) ?>
    </div>
    <div class="col-sm-4">
        <?= $form->field($fLicitacion, 'payment_instrument_id')->widget(\kartik\select2\Select2::className(),
            [
                'data' => \app\models\PaymentInstrument::combo(),


            ]) ?>
    </div>
    <div class="col-sm-4">
        <?= $form->field($fLicitacion, 'buy_condition_id')->widget(\kartik\select2\Select2::className(),
            [
                'data' => \app\models\BuyCondition::combo(),

                'options' => [
                    'placeholder' => 'Seleccione...'
                ]
            ]) ?>
    </div>
    <?= $form->field($fLicitacion, 'proveedores')->dropDownList(Provider::related($model->arrayValidatedList(), \app\models\BuyRequestType::$INTERNACIIONAL_ID,true) ,['multiple'=>true,'id'=>'proveedores','class'=>''])->label(false)?>
</div>
<div class="row">
    <div class="col-sm-12" style="padding: 20px;">
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th style="width: 50px"></th>
                <th>Proveedor</th>
                <th>País</th>


            </tr>
            </thead>
            <tbody>
            <?php
            foreach (Provider::related($model->arrayValidatedList(), \app\models\BuyRequestType::$INTERNACIIONAL_ID) as $provider) {
                ?>
                <tr>
                    <th style="width: 50px"><?=Html::checkbox($provider->id,in_array($provider->id,$fLicitacion->proveedores),['class'=>'provider_item','checked','provider'=>$provider->id])?></th>

                    <th><?= $provider->name ?></th>
                    <th><?= $provider->country->label ?></th>
                </tr>
                <?php
            }

            ?>
            </tbody>
        </table>
    </div>
</div>
<div class="row">
    <div class="col-sm-12">
        <?= $form->field($fLicitacion, 'message')->textarea() ?>
    </div>
</div>
<div class="button-container" style="text-align: right">
    <?= Html::button('Cancelar', ['class' => "btn btn-default", 'onclick' => 'cancelarLicitacion()']) ?>
    <?= Html::submitButton("<i class='center_fa fa fa-envelope-open-o'></i>  Iniciar licitación", [
        'class' => "btn btn-warning",
        'data-confirm' => 'Al iniciar la licitación se les enviará a cada proveedor de la lista una solicitud de oferta. ¿Está seguro que desea iniciar el proceso?'
    ]) ?>
</div>
<?php

?>
                                                                                                                                        