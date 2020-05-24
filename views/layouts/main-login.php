<?php
   use yii\helpers\Html;
   use yii\bootstrap\ActiveForm;
    use rce\material\widgets\Noti;
   rce\material\Assets::register($this);
$directoryAsset = Yii::$app->assetManager->getPublishedUrl('@vendor/ricar2ce/yii2-material-theme/assets');
   ?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
   <head>
      <meta charset="<?= Yii::$app->charset ?>"/>
      <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
      <!--     Fonts and icons     -->
      <!-- <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"> -->
       <link rel="stylesheet" href="/css/seisa.css">
       <?= Html::csrfMetaTags() ?>
      <title><?= Html::encode($this->title) ?></title>
      <?php $this->head() ?>
   </head>
   <body class="off-canvas-sidebar login-page">
      <?php $this->beginBody() ?>
      <div class="wrapper wrapper-full-page">
         <!-- <div class="login"> -->
         <div class="page-header login-page header-filter" filter-color="black" style=" background-size: cover; background-position: top center;background-color: #eee">
        <!--   you can change the color of the filter page using: data-color="blue | purple | green | orange | red | rose " -->
             <?= Noti::widget() ?>
            <div class="container">
               <?= $content ?>
            </div>
         </div>
      </div>
      <?php $this->endBody();

      ?>
   </body>
</html>
<?php $this->endPage() ?>
