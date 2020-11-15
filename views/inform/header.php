<?php
/**
 * @var $title string
 */
use yii\helpers\Url;
?>
<div class="row" >
    <div class="col-2" style="border-right: 1px solid #f66b0d;">
        <img src="img/SEISA.png" hspace="3" vspace="3" style="float: right;width:95%;margin: 5px"/>
    </div>
    <div class="col-10" style="">

        <h3 style=" margin: 0px;padding-left: 10px; text-transform: uppercase"><?=$title?></h3>
        <h5 style="margin: 0px;padding-left: 10px;font-style: italic ;color:#f66b0d; "><?= Yii::$app->params['siteName'] ?></h5>
        <h5 style="margin: 0px;padding-left: 10px;font-style: italic ;color:#f66b0d; ">
            <a style="color: #f66b0d;" href="<?= Url::home('http') ?>"><?= Url::home('http') ?></a>
        </h5>
    </div>
</div>
<div class="row" style="margin-bottom: 20px">
    <div class="col-6">
        <p style="text-align: center"><b>Desde:</b> <i style="text-decoration: underline"><?=$date_start?></i></p>
    </div>
    <div class="col-6">
        <p style="text-align: center"><b>Hasta:</b> <i style="text-decoration: underline"><?=$date_end?></i></p>
    </div>
</div>