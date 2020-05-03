<?php
/**
 * @var $this \yii\web\View;
 */

?>
<div class="row">
    <div class="col-sm-12" style="width: 100%;">
        <nav>
            <div class="nav nav-tabs nav-fill" role="tablist">
                <?php
                $pos = 1;
                foreach ($items as $item) {
                    if ($item['visible']) {
                        ?>
                        <a class="nav-item nav-link <?= $item['active'] ? 'active show' : null ?>"
                           id="<?= isset($item['id']) ?'tab-'.$item['id'] : 'tab-' . $pos ?>" data-toggle="tab"
                           href="<?= isset($item['id']) ? '#nav-' . $item['id'] : '#nav-' . $pos ?>" role="tab"
                           aria-controls="nav-home" aria-selected="<?= $item['active'] ? 'true  ' : null ?>"><?= $item['label'] ?></a>
                        <?php
                    }
                    $pos++;
                }
                ?>

            </div>
        </nav>
        <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
            <?php
            $pos = 1;
            foreach ($items as $item) {
                if ($item['visible']) {
                    ?>
                    <div class="tab-pane fade <?= $item['active'] ? 'active show' : null ?>"
                         id="<?= isset($item['id']) ?'nav-' . $item['id'] : 'nav-' . $pos ?>" role="tabpanel" aria-labelledby="nav-home-tab">
                        <?= $item['content'] ?>
                    </div>
                    <?php
                }
                $pos++;
            }
            ?>
        </div>

    </div>
</div>

<?php

echo $this->registerCss('nav > .nav.nav-tabs{

    border: none;
    color:#fff;
    background:white;
    border-radius:0;

}

.nav-fill{
    padding: 0px!important;
}
nav > div a.nav-item.nav-link
{
    background-color: white;!important;
    border:1px solid #f66b0d;
    padding: 10px 25px;
    font-weight: bold;

}
nav > div a.nav-item.nav-link.active
{
    border: none;

    color:#fff!important;
    background:#f66b0d;
    border-radius:0;
}
.tab-pane.fade{
    width: 100%;
}

nav > div a.nav-item.nav-link.active:after
{
    content: "";
    position: relative;
    bottom: -60px;
    left: -10%;
    border: 15px solid transparent;
    border-top-color: #e74c3c ;
}
.tab-content{
    background: #fdfdfd;
    line-height: 25px;
    border: 1px solid #ddd;
    border-top:5px solid #e74c3c;
    border-bottom:5px solid #e74c3c;
    padding:30px 25px;
}

nav > div a.nav-item.nav-link:hover,
nav > div a.nav-item.nav-link:focus
{
    border: none;
    background: #f66b0d;
    color:#fff!important;
    border-radius:0;
    transition:background 0.20s linear;
}');
?>
