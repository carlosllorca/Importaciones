<?php



/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequestProvider|null */
/* @var $newOffert \app\models\Offert|null */

use yii\helpers\Html;
use yii\helpers\Url;
use yii\widgets\ActiveForm;
?>
<div class="container" style="background-color: white; padding: 15px;border: 1px solid #eee;border-radius: 5px">




    <!-- Modal -->
    <div class="modal fade" style="margin-top: 20%" id="generate_ofert" tabindex="-1" role="dialog" aria-labelledby="Generar oferta" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <?php
            $form = ActiveForm::begin([
                'options' => ['enctype'=>'multipart/form-data'],
                'action' => 'save-ofert','id'=>'new-ofert'
            ]);
            ?>
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Nueva oferta</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="hidden">
                        <?= $form->field($newOffert, 'buy_request_provider_id')->textInput(['type'=>'number'])?>
                        <?= $form->field($newOffert, 'upload_date')->textInput()?>
                        <?= $form->field($newOffert, 'upload_by')->textInput()?>
                    </div>
                    <div class="row">

                        <div class="col-sm-6">
                            <?= $form->field($newOffert, 'expiration_date')->textInput(['type' => 'date']) ?>
                        </div>
                        <div class="col-xs-12">
                            <?= $form->field($newOffert, 'oferta')->widget(\kartik\file\FileInput::className(),[

                                'pluginOptions' =>[
                                    'uploadUrl' => Url::to(['/site/file-upload']),
                                    'showPreview' => false,
                                    'allowEmpty'=>false,
                                    'showCancel'=>false,
                                    'showUpload'=>false,
                                    'browseLabel' => 'Explorar',
                                    'browseIcon'=>'<i class="fa fa-folder-open mr-2"></i>',
                                    'removeIcon' => '<i class="fa fa-trash"></i> ',
                                    'mainClass' => 'input-group-xl',
                                    'showCaption' => true,
                                ]
                            ])->label('Adjunte la oferta suministrada por el proveedor') ?>
                        </div>

                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-success">Guardar oferta</button>
                </div>
            </div>
            <?php ActiveForm::end(); ?>
        </div>
    </div>
    <p style="text-align: center; background-color: white" class="title">DETALLES DEL PROVEEDOR</p>
    <div style="width: 100%; border: 1px solid #fefefe">
        <div class="row">
            <div class="col-sm-4">
                <label>Nombre</label>
                <p><?=$model->provider->name?></p>
            </div>
            <div class="col-sm-4" >
                <label>País</label>
                <p><?=$model->provider->country->label?></p>
            </div>
            <div class="col-sm-4">
                <?php
                    if($model->buyRequest->buy_request_type_id==\app\models\BuyRequestType::$INTERNACIIONAL_ID&&Yii::$app->user->can('buyrequest/uploadoffert')&&$model->buyRequest->buyRequestInternational->biddingActive()){
                      ?>
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-primary" onclick="generateOffert(<?=$model->id?>)">
                            Generar oferta
                        </button>
                        <?php
                    }
                ?>
            </div>
            <div class="col-sm-12" id="table-providers">
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th>Código</th>
                        <th>Recibido</th>
                        <th>Expira</th>
                        <th>Propuesta</th>
                        <th>Evaluación</th>
                        <th>Fecha evaluación</th>
                        <th>Aprobada</th>
                        <th></th>


                    </tr>
                    </thead>
                    <tbody>
                    <?php
                    if($model->offerts){
                        foreach ($model->offerts as $offert){
                            ?>
                            <tr>
                                <th><?=$offert->code?></th>
                                <th><?=Yii::$app->formatter->asDate($offert->upload_date)?></th>
                                <th><?=Yii::$app->formatter->asDate($offert->expiration_date)?></th>
                                <th><?= Html::a('Descargar',$offert->url_file,['target'=>'_blank'])?></th>
                                <th>
                                    <?=$offert->url_evaluation?Html::a("<span class='fa fa-download'></span>",$offert->url_evaluation,['target'=>'_blank']):'-'?>
                                </th>
                                <th><?=$offert->evaluation_date?Yii::$app->formatter->asDate($offert->evaluation_date):'-'?></th>
                                <th><?=$offert->evaluation_date?Yii::$app->formatter->asBoolean($offert->approved):'-'?></th>
                                <th><?=Yii::$app->user->can('buyrequest/evaluateoffert')&&!$model->buyRequest->getWinners()?Html::a("<span class='fa fa-check' title='Evaluar'></span>",'#',
                                    [

                                            'onclick'=> "evaluateOffert({$offert->id})",

                                    ]):''?></th>
                            </tr>
                            <?php
                        }
                    }else{
                        ?>
                    <tr>
                        <th colspan="7"><p style="font-weight: 100;color: #cecece;text-align: center">Aún no se ha registrado ninguna oferta para este proveedor.</p></th>
                    </tr>
                        <?php
                    }


                    ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
