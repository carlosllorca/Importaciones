<?php
use yii\helpers\Url;


/* @var $this \yii\web\View */
/* @var $data array|\yii\db\DataReader */
$pos
?>
<div class="container-page" style="padding: 0px 30px">
    <?=$this->render('header',['title'=>"PRODUCTOS MÁS DEMANDADOS EN EL ÚLTIMO AÑO."])?>
    <div style="width: 100%">
        <table style="width: 100%">
            <tr>
                <th style="width: 7%">No.</th>
                <th>Producto</th>
                <th>UM</th>
                <th>Demandas</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>Importe</th>
            </tr>

            <?php
            $pos=0;
                foreach ($data as $d){
                    ?>
                    <tr>
                        <td><?=++$pos?></td>
                        <td><?=$d['product_name']?></td>
                        <td><?=$d['um']?></td>
                        <td><?=$d['demandas_solicitadas']?></td>
                        <td><?=Yii::$app->formatter->asCurrency($d['precio'])?></td>
                        <td><?=$d['cantidad']?></td>
                        <td><?=Yii::$app->formatter->asCurrency($d['importe'])?></td>
                    </tr>
                    <?php

                }
            ?>
        </table>
    </div>
</div>
