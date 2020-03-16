<?php

use yii\bootstrap\Modal;

/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */
$this->registerCssFile('/css/timeline.css');
Modal::begin([
    // 'header' => '<h2>Hello world</h2>',
    'toggleButton' => ['label' => 'click me','id'=>'ajax-modal-hitos','class'=>'hidden'],
]);

echo '<div id="modal-content-hitos"></div>';

Modal::end();

?>

<div class="row">

    <div class="col-xs-12 contenedor_hitos">
        <ul id='timeline'>
            <?php
            $current= $model->currentStage();

                foreach ($model->requestStageOrdenados() as $requestStage){
                    ?>

                    <li class='work'>
                        <input class='radio' id='work<?=$requestStage->id?>' name='works' type='radio' <?=$current->id==$requestStage->id?'checked' : null?> >
                        <div class="relative">
                            <label class="label_1" for='work<?=$requestStage->id?>'><?=$requestStage->stage->label?></label>
                            <span class='date <?=$requestStage->real_end?'text-success':null?>'><?=Yii::$app->formatter->asDate($requestStage->date_start)?><br>al<br><?=Yii::$app->formatter->asDate($requestStage->date_end)?></span>
                            <span class='circle'></span>
                        </div>
                        <div class='content'>
                            <div class="row contentData">
                                <div class="col sm-4 col-md-3">

                                    <i>Inicio:</i><br>
                                    <b><?=Yii::$app->formatter->asDate($requestStage->date_start)?></b>
                                </div>
                                <div class="col sm-4 col-md-3">
                                    <i>Fin(Esperado):</i><br>
                                    <b><?=Yii::$app->formatter->asDate($requestStage->date_end)?></b>
                                </div>
                                <div class="col sm-4 col-md-3">
                                    <i>Fin(Real):</i><br>
                                    <b><?=$requestStage->real_end?Yii::$app->formatter->asDate($requestStage->real_end):'-'?></b>
                                </div>
                                <div class="col-sm-12">
                                    <i>Observaciones:</i><br>
                                    <p><?=$requestStage->details?$requestStage->details:'-'?></p>
                                </div>
                                <div class="col-sm-12">
                                    <div class="button-container" style="text-align: right">
                                        <?=Yii::$app->user->can('buyrequest/stagesuccess')&&$current->id==$requestStage->id&&!$requestStage->real_end?\yii\helpers\Html::button("<i class='glyphicon glyphicon-ok'></i>",
                                            ['title'=>'Marcar como hito realizado','onclick'=> 'closeHito('.$requestStage->id.' )','class'=>"btn btn-success btn-xs"]):null?>
                                        <?=Yii::$app->user->can('buyrequest/updatestage')&&!$requestStage->real_end?\yii\helpers\Html::button("<i class='glyphicon glyphicon-pencil'></i>",
                                            ['title'=>'Modificar hito','onclick'=> 'updateHito('.$requestStage->id.' )','class'=>"btn btn-primary btn-xs"]):null?>
                                    </div>
                                </div>


                            </div>

                        </div>
                    </li>
                    <?php
                }
            ?>


        </ul>
    </div>
</div>

<?=$this->registerJsFile('/js/buy-request/_hitos.js',['depends'=>\yii\web\JqueryAsset::className()])?>