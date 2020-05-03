<?php


/* @var $this \yii\web\View */
/* @var $model \app\models\User */
$this->title = 'Trazas del usuario: ' . $model->full_name;
$this->params['breadcrumbs'][] = ['label' => 'Usuarios', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->full_name, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Trazas';
?>
<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?= $this->title ?></h4>

    </div>
    <div class="card-body" style="padding: 15px">

        <div class="p-3">
            <div class="table-responsive">
                <table class="table">
                    <thead class=" text-primary">
                    <tr>
                        <th> Usuario</th>
                        <th>Fecha/Hora </th>
                        <th> IP</th>
                        <th>Acción</th>
                        <th>Descripción</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php
                        foreach ($model->logs as $log){
                            ?>
                            <tr>
                               <td><?=$log->user->full_name?></td>
                               <td><?=date('d/m/Y h:i:s a',strtotime($log->action_moment))?></td>
                                <td><?=$log->ip?></td>
                                <td><?=$log->action?></td>
                                <td><?=$log->description?></td>
                            </tr>

                            <?php
                        }
                    ?>


                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
