<?php
/**
 * @var $offert \app\models\Offert
 */
?>
<div class="row">
    <div class="title">
        <p> Se ha generado una nueva oferta en la solicitud de compra <?=$offert->buyRequestProvider->buyRequest->code?></p>
    </div>
    <div class="content">
        <p>
            Saludos <?=$offert->buyRequestProvider->buyRequest->dtSpecialistAssigned->full_name?>:<br>
            El proveedor <?=$offert->buyRequestProvider->provider->name?> ha enviado una nueva oferta para la solicitud de compra <?=$offert->buyRequestProvider->buyRequest->code?>.
            Usted debe ahora acceder al sistema y evaluar la misma.
        </p>
    </div>
</div>
