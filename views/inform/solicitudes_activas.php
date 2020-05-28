<?php



/* @var $this \yii\web\View */
/* @var $data array|\yii\db\DataReader */
$this->title="Solicitudes de compra activas";
?>
<div class="container-page" style="padding: 0px 30px">
    <?=$this->render('header',['title'=>$this->title])?>
    <table style="width: 100%">
        <tr>
            <th style="width: 7%">No.</th>
            <th>Código</th>
            <th>Fecha </th>
            <th>Demanda </th>
            <th>Cliente</th>
            <th>Organismo</th>
            <th>UEB</th>
            <th>Estado</th>

        </tr>

        <?php
        $pos=0;
        if(count($data)==0){
            ?>
            <tr> <td colspan="8" style="text-align: center; padding: 10px; color: #aeaeae; font-style: italic"><p style="text-align: center">Sin resultados...</p></td></tr>
            <?php
        }
        $ueb = '';
        $br= '';
        foreach ($data as $d){
            if($d['tipo']!=$ueb)
            {
                $ueb=$d['tipo']
                ?>
                <tr>
                    <td colspan="8" style="text-align: center;  color: #fff; text-transform: uppercase;font-style: italic;background-color: #aeaeae">
                        <p style="text-align: center; font-weight: bold"><?=$ueb?></p>
                    </td>
                </tr>
                <?php
            }
            if($br==$d['code']){
                ?>
                <tr>
                    <td colspan="3" style="background-color: #aeaeae"></td>
                    <td><?=$d['demanda']?></td>
                    <td><?=$d['cliente']?></td>
                    <td><?=$d['organismo']?></td>
                    <td><?=$d['ueb']?></td>
                    <td><?=$d['estado']?></td>

                </tr>
                <?php

            }else{
                ?>
                <tr>
                    <td><?=++$pos?></td>
                    <td><?=$d['code']?></td>
                    <td><?=Yii::$app->formatter->asDate($d['created'])?></td>
                    <td><?=$d['demanda']?></td>
                    <td><?=$d['cliente']?></td>
                    <td><?=$d['organismo']?></td>
                    <td><?=$d['ueb']?></td>
                    <td><?=$d['estado']?></td>

                </tr>
                <?php
            }
            $d['tipo']=$ueb;


        }
        ?>
    </table>
</div>

