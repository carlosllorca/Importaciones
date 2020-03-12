<?php
use yii\helpers\Url;
use yii\widgets\ActiveForm;

/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequestInternational */
?>
<?php $form = ActiveForm::begin(
    [
        'enableAjaxValidation' => true,
        'validateOnSubmit' => true,
        'id'=>'add-coauthor-form',
        //'action' => '/communication/save-author',
        'options' => ['class'=>'add-coauthor-form form-modal'],
        'validationUrl' => Url::toRoute('/buy-request/validate-monitoring?id='.$model->id)
    ]
); ?>
<div class="row">
    <div class="col-sm-6"><?=$form->field($model,'transport_days')->textInput(['type'=>'number','min'=>1,'max'=>999])?></div>
    <div class="col-sm-6"><?=$form->field($model,'build_days')->textInput(['type'=>'number','min'=>1,'max'=>999])?></div>
    <div class="col-sm-12">
        <div class="button-container">
            <?=\yii\helpers\Html::submitButton('Generar',['class'=>'btn btn-success','data-confirm'=>'¿Confirma que desea iniciar el ciclo de transportación para esta orden?'])?>
        </div>
    </div>
</div>
<?php \yii\widgets\ActiveForm::end();?>