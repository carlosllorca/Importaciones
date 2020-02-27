<?php



/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest  */
$this->title=$model->code;
?>
<div>
    <table class="table">
        <tr>
            <td colspan="5" style="text-align: center"><p class="title" >solicitud de compras</p></td>
        </tr>
        <tr>
            <td rowspan="2"> <p class="textPrimary">UEB/Cliente:</p></td>
            <td colspan="2" rowspan="2">
                <?php
                foreach ($model->clientes() as $client){
                    ?>
                    <p class="textBasic"><?=$client->provinceUeb->label?> / <?=$client->name?></p>
                    <?php
                }
                ?>
            </td>
            <td colspan="2" style="border-bottom: 0px">
                <p class="textBasic"><b>Solicitud No: </b><?=$model->code?></p>
            </td>

        </tr>
        <tr><td colspan="2"><p class="textBasic"><b>Fecha Sol: </b><?=Yii::$app->formatter->asDate($model->created)?></p></td></tr>
        <tr><td colspan="5" style="text-align: center"><p class="title" >requerimientos de la compra</p></td></tr>
        <tr>
            <td><p class="textPrimary">A ejecutar con:</p></td>
            <td colspan="4"><p class="textBasic"><?=$model->demandItems[0]->demand->strPaymentMethod()?></p></td>
        </tr>
        <tr>
            <td><p class="textPrimary">Las entregas se necesitan en:</p></td>
            <td colspan="4"><p class="textBasic"><?=$model->demandItems[0]->demand->strDeploymentPart()?></p> </td>
        </tr>
        <tr>
            <td><p class="textPrimary">Especificaciones de la garantía:</p></td>
            <td colspan="2"><p class="textBasic"><?=$model->demandItems[0]->demand->warrantySpecification()?></p> </td>
            <td><p class="textPrimary">TIEMPO DE GARANTÍA:</p></td>
            <td><p class="textPrimary"><?=$model->demandItems[0]->demand->txtWarrantyTime()?></p></td>
        </tr>
        <tr><td colspan="5" style="text-align: center"><p class="title" >Motivo de la compra</p></td></tr>
        <tr><td colspan="5" style="text-align: center"><p class="textBasic" ><?=$model->demandItems[0]->demand->strBuyReason()?></p></td></tr>
        <tr><td colspan="5" style="text-align: center"><p class="title" >PIEZAS DE REPUESTO, POST GARANTÍA, ASISTENCIA TÉCNICA Y CAPACITACIÓN</p></td></tr>
        <tr>
            <td><p class="textBasic" >Requiere kit de piezas de repuesto: </p></td>
            <td><p class="textBasic" ><?=$model->demandItems[0]->demand->require_replacement_part?'(X) SI  ( ) NO':'( ) SI  (X) NO'?></p></td>
            <td colspan="3"><p class="textBasic" >(cantidades, código y descripción del fabricante):</p>
                <p class="textBasic" ></p><?=$model->demandItems[0]->demand->replacement_part_details?$model->demandItems[0]->demand->replacement_part_details:'-'?></td>
        </tr>
        <tr>
            <td><p class="textBasic" >Requiere servicio o venta post garantía: </p></td>
            <td><p class="textBasic" ><?=$model->demandItems[0]->demand->require_post_warranty?'(X) SI  ( ) NO':'( ) SI  (X) NO'?></p></td>
            <td colspan="3"><p class="textBasic" >(Plazo y condiciones para la post garantía):</p>
                <p class="textBasic" ></p><?=$model->demandItems[0]->demand->post_warranty_details?$model->demandItems[0]->demand->post_warranty_details:'-'?></td>
        </tr>
        <tr>
            <td><p class="textBasic" >Detalles y alcance de la asistencia técnica: </p></td>
            <td><p class="textBasic"  ><?=$model->demandItems[0]->demand->require_technic_asistance?'(X) SI  ( ) NO':'( ) SI  (X) NO'?></p></td>
            <td colspan="3"><p class="textBasic" >(Detalle y alcance de la asistencia técnica):</p>
                <p class="textBasic" ></p><?=$model->demandItems[0]->demand->technic_asistance_details?$model->demandItems[0]->demand->technic_asistance_details:'-'?></td>
        </tr>
        <tr>
            <td colspan="2">
                <p class="textBasic" >Indicar si se requiere por parte del Vendedor:</p>
                <p class="textBasic" ><?=$model->demandItems[0]->demand->strSellerRequirement()?></p>
            </td>
            <td colspan="2"> <p class="textBasic" >Alcance requerido:</p></td>
            <td> <p class="textBasic" ><?=$model->demandItems[0]->demand->seller_requirement_details?></p></td>
        </tr>
        <tr>
            <td colspan="5" style="vertical-align: top;height: 40px" >
                <p class="textBasic" ><b>OBSERVACIONES:</b>  Adjunto listado con los productos a compras.</p>
                <p class="textBasic" ><?=$model->demandItems[0]->demand->observation?></p>

            </td>
        </tr>
        <tr>
            <td colspan="5" style="padding: 0px 5px">
                <p class="textBasic" style="font-weight: bold" >Por la Dirección de Aseguramiento a la Producción:</p>
            </td>
        </tr>
        <tr>
            <td style="padding: 0px 5px"><p class="textBasic">Elaborado por:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Aprobado por:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
        </tr>
        <tr>
            <td style="padding: 0px 5px"><p class="textBasic">Nombre:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Nombre:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
        </tr>
        <tr>
            <td style="padding: 0px 5px"><p class="textBasic">Cargo:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Especialista Logistico</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Cargo:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Esp Ppal  Gpo  Logística GOL</p></td>
        </tr>
        <tr>
            <td style="padding: 0px 5px"><p class="textBasic">Firma:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Firma:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
        </tr>
        <tr>
            <td style="padding: 0px 5px"><p class="textBasic">Fecha:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Fecha:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
        </tr>
        <tr>
            <td colspan="5" style="padding: 0px 5px">
                <p class="textBasic" style="font-weight: bold" >Por la UEB Compras:</p>
            </td>
        </tr>
        <tr>
            <td style="padding: 0px 5px"><p class="textBasic">Recibido por:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Aprobado por:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
        </tr>
        <tr>
            <td style="padding: 0px 5px"><p class="textBasic">Nombre:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Nombre:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
        </tr>
        <tr>
            <td style="padding: 0px 5px"><p class="textBasic">Cargo:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Esp. Gestion Comercial</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Cargo:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Director de LAD</p></td>
        </tr>
        <tr>
            <td style="padding: 0px 5px"><p class="textBasic">Firma:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Firma:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
        </tr>
        <tr>
            <td style="padding: 0px 5px"><p class="textBasic">Fecha:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
            <td style="padding: 0px 5px"><p class="textBasic">Fecha:</p></td>
            <td style="padding: 0px 5px"><p class="textBasic"></p></td>
        </tr>
    </table>
</div>

