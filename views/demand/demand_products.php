<?php

use yii\bootstrap4\Modal;

/* @var $this \yii\web\View */
/* @var $model \app\models\Demand */

$this->title='Añadir productos';
Modal::begin([
    //'title' => 'Modificar pregunta',
    'id' => 'modal-update-question',
    'toggleButton' => ['label' => 'click me', 'id' => 'update-question', 'class' => 'hidden '],
]);
?>
<div id="modal-content">

</div>
<?php
Modal::end();
?>
<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?=$this->title?></h4>

    </div>
    <div class="card-body" style="padding: 15px">
        <div class="p-3">
           <p style="text-align: right">
               <?=\yii\helpers\Html::a('<span class="glyphicon glyphicon-plus"></span> Agregar producto',['/demand-item/create','vl'=>$model->id],
                   [
                       'class'=>'btn btn-success',
                       'title'=>'Agregar producto',

                   ])?>
               <?=\yii\helpers\Html::a('<i class="glyphicon glyphicon-send"></i> Enviar demanda',['send','id'=>$model->id],
                   [
                       'class'=>'btn btn-primary',
                       'title'=>'Enviar demanda',

                       'data-confirm'=>'¿Confirma que desea enviar la demanda?'
                   ])?>

           </p>

            <?php
                if($model->demandItems){
                    ?>
                    <div class="table-responsive">
                        <table class="table">
                            <thead class=" text-primary">
                            <tr>
                                <th> Item.</th>
                                <th>Producto </th>
                                <th> Descripción técnica</th>
                                <th>Homologación</th>
                                <th>UM</th>
                                <th>Cantidad</th>
                                <th>Precio</th>
                                <th>Importe</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <?php
                            $pos = 0;
                            foreach ($model->demandItems as $item){

                                ?>
                                <tr>
                                    <th><?=++$pos?>.</th>
                                    <th><?=$item->validatedListItem->product_name?> </th>
                                    <th><p><?=$item->validatedListItem->tecnic_description?></p></th>
                                    <th><?=$item->validatedListItem->certificadosStr()?></th>
                                    <th><?=$item->validatedListItem->um->label?></th>
                                    <th><?=$item->quantity?></th>
                                    <th><?=$item->price?></th>
                                    <th><?=$item->price*$item->quantity?></th>
                                    <th><?=\yii\helpers\Html::a("<span class='glyphicon glyphicon-trash'></span>",['delete-item','id'=>$item->id],['data-confirm'=>'¿Confirma que desea eliminar este producto de la demanda?'])?></th>
                                </tr>

                                <?php
                            }
                            ?>


                            </tbody>
                        </table>
                    </div>
            <?php
                }else{
                    ?>
                    <div class="row">
                        <div class="col-md-12" style="height: 500px">
                            <p style="margin-top:250px ;font-size: 20px; text-align: center; color: #cecece; font-weight: bold">
                                Aún no has añadido productos. <a class="link" href="/demand-item/create?vl=<?=$model->id?>" >Añade el primero</a>
                            </p>
                        </div>
                    </div>
                    <div >

                    </div>
                    <?php
                }
            ?>
        </div>
    </div>
</div>
