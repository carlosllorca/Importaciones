<?php



/* @var $this \yii\web\View */
/* @var $model \app\models\Demand|\yii\db\ActiveRecord */
?>
<div class="row p-5">
    <div class="col-sm-6">
        <label>
            A ejecutar con:
        </label>
        <h5><?=$model->txtPaymentMethod()?></h5>
    </div>
    <div class="col-sm-6">
        <label>
            Las entregas se necesitan en:
        </label>
        <h5><?=$model->txtDeploymentPart()?></h5>
    </div>
    <div class="col-sm-6">
        <label>
            Especificaciones de la garantía:
        </label>
        <h5><?=$model->warrantySpecification()?></h5>
    </div>
    <div class="col-sm-6">
        <label>
            Tiempo de la garantía:
        </label>
        <h5><?=$model->txtWarrantyTime()?></h5>
    </div>
    <div class="col-sm-6">
        <label>
            Motivo de la compra:
        </label>
        <h5><?=$model->purchaseReason->label?></h5>
    </div>
    <div class="col-sm-6"></div>
</div>
