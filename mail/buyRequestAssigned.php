<?php
/**
 * @var $buyRequest \app\models\BuyRequest
 */
?>
<div class="row">
    <div class="title">
        <p>Se le ha asignado la solicitud <?=$buyRequest->buyRequestType->label?>   <?=$buyRequest->code?>.</p>
    </div>
    <div class="content">
        <p>
            Saludos:<br>
            Se le ha asignado la solicitud de compra  <?=$buyRequest->buyRequestType->label?> con código <b><i><?=$buyRequest->code?></i></b>.
            Esta solicitud  de compra se encuentra ahora pendiente de su gestión en el sistema.<br>
        </p>
    </div>
</div>
