<?php


/* @var $this \yii\web\View */

/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */

use yii\helpers\Html; ?>
<!-- Modal -->
<div class="modal fade" style="margin-top: 20%" id="upload-file-expedient" tabindex="-1" role="dialog" aria-labelledby="Subir archivo al expediente" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" >Subir archivo al expediente</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="bodyUploadFile">

            </div>

        </div>

    </div>
</div>
<?php
if($model->allDocumentOk()){
    ?>
    <!-- Modal -->
    <div class="modal fade" style="margin-top: 20%" id="transport-form" tabindex="-1" role="dialog" aria-labelledby="Iniciar ciclo de transportación" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" >Iniciar ciclo de transportación</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="bodyTransport">

                </div>

            </div>

        </div>
    </div>
    <?php
}
?>



<div class="row p-5">
    <div class="col-sm-12">
        <?php
        if (Yii::$app->user->can('buyrequest/sendtomonitoring')) {
            ?>
            <p style="text-align: right">
                <?= Html::a('Enviar a seguimiento', ['#','id'=>$model->id],
                    $model->allDocumentOk()?
                        [
                                'class' => 'btn btn-primary',
                                'data-toggle'=>"modal",
                                'data-target'=>"#transport-form",
                                'onclick'=> "transportForm({$model->id})",

                        ]
                        :['class' => 'btn btn-primary disabled']) ?>
                <?= Html::a('Subir otro documento', '#',
                    [
                            'class' => 'btn btn-primary',
                            'onclick'=> "uploadFileExpedient(false,".$model->id.")",
                            'data-toggle'=>"modal",
                             'data-target'=>"#upload-file-expedient",
                            'title'=>'Puedes subir un documento que no esté referido en la lista.'
                    ]) ?>
            </p>
            <?php
        }
        ?>


    </div>

    <div class="col-sm-12">
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>Documento</th>
                <th>Responsable</th>
                <th>Estado</th>
                <th>Subido por</th>
                <th>Fecha</th>
                <th></th>
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
                    <th><?= $buyRequestDocument->url_to_file ? $buyRequestDocument->lastUpdatedBy->full_name : '-' ?></th>
                    <th><?= $buyRequestDocument->url_to_file ? Yii::$app->formatter->asDate($buyRequestDocument->last_update) : '-' ?></th>
                    <th>
                        <?= $buyRequestDocument->url_to_file ? Html::a("<span class='glyphicon glyphicon-download'></span>", $buyRequestDocument->url_to_file, ['target' => '_blank', 'title' => 'Descargar']) : '' ?>
                        <?=$buyRequestDocument->documentType&&$buyRequestDocument->documentType->userLoggedCanUpdate()||!$buyRequestDocument->documentType?

                            Html::a("<span class='glyphicon glyphicon-upload'></span>", '#',
                                [

                                    'title' => 'Subir archivo',
                                    'data-toggle'=>"modal",
                                    'onclick'=> "uploadFileExpedient({$buyRequestDocument->id})",
                                    'data-target'=>"#upload-file-expedient"
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