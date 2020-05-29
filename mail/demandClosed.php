<?php
/**
 * @var $demand \app\models\Demand
 */
?>
<div class="row">
    <div class="title">
        <p>Se ha cerrado la demanda <?=$demand->demand_code?></p>
    </div>
    <div class="content">
        <p>
            Saludos <?=$demand->createdBy->full_name?>:<br>
            Queremos informarle que la demanda <?=$demand->demand_code?> ha sido cerrada. Puede ver los detalles en la plataforma. <br>
            Muchas gracias.
        </p>
    </div>
</div>
