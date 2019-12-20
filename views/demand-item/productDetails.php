<?php



/* @var $this \yii\web\View */
/* @var $mdodel \app\models\ValidatedListItem|null */
?>
<div class="row">
    <div class="col-md-8" style="margin: auto">
        <label>Nombre del producto:</label><br>
        <b class="title"><?=$mdodel->product_name?></b>
    </div>

    <div class="col-md-8" style="margin: auto">
        <div class="row">
                <div class="col-md-12">
                    <label>Descripción técnica:</label><br>
                    <b class="title"><?=$mdodel->tecnic_description?></b>
                </div>
                <div class="col-md-4">
                    <label>Homologación:</label><br>
                    <b class="title"><?=$mdodel->certificadosStr()?></b>
                </div>
                <div class="col-md-4">
                    <label>Precio:</label><br>
                    <b class="title"><?=$mdodel->price?></b>
                </div>
                <div class="col-md-4">
                    <label>Unidad de medida:</label><br>
                    <b class="title"><?=$mdodel->um->label?></b>
                </div>
        </div>
    </div>

</div>
