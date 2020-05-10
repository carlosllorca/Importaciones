<?php

/* @var $this yii\web\View */
/* @var $name string */
/* @var $message string */
/* @var $exception Exception */

use yii\helpers\Html;

$this->title = $name;
?>
<div class="site-error">

    <h1><?= Html::encode($this->title) ?></h1>

    <div class="alert alert-danger">
        <?= nl2br(Html::encode($message)) ?>
    </div>

    <p>
       Ocurrió un error al procesar su solicitud.
    </p>
    <p>
        Si el problema persiste por favor contáctenos mediante el <a class="link" href="/site/contact"><b>Formulario de contacto</b></a>
    </p>

</div>
