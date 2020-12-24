<?php
/* @var $this \yii\web\View */
/* @var $data array|\yii\db\DataReader */
$this->title='Valor de las solicitudes cerrradas por meses';
?>
<div class="container-page" style="padding: 0px 30px">
    <?=$this->render('header',['title'=>$this->title,'date_start'=>$model->date_start,'date_end'=>$model->date_end])?>
    <?php
    if(count($data)==0){
        echo $this->render('no_data_to_display');
    }else{
        ?>
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
        <?php
    }
    ?>

</div>

