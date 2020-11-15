<?php


/* @var $this \yii\web\View */
/* @var $internacionales array|\yii\db\DataReader */
/* @var $nacionales array|\yii\db\DataReader */
$this->title = 'Órdenes de compra  con hitos fuera de fecha';
?>
<div class="container-page" style="padding: 0px 30px">
    <?=$this->render('header',['title'=>$this->title,'date_start'=>$model->date_start,'date_end'=>$model->date_end])?>
    <?php
    if(count($internacionales)==0&&count($nacionales)==0){
        echo $this->render('no_data_to_display');
    }else{
        ?>
        <table style="width: 100%">
            <tr>
                <th colspan="4" style="text-align: center">
                    Datos de la órden
                </th>
                <th colspan="6" style="text-align: center">
                    Hitos
                </th>
            </tr>
            <tr>
                <th style="width: 7%">No.</th>
                <th>Código</th>
                <th>Fecha</th>
                <th>Estado</th>
                <th>D. Logística</th>
                <th>D. Técnica</th>
                <th>D. Compras</th>
                <th>Licitación</th>
                <th>Evaluación</th>
                <th>Aprobación</th>

            </tr>

            <?php
            $pos = 0;
            if (count($internacionales) == 0 && count(($nacionales))) {
                ?>
                <tr>
                    <td colspan="10" style="text-align: center; padding: 10px; color: #aeaeae; font-style: italic"><p
                                style="text-align: center">Sin resultados...</p></td>
                </tr>
                <?php
            }
            $ueb = '';
            $br = '';
            if ($internacionales) {
                ?>
                <tr>
                    <td colspan="10"
                        style="text-align: center;  color: #fff; text-transform: uppercase;font-style: italic;background-color: #aeaeae">
                        <p style="text-align: center; font-weight: bold">Internacional</p>
                    </td>
                </tr>
                <?php
                foreach ($internacionales as $d) {
                    ?>
                    <tr>
                        <td><?= ++$pos ?></td>
                        <td><?= $d['code'] ?></td>
                        <td><?= Yii::$app->formatter->asDate($d['created']) ?></td>
                        <td><?= $d['estado'] ?></td>
                        <td class="<?=$d['t_aproved']>3?"danger":null?>"><?= $d['t_aproved'] ?></td>
                        <td class="<?=$d['t_dt_approved']>3?"danger":null?>"><?= $d['t_dt_approved'] ?></td>
                        <td class="<?=$d['t_buy_approved']>3?"danger":null?>"><?= $d['t_buy_approved'] ?></td>
                        <td class="<?=$d['t_licitation']>14?"danger":null?>"><?= $d['t_licitation'] ?></td>
                        <td class="<?=$d['t_winner_selected']>7?"danger":null?>"><?= $d['t_winner_selected'] ?></td>
                        <td class="<?=$d['t_execution_start']>50?"danger":null?>"><?= $d['t_execution_start'] ?></td>

                    </tr>
                    <?php
                }

            }
            if ($nacionales) {
                ?>

                <?php
                foreach ($internacionales as $d) {
                    if($d['tipo']!=$ueb){
                        ?>
                        <tr>
                            <td colspan="10"
                                style="text-align: center;  color: #fff; text-transform: uppercase;font-style: italic;background-color: #aeaeae">
                                <p style="text-align: center; font-weight: bold"><?=$d['tipo']?></p>
                            </td>
                        </tr>
                        <?php
                    }
                    $ueb=$d['tipo'];
                    ?>
                    <tr>
                        <td><?= ++$pos ?></td>
                        <td><?= $d['code'] ?></td>
                        <td><?= Yii::$app->formatter->asDate($d['created']) ?></td>
                        <td><?= $d['estado'] ?></td>
                        <td class="<?=$d['t_aproved']>3?"danger":null?>"><?= $d['t_aproved'] ?></td>
                        <td class="<?=$d['t_dt_approved']>3?"danger":null?>"><?= $d['t_dt_approved'] ?></td>
                        <td class="<?=$d['t_buy_approved']>3?"danger":null?>"><?= $d['t_buy_approved'] ?></td>
                        <td  style="background-color: #aeaeae"></td>
                        <td class="<?=$d['t_winner_selected']>7?"danger":null?>"><?= $d['t_winner_selected'] ?></td>
                        <td class="<?=$d['t_execution_start']>50?"danger":null?>"><?= $d['t_execution_start'] ?></td>

                    </tr>
                    <?php
                }

            }

            ?>
        </table>
        <?php
    }
    ?>

</div>

