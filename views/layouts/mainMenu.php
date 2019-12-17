<?php
/**
 * @var $this \yii\web\View
 */
?>

    <div class="sidebar" data-color="purple" data-background-color="white" >
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
                <li class="nav-item active ">
                    <a class="nav-link" href="./dashboard.html">
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
                <li class="nav-item ">
                    <a class="nav-link" href="./icons.html">
                        <i class="material-icons">bubble_chart</i>
                        <p>Nomencladores</p>
                    </a>
                </li>
                <?php
                if(Yii::$app->user->can('manage/rbac')) {
                    ?>
                    <li class="<?=\app\controllers\MainController::determineActiveAction('manage','rbac')?> ">
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

