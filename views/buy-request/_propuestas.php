<?php


/* @var $this \yii\web\View */

/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */

use yii\widgets\ActiveForm;

?>

    <div class="row">
        <div class="col-md-12">
            <div class="hidden" id="licitacion_form">
                <?php $form = ActiveForm::begin(); ?>
                <div class="row" style="margin: auto;padding-top: 2%;padding-bottom: 2%">
                    <div class="col-sm-12 col-md-8"
                         style="background-color: white; border: 1px solid #cecece;margin: auto;padding: 25px">
                        <h4 class="title" style="text-align: center; margin: auto">Iniciar proceso de licitación</h4>
                        <?= $this->render('_licitacion', ['model' => $model, 'form' => $form]) ?>
                    </div>
                </div>
                <?php ActiveForm::end(); ?>
            </div>


        </div>
        <?php
        if ($model->buy_request_status_id == \app\models\BuyRequestStatus::$BORRADOR_ID) {
            ?>
            <div class="col-xs-12">
                <p style="text-align: center;margin-top: 10%; font-size: 20px;color: #cecece">
                    La solicitud de compra debe ser aprobada para ver esta sección.
                </p>
            </div>
            <?php
        } else {
            if ($model->bidding_start == null) {
                ?>
                <div class="col-xs-12" id="no-data">
                    <p style="text-align: center;margin-top: 10%; font-size: 20px;color: #cecece">
                        El proceso de licitación para esta orden de compra aún no se ha iniciado.
                        <a class="link" href="#" onclick="showForm()"><b>¿Desea iniciarlo?</b></a>
                    </p>
                </div>
                <?php
            }
        }
        ?>
    </div>
<?php
$this->registerJsFile('js/buy-request/_propuestas.js', ['depends' => \yii\web\JqueryAsset::className()])
?>