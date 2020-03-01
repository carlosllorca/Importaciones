<?php
/**
 * @var $model BuyRequest
 * @var  $this \yii\web\View
 *
 */

use app\models\BuyRequest;
use app\models\Provider;
use yii\widgets\ActiveForm;
use yii\helpers\Html;
?>



<div class="row" style="text-align: center">
    <div class="col-sm-2"></div>


    <div class="col-sm-4" style="text-align: center; padding: 0px 12px;border: 1px solid #cecece;border-right: 0px">
        <?= $form->field($model, 'bidding_start')->textInput(['type'=>'date','style'=>['text-align'=>'center']])?>

    </div>
    <div class="col-sm-4" style="text-align: center; padding: 0px 12px;border: 1px solid #cecece;border-left: 0px">
        <?= $form->field($model, 'bidding_end')->textInput(['type'=>'date','style'=>['text-align'=>'center']])?>
    </div>


</div>
<div class="row">
    <div class="col-sm-4">
        <?= $form->field($model, 'destiny_id')->widget(\kartik\select2\Select2::className(),
            [
                    'data' => \app\models\Destiny::combo()
            ])?>
    </div>
    <div class="col-sm-4">
        <?= $form->field($model, 'payment_instrument_id')->widget(\kartik\select2\Select2::className(),
            [
                'data' => \app\models\PaymentInstrument::combo(),

            ])?>
    </div>
    <div class="col-sm-4">
        <?= $form->field($model, 'buy_condition_id')->widget(\kartik\select2\Select2::className(),
            [
                'data' => \app\models\BuyCondition::combo(),
                'options' => [
                        'placeholder'=>'Seleccione...'
                ]
            ])?>
    </div>

</div>
<div class="row">
    <div class="col-sm-12" style="padding: 20px;" >
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>Proveedor</th>
                <th>País</th>


            </tr>
            </thead>
            <tbody>
            <?php
            foreach (Provider::related($model->arrayValidatedList()) as $provider){
               ?>
                <tr>

                    <th><?=$provider->name?></th>
                    <th><?=$provider->country->label?></th>
                </tr>
                <?php
            }

            ?>
            </tbody>
        </table>
    </div>
</div>
<div class="button-container" style="text-align: right">
    <?=Html::button('Cancelar',['class'=>"btn btn-default",'onclick'=>'cancelarLicitacion()'])?>
    <?=Html::submitButton("<i class='center_fa fa fa-envelope-open-o'></i>  Iniciar licitación",[
        'class'=>"btn btn-warning",
        'data-confirm'=>'Al iniciar la licitación se les enviará a cada proveedor de la lista una solicitud de oferta. ¿Está seguro que desea iniciar el proceso?'
    ])?>
</div>
<?php
$this->registerJsFile('/js/buy-request/_licitacion.js',['depends'=>\yii\web\JqueryAsset::className()]);
?>
                                                                                                                                        