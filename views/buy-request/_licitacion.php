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


    <div class="col-sm-4" style="text-align: center; padding: 0px 12px;margin: auto">
        <?= $form->field($model, 'bidding_start')->textInput(['type'=>'date','style'=>['text-align'=>'center']])?>

    </div>
    <div class="col-sm-4" style="text-align: center; padding: 0px 12px;margin: auto">
        <?= $form->field($model, 'bidding_end')->textInput(['type'=>'date','style'=>['text-align'=>'center']])?>
    </div>


</div>
<div class="row">
    <div class="col-sm-12">
        <div class="col-sm-12">
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th style="width: 50px"><input type="checkbox" class="check-all"></th>
                    <th>Proveedor</th>
                    <th>País</th>


                </tr>
                </thead>
                <tbody>
                <?php
                foreach (Provider::related($model->arrayValidatedList()) as $provider){
                   ?>
                    <tr>
                        <th class="check-item"><input type="checkbox"></th>
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
<?php
$this->registerJsFile('/js/buy-request/_licitacion.js',['depends'=>\yii\web\JqueryAsset::className()]);
?>
                                                                                                                                        