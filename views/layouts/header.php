<?php
use yii\helpers\Html;

/* @var $this \yii\web\View */
/* @var $content string */
?>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top " style="background-color: #fff!important;">
    <div class="container-fluid">
        <div class="navbar-wrapper">
            <a class="navbar-brand" href="/">AIGCL-SEISA</a>
        </div>
        <button class="navbar-toggler" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
            <span class="sr-only">Toggle navigation</span>
            <span class="navbar-toggler-icon icon-bar"></span>
            <span class="navbar-toggler-icon icon-bar"></span>
            <span class="navbar-toggler-icon icon-bar"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end">


            <ul class="navbar-nav">


                <li class="nav-item dropdown" >
                    <a class="nav-link" href="#" id="navbarDropdownProfile" data-toggle="dropdown" aria-expanded="false">
                        <i class="material-icons">person</i>
                        <p class="d-lg-none d-md-block">
                            Account
                        </p>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right ocultar" id="cont-user"  aria-labelledby="navbarDropdownProfile">
                        <a class="dropdown-item" href="/user/my-account">Mi cuenta</a>
                        <a class="dropdown-item" href="/site/contact">Reportar un problema</a>

                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" style="padding: 0;">
                            <?php
                            echo Html::beginForm(['/site/logout'], 'post');
                            echo Html::submitButton(
                                'Salir (' . Yii::$app->user->identity->username . ')',
                                ['class' => 'btn btn-link logout']
                            );
                            echo Html::endForm();
                            ?>
                        </a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- End Navbar -->
