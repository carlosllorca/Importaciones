<?php



/* @var $this \yii\web\View */

use app\models\User;
use miloschuman\highcharts\Highcharts;
?>

<div class="site-index">

    <div class="row">
        <div class="col-sm-12" style="margin: auto">
            <div class="card" style="min-height: 80vh">
                <div class="card-header card-header-primary">
                    <b> Estado de la actividad</b>
                </div>
                <div class="card-body" style="padding: 15px">
                    <div class="row">
                        <div class="<?=User::userCanViewOrder(\app\models\BuyRequestType::$INTERNACIIONAL_ID)?'col-sm-9':'col-sm-3'?>">
                            <?= $this->render('graficas/buyer_solicitudes_x_tipo_x_estado');?>
                        </div>
                        <?php
                            if(User::userCanViewOrder(\app\models\BuyRequestType::$INTERNACIIONAL_ID)){
                                ?>
                                <div class="col-sm-3">
                                    <?=$this->render('graficas/buyer_licitaciones_activas')?>
                                </div>
                                <?php
                            }
                        ?>

                        <div class="col-sm-12">
                            <?=$this->render('graficas/buyer_hitos_activos')?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
