<?php
/**
 * @var $demand \app\models\Demand
 */
?>
<div class="row">
    <div class="title">
        <p>Se ha recibido una nueva demanda</p>
    </div>
    <div class="content">
        <p>
            Saludos:<br>
            El usuario <i><?=$demand->createdBy->full_name?></i> asociado a <i><?=$demand->client->provinceUeb->label?></i>
            ha generado una nueva demanda con código <b><i><?=$demand->demand_code?></i></b>.
            Esta demanda se encuentra ahora pendiente de su gestión en el sistema.<br>
        </p>
    </div>
</div>
