<?php
/**
 * @var $buyRequest \app\models\BuyRequest
 * @var $message string
 */
?>

<div class="row">
    <div class="title">
        <p>Notificación de inicio/extensión del período de licitación para la solicitud <?= $buyRequest->code ?> .</p>
    </div>
    <div class="content">
        <?php
        if ($message) {
            ?>
            <p>
                <?= $message ?>
            </p>
            <?php
        } else {
            ?>
            <p>
                Estimado(a):<br>
                Hemos decidido iniciar/extender el período de recepción de ofertas para la solicitud de
                compra <?= $buyRequest->code ?>. En el adjunto a este correo
                encontrará indicaciones para el envío de su propuesta así como la relación de productos que necesitamos.<br>
                Muchas gracias de antemano por su participación y esperamos una pronta respuesta suya.
                <br><br>

            </p>
            <?php
        }
        ?>

        <p><?= $message ?></p>
    </div>
</div>
