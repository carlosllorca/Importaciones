<?php

use yii\bootstrap4\Modal;
use yii\helpers\Html;


/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */

Modal::begin([
    // 'header' => '<h2>Hello world</h2>',
    'toggleButton' => ['label' => 'click me', 'id' => 'ajax-modal', 'class' => 'hidden'],
]);

echo '<div id="modal-content"></div>';

Modal::end();
?>

    <div class="row">
        <div class="col-sm-12" style="width: 100%;padding: 15px 40px">
            <div class="button-container" style="text-align: right;padding: 15px">
                <?php
                    if($model->buy_request_status_id==\app\models\BuyRequestStatus::$LICITANDO&&Yii::$app->user->can('buyrequest/generatenacionaloffert')){
                        echo \yii\helpers\Html::button('Nueva propuesta', [
                            'class' => 'btn btn-primary ',
                            'onclick' => "renderAjaxForm('Nueva propuesta','/buy-request/generate-nacional-offert?id=" . $model->id . "')"
                        ]);
                    }
                ?>

                <?php
                    if(Yii::$app->user->can('buyrequest/closebidding')&&$model->buy_request_status_id==\app\models\BuyRequestStatus::$LICITANDO&&$model->getFinalistas()){
                        echo \yii\helpers\Html::button('Cerrar licitación', [
                            'class' => 'btn btn-primary',
                            'onclick' => "renderAjaxForm('Cerrar licitación','/buy-request/close-bidding?id=" . $model->id . "')"
                        ]);
                    }

                ?>


            </div>
            <?php
            if ($model->buyRequestProviders) {
                ?>

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
                            foreach ($model->buyRequestProviders as $buyRequestProvider) {
                                ?>
                                <tr>
                                    <th><?= $buyRequestProvider->provider->name ?></th>
                                    <th><?= $buyRequestProvider->provider->country->label ?></th>
                                    <th><?= $buyRequestProvider->providerStatus->label ?></th>
                                    <th>
                                        <?= Html::a("<span class='fa fa-eye'></span>",
                                            '#', ['title' => 'Ver', 'onclick' => 'showProvider(' . $buyRequestProvider->id . ')']
                                        ) ?>

                                    </th>
                                </tr>
                                <?php
                            }

                            ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-sm-12 hidden" style="padding: 15px" id="view-content">


                    </div>
                </div>
                <?php
            } else {
                ?>
                <div class="col-sm-12" style="width: 100%; padding: 15%;50px; text-align: center">
                    <p>No hay propuestas registradas.</p>
                </div>
                <?php
            }
            ?>
        </div>
    </div>
<?php
$this->registerJsFile('/js/buy-request/_propuestas.js', ['depends' => \yii\web\JqueryAsset::className()])

?>