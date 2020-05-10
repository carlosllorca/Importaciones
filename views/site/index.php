<?php

/* @var $this yii\web\View */

$this->title = 'Página de inicio';
?>
<div class="site-index">
    <h4 class="title">
        Bienvenido, <?= Yii::$app->user->identity->full_name ?>
    </h4>
    <div class="row">
        <div class="col-md-6 p-5">
            <div class="card">
                <div class="card-header card-header-primary">

                </div>
                <div class="card-body" style="padding: 15px">
                    <div class="p-3">
                        <?= $this->render('mainChart') ?>
                    </div>
                </div>
            </div>

        </div>
        <div class="col-md-6 p-5">

            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header card-header-primary">

                        </div>
                        <div class="card-body" style="padding: 15px">
                            <div class="p-3" >
                                <?= $this->render('minChart') ?>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header card-header-primary">

                        </div>
                        <div class="card-body" style="padding: 15px">
                            <div class="p-3">
                                <?= $this->render('minChart') ?>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>

    </div>


</div>
