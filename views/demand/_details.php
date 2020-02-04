<?php



/* @var $this \yii\web\View */
/* @var $model \app\models\Demand|\yii\db\ActiveRecord */
?>
<div class="row p-5">
    <div class="col-sm-6">
        <label>
            Requiere quit de piezas de respuesto:
        </label>
        <h5><?=$model->txtSellerRequirementPart()?></h5>
    </div>
    <div class="col-sm-6">
        <label>
            Requiere servico de postventa o garantía:
        </label>
        <h5><?=$model->txtPostWarrantyService()?></h5>
    </div>
    <div class="col-sm-6">
        <label>
            Detalles y alcance de la asistencia técnica:
        </label>
        <h5><?=$model->txtRequireTechnicAsistence()?></h5>
    </div>
    <div class="col-sm-6">
        <label>
            Se requiere por parte del proveedor:
        </label>
        <h5><?=$model->sellerRequirement->label?></h5>
    </div>
    <div class="col-sm-6">
        <label>
            Alcance requerido:
        </label>
        <h5><?=$model-> post_warranty_details?$model->post_warranty_details:'-'?></h5>
    </div>
    <div class="col-sm-12">
        <label>
            Observaciones:
        </label>
        <h5><?=$model-> observation?$model->observation:'-'?></h5>
    </div>
    <div class="col-sm-6"></div>
</div>
