<?php

use yii\helpers\Html;

/* @var $this \yii\web\View view component instance */
/* @var $message \yii\mail\MessageInterface the message being composed */
/* @var $content string main view render result */
?>
<?php $this->beginPage() ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=<?= Yii::$app->charset ?>"/>
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
</head>
<body>
<?php $this->beginBody() ?>
<div style="width: 100%; padding:20px">
    <div style="width:100%; display: flex">
        <div style="max-width: 25%; border-right: 1px solid #f1691c;padding-right: 5px;margin-right: 5px">
            <img src="<?=$message->embed('img/SEISA.png')?>" style="max-height: 80px;max-width: 100%"  alt=""/>
        </div>
        <div style="width: 75%">
            <h2>
                Servicios de Seguridad Integral
            </h2>
            <b style="font-style: italic; color:#f1691c;">Sistema para la gestión del ciclo logístico.</b>

        </div>
    </div>
    <div style="width: 100%;min-height: 200px">
        <?= $content ?>
    </div>

    <div class="footer">
        <img src="<?=$message->embed('img/SEISA.png')?>" style="max-height: 40px;max-width: 100%"  alt=""/>


        <p style="margin:0px">
            SEISA: Sociedad Mercantil de capital 100% cubano que brinda Servicios de Seguridad Integral, de Sistemas contra Incendios e Intrusos.<br>
            <a class="link" href="http://www.seisa.cu">www.seisa.cu</a>;
            <a class="link" href="mailto:negocios@seisa.cu">negocios@seisa.cu</a><br>
            <a class="link" href="tel:+53772045092">(+53) 772045092</a><br>

            <b style="font-weight: bold;font-style: italic">... con toda seguridad.</b>
        </p>
    </div>
</div>

<?php $this->endBody() ?>
</body>
</html>

<?php
$this->registerCss("
.title{
    font-size:20px;
}
.content{
    font-size:18px;
}
.title{
    width:100%;
    text-align:center;
    font-weight:bold;
    font-size:24px;
}
.link{
     color:#f1691c;
     font-weight:bold
}
.footer{
    margin-top:50px;
    padding-top:15px;
    border-top: 1px solid #f1691c;
    margin-right:10%;
    margin-left:10%;   
   
    text-align:center;
    }
    h2{
        color:#f1691c;
        margin:0px
    }
    table {
  border-collapse: collapse;
  width:95%;
  border-spacing: 0;
}
thead{
background-color:#f66b0d;
color:#fff
}
th{
padding:10px;
text-align:left;
font-size:18px
}
td{
padding:10px;
font-size:15px
}


");
$this->endPage() ?>
