<?php

use app\models\Rbac;

$menu = $img = "";
$config = new rce\material\Config();
if (class_exists('common\models\Menu')) {
    // advence template
    $menu = common\models\Menu::getMenu();
    // echo $menu;die;
}

?>
<div class="sidebar" data-color="<?= $config::sidebarColor() ?>"
     data-background-color="<?= $config::sidebarBackgroundColor() ?>">
    <div class="logo">

        <a href="/" class="simple-text logo-normal">
            <?= $config::siteTitle() ?>
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
            if (Yii::$app->user->can('demand/index')) {
                ?>
                <li class="<?= \app\controllers\MainController::determineActive('demand') ?>">
                    <a class="nav-link" href="/demand/index">
                        <i class="material-icons">content_paste</i>
                        <p>Demandas</p>
                    </a>
                </li>
                <?php

            }
            if (Yii::$app->user->can('buyrequest/index')) {
                ?>
                <li class="<?= \app\controllers\MainController::determineActive('buy-request') ?>">
                    <a class="nav-link" href="/buy-request/index">
                        <i class="material-icons">inbox</i>
                        <p>Solicitudes de compra</p>
                    </a>
                </li>
                <?php

            }
            if (Yii::$app->user->can('client/index')) {
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
            if (Yii::$app->user->can('manage/rbac')) {
                ?>
                <li class=" <?= \app\controllers\MainController::determineActiveAction('manage', 'rbac') ?> ">
                    <a class="nav-link" href="/manage/rbac">
                        <i class="material-icons">security</i>
                        <p>Control de acceso</p>
                    </a>
                </li>
                <?php
            }
            ?>
            <?php
            if (Rbac::getRole()==Rbac::$ROOT) {
                ?>
                <li class=" <?= \app\controllers\MainController::determineActive('default') ?> ">
                    <a class="nav-link" href="/db-manager">
                        <i class="material-icons">restore</i>
                        <p>Salvas y restauras</p>
                    </a>
                </li>
                <?php
            }
            ?>
            <?php
            if (Yii::$app->user->can('validatedlist/index')) {
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


            <?php
            if (Yii::$app->user->can('user/index')) {
                ?>
                <li class="<?= \app\controllers\MainController::determineActive('user') ?> ">
                    <a class="nav-link" href="/user/index">
                        <i class="material-icons">group</i>
                        <p>Usuarios</p>
                    </a>
                </li>
                <?php
            }
            ?>
            <?php

            if (\app\models\User::userLogged()->allowNomenclador()) {
                ?>
                <li>
                    <a class=" nav-link pointer"
                       data-toggle="collapse"
                       data-target="#submenu1">
                        <i class="material-icons">dashboard</i>
                        <p>Nomencladores</p>
                    </a>
                    <ul class="nav nav-list  mt-0 submenus  <?= \app\controllers\MainController::determineExpand('nomencaladores') ?>"
                        id="submenu1">
                        <?= $this->render('menu-item', ['permission' => 'certificationtype', 'section' => 'certification-type', 'title' => 'Categorías de Certificados']) ?>
                        <?= $this->render('menu-item', ['permission' => 'certification', 'section' => 'certification', 'title' => 'Certificados']) ?>
                        <?= $this->render('menu-item', ['permission' => 'buycondition', 'section' => 'buy-condition', 'title' => 'Condiciónes de compra']) ?>
                        <?= $this->render('menu-item', ['permission' => 'destiny', 'section' => 'destiny', 'title' => 'Destinos']) ?>
                        <?= $this->render('menu-item', ['permission' => 'finaldestiny', 'section' => 'final-destiny', 'title' => 'Destinos finales 711']) ?>
                        <?= $this->render('menu-item', ['permission' => 'providerstatus', 'section' => 'provider-status', 'title' => 'Estado proveedores']) ?>
                        <?= $this->render('menu-item', ['permission' => 'demandstatus', 'section' => 'demand-status', 'title' => 'Estados demandas']) ?>
                        <?= $this->render('menu-item', ['permission' => 'buyrequeststatus', 'section' => 'buy-request-status', 'title' => 'Estados solicitudes de compra']) ?>
                        <?= $this->render('menu-item', ['permission' => 'documentstatus', 'section' => 'document-status', 'title' => 'Estados de documentos']) ?>
                        <?= $this->render('menu-item', ['permission' => 'stage', 'section' => 'stage', 'title' => 'Hitos']) ?>
                        <?= $this->render('menu-item', ['permission' => 'paymentinstrument', 'section' => 'payment-instrument', 'title' => 'Instrumentos de pago']) ?>
                        <?= $this->render('menu-item', ['permission' => 'paymentmethod', 'section' => 'payment-method', 'title' => 'Métodos de pago']) ?>
                        <?= $this->render('menu-item', ['permission' => 'purchasereason', 'section' => 'purchase-reason', 'title' => 'Motivos de la compra']) ?>
                        <?= $this->render('menu-item', ['permission' => 'organism', 'section' => 'organism', 'title' => 'Organismo']) ?>
                        <?= $this->render('menu-item', ['permission' => 'country', 'section' => 'country', 'title' => 'Paises']) ?>
                        <?= $this->render('menu-item', ['permission' => 'deploymentpart', 'section' => 'deployment-part', 'title' => 'Partes de entrega']) ?>
                        <?= $this->render('menu-item', ['permission' => 'sellerrequirement', 'section' => 'seller-requirement', 'title' => 'Requerimientos de vendedor']) ?>
                        <?= $this->render('menu-item', ['permission' => 'warrantytime', 'section' => 'warranty-time', 'title' => 'Tiempos de garantía']) ?>
                        <?= $this->render('menu-item', ['permission' => 'documenttype', 'section' => 'document-type', 'title' => 'Tipos de documentos']) ?>
                        <?= $this->render('menu-item', ['permission' => 'buyrequesttype', 'section' => 'buy-request-type', 'title' => 'Tipos de Solicitudes de compra']) ?>
                        <?= $this->render('menu-item', ['permission' => 'um', 'section' => 'um', 'title' => 'Unidades de medida']) ?>
                        <?= $this->render('menu-item', ['permission' => 'provinceueb', 'section' => 'province-ueb', 'title' => 'UEB']) ?>
                    </ul>
                </li>
                <?php
            }
            if (Yii::$app->user->can('inform/index')) {
                ?>
                <li class="<?= \app\controllers\MainController::determineActive('inform') ?>">
                    <a class="nav-link" href="/inform/index">
                        <i class="material-icons">dvr</i>
                        <p>Informes</p>
                    </a>
                </li>
                <?php

            }
            ?>


        </ul>
    </div>
    <div class="sidebar-background" style="background-image: url(<?= $img ?>) "></div>
</div>
