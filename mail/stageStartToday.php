<?php
/**
 * @var $buyRequestStage \app\models\RequestStage

 */
?>

<div class="row">
    <div class="title">
        <p>Se ha iniciado un nuevo hito para la solicitud <?= $buyRequestStage->buyRequest->code ?> .</p>
    </div>
    <div class="content">

            <p>
                Estimado(a) <?=$buyRequestStage->buyRequest->buyerAssigned->full_name?>:<br>
                En el día de hoy comienza el plazo para la gestión del hito <i><?=$buyRequestStage->stage->label?></i>
                el cual se extiende desde hoy (<?=Yii::$app->formatter->asDate($buyRequestStage->date_start)?>) y hasta el
                <?=Yii::$app->formatter->asDate($buyRequestStage->date_end)?>. No olvide acceder a la plataforma y una
                vez realizado maracar este hito como completo.
                <br><br>

            </p>


    </div>
</div>
