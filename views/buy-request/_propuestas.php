<?php


/* @var $this \yii\web\View */

/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */

use yii\widgets\ActiveForm;

?>

    <div class="row">
        <div class="col-md-12">
            <div class="<?=$model->bidding_start&&!$model->buyRequestProviders?'':'hidden'?>" id="licitacion_form">
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
            if (!$model->buyRequestProviders) {
                ?>
                <div class="col-xs-12 <?=$model->bidding_start?'hidden':''?>" id="no-data">
                    <p class="" style="text-align: center;margin-top: 10%; font-size: 20px;color: #cecece">
                        El proceso de licitación para esta orden de compra aún no se ha iniciado.
                        <a class="link" href="#" onclick="showForm()"><b>¿Desea iniciarlo?</b></a>
                    </p>
                </div>
                <?php
            }else{
                ?>
                <div class="col-xs-12 p-5">
                    <div class="row"  >
                        <div class="col-sm-3">
                            <label style="color: #0e0e0e">Período de licitación desde:</label>
                            <p style="font-weight: bold"><?=Yii::$app->formatter->asDate($model->bidding_start)?></p>

                        </div>
                        <div class="col-sm-3">
                            <label style="color: #0e0e0e">Período de licitación hasta:</label>
                            <p style="font-weight: bold"><?=Yii::$app->formatter->asDate($model->bidding_end)?></p>

                        </div>
                        <div class="col-sm-3">
                            <label style="color: #0e0e0e">Estado:</label>
                            <p class="<?=$model->biddingActive()?'text-success':'text-danger'?>" style="font-weight: bold"><?=$model->biddingActive()?'ACTIVO':'NO ACTIVO'?></p>

                        </div>
                        <div class="col-sm-3">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12" id="table-providers">
                            <table class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th>Nombre del proveedor</th>
                                    <th>País</th>
                                    <th>Estado</th>
                                    <th></th>


                                </tr>
                                </thead>
                                <tbody>
                                <?php
                                foreach ($model->buyRequestProviders as $buyRequestProvider){
                                    ?>
                                    <tr>
                                        <th><?=$buyRequestProvider->provider->name?></th>
                                        <th><?=$buyRequestProvider->provider->country->label?></th>
                                        <th><?=$buyRequestProvider->providerStatus->label?></th>
                                        <th>
                                            <?=\yii\helpers\Html::a("<span class='glyphicon glyphicon-eye-open'></span>",
                                            '#',['title'=>'Ver','onclick'=>'showProvider('.$buyRequestProvider->id.')']
                                            )?>

                                        </th>
                                    </tr>
                                    <?php
                                }

                                ?>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-sm-12 hidden" style="padding: 15px" id= "view-content">


                        </div>
                    </div>
                </div>

                <?php
            }
        }
        ?>
    </div>
<?php
$this->registerJsFile('js/buy-request/_propuestas.js', ['depends' => \yii\web\JqueryAsset::className()])
?>