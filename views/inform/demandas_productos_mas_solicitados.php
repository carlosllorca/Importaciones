<?php
use yii\helpers\Url;


/* @var $this \yii\web\View */
/* @var $data array|\yii\db\DataReader */
/* @var $model \app\models\InformForm */
$pos
?>
<div class="container-page" style="padding: 0px 30px">
    <?=$this->render('header',[
            'title'=>"PRODUCTOS MÁS DEMANDADOS.",
            'date_start'=>$model->date_start,
            'date_end'=>$model->date_end
        ]
    )
    ?>
    <?php
        if(count($data)==0){
            echo $this->render('no_data_to_display');
        }else{
            ?>
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
            <?php
        }
    ?>

</div>
