<?php
/**
 * @var $document \app\models\BuyRequestDocument
 */
?>

<div class="row">
    <div class="title">
        <p>Acaba de ser subido el documento <?=$document->documentType->label?> de la orden de compra <?=$document->buyRequest->code?>.</p>
    </div>
    <div class="content">
        <p>
            Saludos:<br>
            Un usuario acaba de subir el documento <?=$document->documentType->label?>asociado a la orden de compra <?=$document->buyRequest->code?>.
            Según la configuración establecida usted debe ahora realizar alguna acción sobre dicha orden de compra.<br>
            Muchas gracias.
        </p>
    </div>
</div>
