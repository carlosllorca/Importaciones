<?php
/**
 * @var $buyRequest \app\models\BuyRequest
 */
?>
<div class="row">
    <div class="title">
        <p>Se ha creado una nueva solicitud de compra de tipo <?=$buyRequest->buyRequestType->label?> con código <?=$buyRequest->code?></p>
    </div>
    <div class="content">
        <p>
            Saludos:<br>
            El usuario <i><?=$buyRequest->createdBy->full_name?></i>
            ha generado una nueva solicitud de compra <?=$buyRequest->buyRequestType->label?> con código <b><i><?=$buyRequest->code?></i></b>.
            Esta solicitud  de compra se encuentra ahora pendiente de su gestión en el sistema.<br>
        </p>
    </div>
</div>
