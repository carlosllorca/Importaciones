<?php
/**
 * @var $demand \app\models\Demand
 */
?>
<div class="row">
    <div class="title">
        <p>Demanda rechazada.</p>
    </div>
    <div class="content">
        <p>
            Saludos <?=$demand->createdBy->full_name?>:<br>
            Luego de un análisis detallado de la demanda <b><i><?=$demand->demand_code?></i></b> enviada por usted. Nos vemos obligados a rechazarla
            por los motivos que a continuación se describen:<br><br>
            <i style="font-weight: bold; color: red"><?=$demand->rejected_reason?></i>
            <br><br>
            Por favor corrija estos elementos y vuelva a enviarla. <br>
            Muchas gracias.
        </p>
    </div>
</div>
