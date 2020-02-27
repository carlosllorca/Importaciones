<?php



/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */
use yii\widgets\ActiveForm;
use yii\helpers\Html;
?>

<div class="row">
    <div class="col-md-12">



        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <?php $form = ActiveForm::begin(); ?>
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Iniciar licitación</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <?=$this->render('_licitacion',['model'=>$model,'form'=>$form])?>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        <?= Html::submitButton("<span class='glyphicon glyphicon-send'></span> Notificar proveedores",
                            [
                                    'class' => 'btn btn-primary',
                                    'title'=>'Guardar los datos y notificar vía email a los proveedores seleccionados.'
                            ]) ?>
                    </div>
                    <?php ActiveForm::end(); ?>
                </div>
            </div>
        </div>
    </div>
<?php
    if($model->buy_request_status_id==\app\models\BuyRequestStatus::$BORRADOR_ID){
        ?>
        <div class="col-xs-12">
            <p style="text-align: center;margin-top: 10%; font-size: 20px;color: #cecece">
                La solicitud de compra debe ser aprobada para ver esta sección.
            </p>
        </div>
        <?php
    }else{
        if($model->bidding_start==null){
            ?>
            <div class="col-xs-12">
                <p style="text-align: center;margin-top: 10%; font-size: 20px;color: #cecece">
                    El proceso de licitación para esta orden de compra aún no se ha iniciado.
                    <a class="link" href="#"  data-toggle="modal" data-target="#exampleModal"><b>¿Desea iniciarlo?</b></a>
                </p>
            </div>
            <?php
        }
    }
?>
</div>
<?php
$this->registerJsFile('js/openModal.js',['depends'=>\yii\web\JqueryAsset::className()])
?>