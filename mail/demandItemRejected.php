<?php
/**
 * @var $item \app\models\DemandItem
 */
?>
<div class="row">
    <div class="title">
        <p>Hemos cancelado un producto de la demanda <?=$item->demand->demand_code?>.</p>
    </div>
    <div class="content">
        <p>
            Saludos <?=$item->demand->createdBy->full_name?>:<br>
            Hemos cancelado <?=$item->quantity?> <?=$item->validatedListItem->um->label?>(es) del producto <b><i>
                    <?=$item->validatedListItem->product_name?></i></b> declarado por usted en la demanda <?=$item->demand->demand_code?>
            por los motivos que a continuación se describen:<br><br>
            <i style="font-weight: bold; color: red"><?=$item->cancelled_msg?></i>
            <br><br>
            Si considera que esto es un error por favor póngase en contacto con nosotros. <br>
            Muchas gracias.
        </p>
    </div>
</div>
