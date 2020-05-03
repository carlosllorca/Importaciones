<?php
/**
 * @var $demand \app\models\Demand
 */
use yii\helpers\Url;
?>
<div class="row">
    <div class="title">
        <p>Demanda aprobada.</p>
    </div>
    <div class="content">
        <p>
            Saludos <?=$demand->createdBy->full_name?>:<br>
            Luego de un análisis detallado de la demanda <b><i><?=$demand->demand_code?></i></b> enviada por usted, en el día de hoy ha quedado aprobada.
            A partir de este punto se generarán las solicitudes de  compra correspondientes. Usted puede consultar en todo momento el estado en que estas se encuentran accediendo al sistema
            <a class="link" href="<?=Url::home('http')?>"><?=Url::home('http')?></a>. <br>
            Muchas gracias.
        </p>
    </div>
</div>
