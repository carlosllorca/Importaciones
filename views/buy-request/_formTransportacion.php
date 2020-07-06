<?php
use yii\helpers\Url;
use yii\widgets\ActiveForm;
use yii\jui\DatePicker;

/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequestInternational */
?>
<?php $form = ActiveForm::begin(
    [

        'id'=>'start-licitation-form',
       // 'action' => '/communication/save-author',
        'options' => ['class'=>'add-coauthor-form form-modal'],
        'validationUrl' => Url::toRoute('/buy-request/validate-monitoring?id='.$model->id)
    ]
); ?>
<div class="row">
    <div class="col-sm-6"><?=$form->field($model,'build_days')->textInput(['type'=>'number','min'=>1,'max'=>999])?></div>
    <div class="col-sm-6"><?=$form->field($model,'transport_days')->textInput(['type'=>'number','min'=>1,'max'=>999])?></div>
    <div class="col-sm-6"><?=$form->field($model,'credit_card_open')->widget(DatePicker::classname(), [
            'dateFormat' => 'dd-MM-yyyy',

            'options'=>['class'=>'form-control']
        ]);?></div>

    <div class="col-sm-12">
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeModal()">Cancelar</button>
            <button type="submit" data-confirm="¿Confirma que desea iniciar el cliclo de transportación?" class="btn btn-success">
                Generar
            </button>
        </div>

    </div>
</div>
<?php \yii\widgets\ActiveForm::end();?>