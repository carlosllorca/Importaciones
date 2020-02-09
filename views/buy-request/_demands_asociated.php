<?php


/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest|\yii\db\ActiveRecord */
?>
<div class="row p-5">

    <div class="col-sm-12">
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>Código</th>
                <th>Entidad</th>
                <th>Organismo</th>
                <th>Fecha</th>
                <th>Estado</th>
            </tr>
            </thead>
            <tbody>
            <?php
            foreach ($model->getDemands() as $item) {
                ?>
                <tr>
                    <th><?=$item->demand_code?></th>
                    <th><?=$item->client->name?></th>
                    <th><?=$item->client->organism->name?></th>
                    <th><?=Yii::$app->formatter->asDate($item->approved_date)?></th>
                    <th><b class="text-uppercase <?= $item->classByStatus()?>"
                            style="font-family: Roboto-bold"><?= $item->demandStatus->label ?></b></th>
                </tr>
                <?php
            }
            ?>
            </tbody>
        </table>
    </div>

</div>
