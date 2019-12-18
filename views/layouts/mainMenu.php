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
            SEISA
        </a>
    </div>
    <div class="sidebar-wrapper">
        <ul class="nav">
            <li class="<?= \app\controllers\MainController::determineActive('site') ?>">
                <a class="nav-link" href="/">
                    <i class="material-icons">dashboard</i>
                    <p>Página principal</p>
                </a>
            </li>
            <li class="nav-item  ">
                <a class="nav-link" href="./user.html">
                    <i class="material-icons">person</i>
                    <p>Perfil de usuario</p>
                </a>
            </li>
            <li class="nav-item ">
                <a class="nav-link" href="./tables.html">
                    <i class="material-icons">content_paste</i>
                    <p>___</p>
                </a>
            </li>
            <li class="nav-item ">
                <a class="nav-link" href="./typography.html">
                    <i class="material-icons">library_books</i>
                    <p>__</p>
                </a>
            </li>

            <li class="nav-item ">
                <a class="nav-link" href="./map.html">
                    <i class="material-icons">location_ons</i>
                    <p>__</p>
                </a>
            </li>
            <li class="nav-item ">
                <a class="nav-link" href="./notifications.html">
                    <i class="material-icons">notifications</i>
                    <p>__</p>
                </a>
            </li>
            <li class="nav-item ">
                <a class="nav-link" href="./rtl.html">
                    <i class="material-icons">language</i>
                    <p>___</p>
                </a>
            </li>

            <li>
                <a class="pointer <?= Rbac::getRole() != Rbac::$ROOT ? 'hidden' : '' ?>" data-toggle="collapse"
                   data-target="#submenu1">
                    <i class="material-icons">dashboard</i>
                    <p>Nomencladores</p>
                </a>
                <ul class="nav nav-list  mt-0 submenus  <?= \app\controllers\MainController::determineExpand('nomencaladores') ?>"
                    id="submenu1">
                    <?=$this->render('menu-item',['permission'=>'buyrequeststatus','section'=>'buy-request-status','title'=>'Estado solicitud de compra'])?>
                    <?=$this->render('menu-item',['permission'=>'certification','section'=>'certification','title'=>'Certificados'])?>
                    <?=$this->render('menu-item',['permission'=>'certificationtype','section'=>'certificationtype','title'=>'Categorías de Certificados'])?>
                    <?=$this->render('menu-item',['permission'=>'country','section'=>'country','title'=>'Paises'])?>
                    <?=$this->render('menu-item',['permission'=>'demandstatus','section'=>'demand-status','title'=>'Estado demanda'])?>
                    <?=$this->render('menu-item',['permission'=>'deploymentpart','section'=>'deployment-part','title'=>'Partes de entrega'])?>
                    <?=$this->render('menu-item',['permission'=>'documenttype','section'=>'document-type','title'=>'Tipo de documento'])?>
                    <?=$this->render('menu-item',['permission'=>'offertstatus','section'=>'offert-status','title'=>'Estado de oferta'])?>
                    <?=$this->render('menu-item',['permission'=>'organism','section'=>'organism','title'=>'Organismo'])?>
                    <?=$this->render('menu-item',['permission'=>'paymentmethod','section'=>'payment-method','title'=>'Método de pago'])?>
                    <?=$this->render('menu-item',['permission'=>'purchasereson','section'=>'purchase-reason','title'=>'Motivo de la compra'])?>
                    <?=$this->render('menu-item',['permission'=>'stage','section'=>'stage','title'=>'Hito'])?>
                    <?=$this->render('menu-item',['permission'=>'um','section'=>'um','title'=>'Unidad de medida'])?>
                    <?=$this->render('menu-item',['permission'=>'warrantytime','section'=>'warranty-time','title'=>'Tiempo de garantía'])?>







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

        </ul>
    </div>
</div>

