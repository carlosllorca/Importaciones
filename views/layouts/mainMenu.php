<?php
/**
 * @var $this \yii\web\View
 */

use app\models\Rbac;

?>

<div class="sidebar" data-color="purple" data-background-color="white">
    <!--
      Tip 1: You can change the color of the sidebar using: data-color="purple | azure | green | orange | danger"

      Tip 2: you can also add an image using data-image tag
  -->
    <div class="logo">
        <a href="/" class="simple-text logo-normal">
            <?=\yii\helpers\Html::img('/img/SEISA.png',['width'=>'60%'])?>
        </a>
    </div>
    <div class="sidebar-wrapper">
        <ul class="nav">
            <li class="<?= \app\controllers\MainController::determineActive('site') ?>">
                <a class="nav-link" href="/">
                    <i class="material-icons">dashboard</i>
                    <p>Inicio</p>
                </a>
            </li>
            <?php
            if(Yii::$app->user->can('demand/index')){
                ?>
                <li class="<?= \app\controllers\MainController::determineActive('demand') ?>">
                    <a class="nav-link" href="/demand/index">
                        <i class="material-icons">content_paste</i>
                        <p>Demandas</p>
                    </a>
                </li>
                <?php

            }
            if(Yii::$app->user->can('buyrequest/index')){
                ?>
                <li class="<?= \app\controllers\MainController::determineActive('buy-request') ?>">
                    <a class="nav-link" href="/buy-request/index">
                        <i class="material-icons">inbox</i>
                        <p>Solicitudes de compra</p>
                    </a>
                </li>
                <?php

            }
            if(Yii::$app->user->can('client/index')){
                ?>
                <li class="<?= \app\controllers\MainController::determineActive('client') ?>">
                    <a class="nav-link" href="/client/index">
                        <i class="material-icons">contacts</i>
                        <p>Clientes</p>
                    </a>
                </li>
                <?php

            }
            if (Yii::$app->user->can('provider/index')) {
                ?>
                <li class="<?= \app\controllers\MainController::determineActive('provider') ?>">
                    <a class="nav-link" href="/provider/index">
                        <i class="material-icons">group</i>
                        <p>Proveedores</p>
                    </a>
                </li>
                <?php

            }

            ?>



            <?php
                if(Yii::$app->user->can('provinceueb/index')){
                    ?>
                    <li class="<?= \app\controllers\MainController::determineActive('province-ueb') ?>">
                        <a class="nav-link" href="/province-ueb/index">
                            <i class="material-icons">home</i>
                            <p>UEB</p>
                        </a>
                    </li>
                    <?php

                }
            ?>
            <?php
                if(Yii::$app->user->can('validatedlist/index')){
                    ?>
                    <li class="<?= \app\controllers\MainController::determineActive('validated-list') ?><?= \app\controllers\MainController::determineActive('validated-list-item') ?>">
                        <a class="nav-link" href="/validated-list/index">
                            <i class="material-icons">shopping_cart</i>
                            <p>Listados validados</p>
                        </a>
                    </li>
                    <?php

                }
            ?>


            <li>
                <a class="pointer <?= Rbac::getRole() != Rbac::$ROOT ? 'hidden' : '' ?>" data-toggle="collapse"
                   data-target="#submenu1">
                    <i class="material-icons">dashboard</i>
                    <p>Nomencladores</p>
                </a>
                <ul class="nav nav-list  mt-0 submenus  <?= \app\controllers\MainController::determineExpand('nomencaladores') ?>"
                    id="submenu1">
                    <?=$this->render('menu-item',['permission'=>'buyrequeststatus','section'=>'buy-request-status','title'=>'Estado solicitud de compra'])?>
                    <?=$this->render('menu-item',['permission'=>'buyrequesttype','section'=>'buy-request-type','title'=>'Tipos de Solicitud de compra'])?>
                    <?=$this->render('menu-item',['permission'=>'certification','section'=>'certification','title'=>'Certificados'])?>
                    <?=$this->render('menu-item',['permission'=>'certificationtype','section'=>'certification-type','title'=>'Categorías de Certificados'])?>
                    <?=$this->render('menu-item',['permission'=>'country','section'=>'country','title'=>'Paises'])?>
                    <?=$this->render('menu-item',['permission'=>'demandstatus','section'=>'demand-status','title'=>'Estado demanda'])?>
                    <?=$this->render('menu-item',['permission'=>'deploymentpart','section'=>'deployment-part','title'=>'Partes de entrega'])?>
                    <?=$this->render('menu-item',['permission'=>'documenttype','section'=>'document-type','title'=>'Tipo de documento'])?>
                    <?=$this->render('menu-item',['permission'=>'providerstatus','section'=>'provider-status','title'=>'Estado del proveedor'])?>
                    <?=$this->render('menu-item',['permission'=>'organism','section'=>'organism','title'=>'Organismo'])?>
                    <?=$this->render('menu-item',['permission'=>'paymentmethod','section'=>'payment-method','title'=>'Método de pago'])?>
                    <?=$this->render('menu-item',['permission'=>'purchasereason','section'=>'purchase-reason','title'=>'Motivo de la compra'])?>
                    <?=$this->render('menu-item',['permission'=>'stage','section'=>'stage','title'=>'Hito'])?>
                    <?=$this->render('menu-item',['permission'=>'sellerrequirement','section'=>'seller-requirement','title'=>'Rquerimiento del vendedor'])?>
                    <?=$this->render('menu-item',['permission'=>'um','section'=>'um','title'=>'Unidad de medida'])?>
                    <?=$this->render('menu-item',['permission'=>'warrantytime','section'=>'warranty-time','title'=>'Tiempo de garantía'])?>
                    <?=$this->render('menu-item',['permission'=>'buycondition','section'=>'buy-condition','title'=>'Condición de compra'])?>
                    <?=$this->render('menu-item',['permission'=>'destiny','section'=>'destiny','title'=>'Destino'])?>
                    <?=$this->render('menu-item',['permission'=>'paymentinstrument','section'=>'payment-instrument','title'=>'Instrumento de pago'])?>







                </ul>
            </li>
            <?php
            if (Yii::$app->user->can('manage/rbac')) {
                ?>
                <li class="<?= \app\controllers\MainController::determineActiveAction('manage', 'rbac') ?> ">
                    <a href="/manage/rbac">
                        <i class="material-icons">security</i>
                        <p>Roles y permisos</p>
                    </a>
                </li>
                <?php
            }
            ?>

            <?php
            if (Yii::$app->user->can('user/index')) {
                ?>
                <li class="<?= \app\controllers\MainController::determineActive('user') ?> ">
                    <a href="/user/index">
                        <i class="material-icons">group</i>
                        <p>Usuarios</p>
                    </a>
                </li>
                <?php
            }
            ?>


        </ul>
    </div>
</div>

