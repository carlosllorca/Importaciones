<?php
use yii\widgets\ActiveForm;
use yii\helpers\Html;
use yii\helpers\Url;


/* @var $this \yii\web\View */
/* @var $model \app\models\ChangePasswordForm */
$form = ActiveForm::begin(['id' => 'change_password',
    'enableAjaxValidation' => true,
    'validateOnSubmit' => true,
    'validationUrl' => Url::toRoute('user/validate-password')
    ]);
?>
<div class="row">
    <div class="col-sm-12">
        <?= $form->field($model, 'password')->textInput(['type'=>'password'])->label('Contraseña') ?>
    </div>
    <div class="col-sm-12">
        <?= $form->field($model, 'confirm_password')->textInput(['type'=>'password'])->label('Confirmr contraseña') ?>
    </div>
</div>
<div class="form-group">
    <?= Html::submitButton('Cambiar contraseña', ['class' => 'btn btn-success']) ?>

</div>

<?php ActiveForm::end(); ?>
<?php
$this->registerJsFile('@web/js/user/changePassword.js',['depends'=>\yii\web\JqueryAsset::className()])
?>

