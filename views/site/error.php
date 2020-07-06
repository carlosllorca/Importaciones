<?php

/* @var $this yii\web\View */
/* @var $name string */
/* @var $message string */
/* @var $exception Exception */

use yii\helpers\Html;

$this->title = \app\controllers\SiteController::handleErrorCode($exception->statusCode);
?>

<div class="card">
    <div class="card-header card-header-danger">
        <h4 class="card-title"><?=$this->title?></h4>

    </div>
    <div class="card-body" style="padding: 15px">
        <div class="p-3">
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
    </div>
</div>
