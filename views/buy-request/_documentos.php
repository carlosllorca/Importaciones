<?php


/* @var $this \yii\web\View */

/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */

use yii\helpers\Html;
use yii\bootstrap4\Modal;
Modal::begin([
    'title' =>'Subir documento',
    'id' => 'modal-documentos',
    'toggleButton' => ['label' => 'click me','id'=>'ajax-modal-documents','class'=>'hidden'],
]);
echo '<div id="modal-content-documents"></div>';
Modal::end();
?>
<div class="row p-5">
    <div class="col-sm-12">


            <p style="text-align: right">
                <?php
            if (Yii::$app->user->can('buyrequest/sendtomonitoring')) {
                if ($model->buy_request_status_id == \app\models\BuyRequestStatus::$EVALUANDO_OFERTAS && $model->buy_request_type_id == \app\models\BuyRequestType::$INTERNACIIONAL_ID) {
                    echo Html::a('Enviar a seguimiento', ['#', 'id' => $model->id],
                        $model->allDocumentOk() ?
                            [
                                'class' => 'btn btn-primary',
                                'data-toggle' => "modal",
                                'data-target' => "#transport-form",
                                'onclick' => "transportForm({$model->id})",

                            ]
                            : ['class' => 'btn btn-primary disabled']);
                } else if ($model->buy_request_status_id == \app\models\BuyRequestStatus::$EVALUANDO_OFERTAS) {
                    echo Html::a('Enviar a seguimiento', ['/buy-request/send-to-monitoring', 'id' => $model->id],
                        $model->allDocumentOk() ?
                            [
                                'class' => 'btn btn-primary',
                                'data-toggle' => "modal",
                                'data-target' => "#transport-form",
                                'onclick' => "transportForm({$model->id})",

                            ]
                            : ['class' => 'btn btn-primary disabled']);
                }
            }
                ?>

                <?=$model->buy_request_status_id!=\app\models\BuyRequestStatus::$CERRADA? Html::a('Subir otro documento', '#',
                    [
                            'class' => 'btn btn-primary',
                            'onclick'=> "subirArchivo(false,".$model->id.")",

                            'title'=>'Puedes subir un documento que no esté referido en la lista.'
                    ]):null ?>
            </p>


    </div>

    <div class="col-sm-12">
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>Documento</th>
                <th>Responsable</th>
                <th>Estado</th>
                <th>¿Requerido?</th>
                <th>Subido por</th>
                <th>Fecha</th>
                <th class="<?=$model->buy_request_status_id!=\app\models\BuyRequestStatus::$CERRADA?'':'hidden'?>"></th>
            </tr>
            </thead>
            <tbody>
            <?php
            if(count($model->documentsUser())==0){
                ?>
            <tr>
                <th colspan="6"><p style="text-align: center;color: #cecece">Usted no tiene acceso a ningún documento de este expediente.
                        Pongase en contacto con la administración si cree que esto es un error.</p> </th>
            </tr>
                <?php
            }
            foreach ($model->documentsUser() as $buyRequestDocument) {
                ?>
                <tr>
                    <th><?=$buyRequestDocument->documentType? $buyRequestDocument->documentType->label:$buyRequestDocument->custom_file ?></th>
                    <th><?= $buyRequestDocument->documentType?$buyRequestDocument->documentType->responsable:$buyRequestDocument->lastUpdatedBy->full_name ?></th>
                    <th><b class="<?=$buyRequestDocument->documentStatus->classByStatus()?>"><?=$buyRequestDocument->documentStatus->label?></b></th>
                    <th><b ><?=$buyRequestDocument->documentType&&$buyRequestDocument->documentType->required?"Si":"No"?></b></th>
                    <th><?= $buyRequestDocument->url_to_file ? $buyRequestDocument->lastUpdatedBy->full_name : '-' ?></th>
                    <th><?= $buyRequestDocument->url_to_file ? Yii::$app->formatter->asDate($buyRequestDocument->last_update) : '-' ?></th>
                    <th class="<?=$model->buy_request_status_id!=\app\models\BuyRequestStatus::$CERRADA?'':'hidden'?>">
                        <?= $buyRequestDocument->url_to_file ? Html::a("<span class='fa fa-download'></span>", $buyRequestDocument->url_to_file, ['target' => '_blank', 'title' => 'Descargar']) : '' ?>
                        <?=$buyRequestDocument->documentType&&$buyRequestDocument->documentType->userLoggedCanUpdate()||(!$buyRequestDocument->documentType&&$buyRequestDocument->last_updated_by==Yii::$app->user->identity->id)?
                            Html::a("<span class='fa fa-upload'></span>", '#',
                                [
                                    'title' => 'Subir archivo',
                                    'onclick'=> "subirArchivo({$buyRequestDocument->id})",
                                ]) : ''?>
                    </th>
                </tr>
                <?php
            } ?>

            </tbody>
        </table>
    </div>
</div>
<?php
$this->registerJsFile('js/buy-request/_documentos.js',['depends'=>\yii\web\JqueryAsset::className()]);