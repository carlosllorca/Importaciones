<?php



/* @var $this \yii\web\View */
/* @var $permission string */
/* @var $section string */
/* @var $title string */
?>
<li class="<?= \app\controllers\MainController::determineActive($section) ?>">
    <a href="/<?=$section?>/index"
       class="<?= Yii::$app->user->can("{$permission}/index") ? null : 'hidden' ?>" style="margin:0px 0px 0px 40px; padding: 5px 0px 5px 10px"
       title="Title"><?=$title?></a>
</li>
