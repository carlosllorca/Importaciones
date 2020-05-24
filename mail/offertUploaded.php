<?php
/**
 * @var $offert \app\models\Offert
 */
?>
<div class="row">
    <div class="title">
        <p> Se ha evaluado una oferta en la solicitud de compra <?=$offert->buyRequestProvider->buyRequest->code?></p>
    </div>
    <div class="content">
        <p>
            Saludos <?=$offert->buyRequestProvider->buyRequest->buyerAssigned->full_name?>:<br>
            La oferta del proveedor <?=$offert->buyRequestProvider->provider->name?> en la solicitud de compra <?=$offert->buyRequestProvider->buyRequest->code?> ha sido evaluada.

        </p>
    </div>
</div>
