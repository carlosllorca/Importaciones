<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\BuyRequest711 */

\yii\web\YiiAsset::register($this);
?>
<div class="buy-request711-view" style="padding: 20px">



    <p style="text-align: right">
        <?=Yii::$app->user->can('buyrequest711/update')? Html::button('<span class="fa fa-pencil"/>',
            [
                'class' => 'btn btn-primary',
                'title'=>'Modificar datos del 711',
                'onclick'=>'update711('.$model->id.')'
            ]):null ?>

    </p>
    <div class="row" style="border:1px solid #cecece;margin:0px 20px" >
        <div class="col-sm-3" style="border:1px solid #cecece;">
            <label>Plan asociado</label>
            <p><?=$model->plan?></p>
        </div>
        <div class="col-sm-6" style="border:1px solid #cecece;" >
            <label>Destino final</label>
            <p><?=$model->finalDestiny->label?></p>
        </div>
        <div class="col-sm-3" style="border:1px solid #cecece;" >
            <label>Otros gastos de operaciones y margen comercial</label>
            <p><?=Yii::$app->formatter->asCurrency($model->other_operation)?></p>
        </div>
        <div class="col-sm-6" style="border:1px solid #cecece;">
            <label>Descripción general</label>
            <p><?=$model->general_description?></p>
        </div>
        <div class="col-sm-6" style="border:1px solid #cecece;" >
            <label>Lugar de entrega de la mercancía </label>
            <p><?=$model->deployment_place?></p>
        </div>
    </div>


</div>
<?=$this->registerJsFile('@web/js/buyrequest711/view.js',['depends'=>\yii\web\JqueryAsset::className()])?>