<?php
/* @var $this \yii\web\View */
/* @var $data array|\yii\db\DataReader */
$this->title='Ventas último año';
?>
<div class="container-page" style="padding: 0px 30px">
    <?=$this->render('header',['title'=>$this->title])?>
    <div style="width: 100%; padding-left: 15%;padding-right: 15%">
        <table style="width: 100%">
            <tr>
                <th style="width: 7%">No.</th>
                <th style="width: 15%;">Mes</th>
                <th style="width: 10%;">Ventas</th>

            </tr>

            <?php
            $pos=0;
            if(count($data)==0){
                ?>
                <tr> <td colspan="3" style="text-align: center; padding: 10px; color: #aeaeae; font-style: italic"><p style="text-align: center">Sin resultados...</p></td></tr>
                <?php
            }
            $ueb = '';
            foreach ($data as $d){

                ?>
                <tr>
                    <td><?=++$pos?></td>
                    <td><?=$d['fecha']?></td>
                    <td><?=Yii::$app->formatter->asCurrency($d['amount'])?></td>
                </tr>
                <?php

            }
            ?>
        </table>
    </div>

</div>

