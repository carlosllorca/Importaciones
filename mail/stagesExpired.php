<?php
/**
 * @var $requestStage \app\models\RequestStage[]
 * @var $user \app\models\User
 */
$a = 0;
?>

<div class="row">
    <div class="title">
        <p>Algunas solicitudes de compra requieren su atención debido a hitos que han expirado y aún no han sido
            marcados
            como resueltos.</p>
    </div>
    <div class="content">

        <p>
            Estimado(a) <?= $user->full_name ?>:<br>
            A continuación le listamos un grupo de hitos que han expirado y usted aún no ha marcado como resuelto
            exortándole
            a que le de un seguimiento a las causas que lo mantienen en este estado.<br><br>
        <table >
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Solicitud</th>
                    <th style="width: 30%">Hito</th>
                    <th>Fecha Inicio</th>
                    <th>Fecha Fin</th>
                    <th style="width: 30%">Observaciones</th>

                </tr>
            </thead>
            <tbody>
            <?php
            foreach ($requestStage as $rs) {
                ?>
                <tr style="border:1px solid #cecece">
                    <td><b><?= ++$a ?></b></td>
                    <td><?= $rs->buyRequest->code ?></td>
                    <td><?= $rs->stage->label ?></td>
                    <td><?= Yii::$app->formatter->asDate($rs->date_start) ?></td>
                    <td><?= Yii::$app->formatter->asDate($rs->date_end) ?></td>
                    <td><?= $rs->details ?></td>

                </tr>

                <?php
            }
            ?>
            </tbody>



        </table>
        <br><br>

        </p>


    </div>
</div>
