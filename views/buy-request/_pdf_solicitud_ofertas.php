<?php


/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest  */
$this->title=$model->code;
?>
<div>
    <div class="row">
        <div class="col-6" style="padding-top: 20px">
            <h1 class="title" >SOLICITUD DE COTIZACIÓN</h1>
        </div>

        <div class="col-6" style="text-align: right">
            <img src="img/SEISA2.png" style="height: 80px">
        </div>
    </div>
    <table class="table">
        <tr>
            <td style="width: 70%">
                <p style="font-weight: bold;" >Estimado Señor: La  Compañía SEISA tiene interés de  contar con su mejor oferta a  partir de la
                    solicitud que más abajo se detalla, desglosada por surtido de forma  que  se adjunta.
                </p>
            </td>
            <td style="width: 15%" style="text-align: center; background-color: yellow">
                <b>Solicitud No:</b>
                <p>
                    <?=$model->code?>
                </p>
            </td>
            <td style="width: 15%; text-align: center">
                <b><?=Yii::$app->formatter->asDate($model->buyRequestInternational->bidding_start)?></b>
            </td>
        </tr>
        <tr>
            <td>
                <b style="padding-right: 20px; width: 150px">A:</b> Proveedor:<br><br>
                <b style="padding-right: 20px;width: 150px">De:</b> <b><?=$model->buyerAssigned->full_name?></b><br>
                <b style="width: 150px">Cargo:</b><?=$model->buyerAssigned->cargo?><br>
                <b style="width: 150px">Teléfono:</b><?=$model->buyerAssigned->phone_number?$model->buyerAssigned->phone_number:'-'?><br>
                <b style="width: 150px">Email:</b><?=$model->buyerAssigned->email?><br>
            </td>
            <td colspan="2" style="background-color: yellow;color: red; text-align: center">
                <b>Fecha máxima de presentación de oferta</b><br>
                <b><?=Yii::$app->formatter->asDate($model->buyRequestInternational->bidding_end)?></b>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <b>Su oferta deberá realizarse en las siguientes condiciones:</b><br>
                <ul>
                    <li><b>Reflejar Número Referencia de Solicitud de Oferta:</b></li>
                    <li><b>Identificar proveedor con razon social y logotipo actualizado , firma de la persona autorizada</b></li>
                    <li><b>Mantener el orden de productos respetando lo solicitado en este documento ( dejar en blanco aquellos que no sean ofertados). </b></li>
                    <li><b style="color: red; background-color: yellow">Enviar una copia en formato .xls para facilitar su análisis. </b></li>
                    <li><b>Condición de compra según INCOTERMS ®2010:<?=$model->buyRequestInternational->buyCondition->label?></b></li>
                    <li><b>Puerto/Aeropuerto de destino:<?=$model->buyRequestInternational->destiny->label?>  </b></li>

                </ul>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background: yellow; color: red">
                <b>Forma de pago: <?=$model->buyRequestInternational->paymentInstrument->label?></b>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <b>Validez de la Oferta: (no menos de 60 dias)</b><br>
                <b>El término de entrega requerido será:</b>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background: yellow; color: red">
                <b>Se permiten embarques parciales los que serán aceptados previo acuerdo entre las partes.</b>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <b>Su Oferta debe contener los siguientes aspectos:</b><br>
                <ul>
                    <li><b>Valor Total,</b> según Condición de Compra solicitada, desglosando precio EXW e importe total  <b style="color: red">FOB</b>,
                        <b>Moneda</b> y cualquier otro Gasto perfectamente desglosado incluyendo inspeccion en origen.</li>
                    <li>
                        <b>Envases y Embalajes:</b> Tipo y Especificaciones. Para Cargas Contenerizadas :  tipo de contenedor
                        (20´, 40´, u otros) y si es carga agrupada o carga general. Si se emplea madera en los envases,
                        se debe contar con el Certificado de Fumigación según la <b>NIMF- 15</b>. Cubicaje en M3
                    </li>
                    <li style="color: red">
                        Cantidad de bultos , especificando Peso bruto y neto del total ( en kg )
                    </li>
                    <li>
                        <b>
                            En caso de embarques parciales o cronograma de entregas ,indicar : cantidad de bultos y/o
                            contenedores , pesos y cubicaje en m3 , por cada embarque parcial
                        </b>
                    </li>
                    <li style="color: red">
                        <b style="color: #0e0e0e">Calidad:</b> Indicar las Certificaciones de Calidad del Producto de acuerdo a las Normas Internacionales.
                    </li>
                    <li><b>
                            Origen de los productos.
                        </b></li>
                    <li>
                        <b>Marca y numero de parte del fabricante para cada item</b>
                    </li>
                    <li style="color: red">
                        <b>
                            Estado de la homologacion del producto ante la Agencia correspondiente ( APCI )
                        </b>
                    </li>
                    <li>
                        <b>Partida arancelaria para cada item
                        </b>
                    </li>
                    <li>
                        <b>Puerto/Aeropuerto de Embarque.
                        </b>
                    </li>
                    <li>
                        <b>Posibles Trasbordos/Escalas.
                        </b>
                    </li>
                    <li>
                        <b style="color: red">
                            Garantía: mínimo un 1 año a partir de la fecha de embarque
                        </b>
                    </li>
                </ul>
            </td>
        <tr>
            <td colspan="3" style="background: yellow; color: red">
                <b>NO SE ACEPTARAN OFERTAS COMERCIALES EMITIDAS MAS ALLA DEL PLAZO MAXIMO ESPECIFICADO POR SEISA. </b>
            </td>
        </tr>

    </table>
    <p>
        <b> En espera su acostumbrada atención y al tanto de cualquier aclaración<br>
            Fraternalmente,
        </b>
    </p>
    <p>
        <b> Dirección de Compras (+53) 722-71-44 / 45. Inmobiliaria Kolhy, 4to piso, Of. 41, Rpto Kohly Calle 47 No. 3413 e/ 34 y 36, Playa, La Habana

        </b>
    </p>
</div>

