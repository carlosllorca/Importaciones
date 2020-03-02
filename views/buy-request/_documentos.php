<?php


/* @var $this \yii\web\View */

/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */

use yii\helpers\Html; ?>
<div class="row p-5">
    <div class="col-sm-12">
        <p style="text-align: right">
            <?= Html::a('Enviar a seguimiento', '#', ['class' => 'btn btn-primary disabled']) ?>
        </p>
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
            foreach ($model->documentsUser() as $buyRequestDocument) {
                ?>
                <tr>
                    <th><?=$buyRequestDocument->documentType->label?></th>
                    <th>-</th>
                    <th><?=$buyRequestDocument->url_to_file?'SUBIDO':'PENDIENTE'?></th>
                    <th><?=$buyRequestDocument->url_to_file?$buyRequestDocument->lastUpdatedBy->full_name:'-'?></th>
                    <th><?=$buyRequestDocument->url_to_file?Yii::$app->formatter->asDate($buyRequestDocument->last_update):'-'?></th>
                    <th>
                        <?=$buyRequestDocument->url_to_file?Html::a("<span class='glyphicon glyphicon-download'></span>",$buyRequestDocument->url_to_file,['target'=>'_blank','title'=>'Descargar']):''?>
                    </th>
                </tr>
                <?php
            } ?>

            </tbody>
        </table>
    </div>
</div>
