<?php



/* @var $this \yii\web\View */
/* @var $model \app\models\ValidatedListItem */
?>
<div class="row">
    <div class="col-sm-4" style="">
        <p style="margin: 0px; font-weight: bold;text-align: center" >Foto</p>
        <img width="100%" src="<?=$model->picture()?>" style="border:1px solid #cecece;padding: 5px; border-radius: 3px">
    </div>
    <div class="col-sm-8" style="margin-top: 18px">
        <div class="row">
            <div class="col-sm-3"><b >Nombre:</b></div>
            <div class="col-sm-9"><p style="margin: 0px" ><?=$model->product_name?></p></div>
        </div>
        <div class="row">
            <div class="col-sm-3"><b >UM:</b></div>
            <div class="col-sm-9"><p style="text-align: justify;margin: 0px" ><?=$model->um->label?></p></div>
        </div>
        <div class="row">
            <div class="col-sm-3"><b >Precio:</b></div>
            <div class="col-sm-9"><p style="text-align: justify;margin: 0px" ><?=Yii::$app->formatter->asCurrency($model->price)?></p></div>
        </div>
        <div class="row">
            <div class="col-sm-3"><b >Homologación:</b></div>
            <div class="col-sm-9"><p style="margin: 0px" ><?=$model->certificadosStr()?></p></div>
        </div>

    </div>
</div>
<div class="row" style="margin-top: 5px">
    <div class="col-sm-12">
        <b >Descripción técnica:</b>
       <p style="text-align: justify" ><?=$model->tecnic_description?></p>
    </div>
</div>
