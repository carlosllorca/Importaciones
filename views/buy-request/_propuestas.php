<?php



/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */
?>
<div class="row">
<?php
    if($model->buy_request_status_id==\app\models\BuyRequestStatus::$BORRADOR_ID){
        ?>
        <div class="col-xs-12">
            <p style="text-align: center;margin-top: 10%; font-size: 20px;color: #cecece">
                La solicitud de compra debe ser aprobada para ver esta sección.
            </p>
        </div>
        <?php
    }
?>
</div>
