<?php
/**
 * @var $buyRequest \app\models\BuyRequest
 */
?>
<div class="row">
    <div class="title">
        <p>Se ha aprobado una nueva solicitud de compra de tipo <?=$buyRequest->buyRequestType->label?> con código <?=$buyRequest->code?></p>
    </div>
    <div class="content">
        <p>
            Saludos:<br>
            Se ha generado una nueva solicitud de compra <?=$buyRequest->buyRequestType->label?> con código <b><i><?=$buyRequest->code?></i></b>.
            Esta solicitud  de compra se encuentra ahora pendiente de su gestión en el sistema.<br>
        </p>
    </div>
</div>
