<?php



/* @var $this \yii\web\View */
/* @var $data array|\yii\db\DataReader */
$this->title="Ordenes activas con hitos vencidos";
?>
<div class="container-page" style="padding: 0px 30px">
    <?=$this->render('header',['title'=>$this->title])?>
    <table style="width: 100%">
        <tr>
            <th colspan="3" style="text-align: center">Solicitud </th>
            <th colspan="4" style="text-align: center">Hito </th>
        </tr>
        <tr>
            <th style="width: 7%">No.</th>
            <th>Solicitud</th>
            <th>Creada </th>
            <th>Nombre del Hito</th>
            <th>Inicio esperado</th>
            <th>Fin esperado</th>
            <th>Observaciones</th>
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
            if($d['tipo']!=$ueb)
            {
                $ueb=$d['tipo']
                ?>
                <tr>
                    <td colspan="6" style="text-align: center;  color: #fff; text-transform: uppercase;font-style: italic;background-color: #aeaeae">
                        <p style="text-align: center; font-weight: bold"><?=$ueb?></p>
                    </td>
                </tr>
                <?php
            }
            ?>
            <tr>
                <td><?=++$pos?></td>
                <td><?=$d['code']?></td>

                <td><?=Yii::$app->formatter->asDate($d['created'])?></td>
                <td><?=$d['hito']?></td>

                <td><?=Yii::$app->formatter->asDate($d['date_start'])?></td>
                <td><?=Yii::$app->formatter->asDate($d['date_end'])?></td>
                <td><?=$d['details']?></td>

            </tr>
            <?php

        }
        ?>
    </table>
</div>
