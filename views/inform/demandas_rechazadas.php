<?php



/* @var $this \yii\web\View */
/* @var $data array|\yii\db\DataReader */
$this->title="Demandas rechazadas";
?>
<div class="container-page" style="padding: 0px 30px">
    <?=$this->render('header',['title'=>$this->title])?>
    <table style="width: 100%">
        <tr>
            <th style="width: 7%">No.</th>
            <th>Demanda</th>
            <th>Cliente </th>
            <th>Organismo</th>
            <th>Fecha de envío</th>
            <th>Motivo</th>

        </tr>

        <?php
        $pos=0;
        if(count($data)==0){
            ?>
            <tr> <td colspan="7" style="text-align: center; padding: 10px; color: #aeaeae; font-style: italic"><p style="text-align: center">Sin resultados...</p></td></tr>
            <?php
        }
        $ueb = '';
        foreach ($data as $d){
            if($d['ueb_name']!=$ueb)
            {
                $ueb=$d['ueb_name']
                ?>
                <tr>
                    <td colspan="7" style="text-align: center;  color: #fff; text-transform: uppercase;font-style: italic;background-color: #aeaeae">
                        <p style="text-align: center; font-weight: bold"><?=$ueb?></p>
                    </td>
                </tr>
                <?php
            }
            ?>
            <tr>
                <td><?=++$pos?></td>
                <td><?=$d['demand_code']?></td>
                <td><?=$d['client_name']?></td>
                <td><?=$d['short_name']?></td>
                <td><?=Yii::$app->formatter->asDate($d['sending_date'])?></td>
                <td><?=$d['rejected_reason']?></td>

            </tr>
            <?php

        }
        ?>
    </table>
</div>
