<?php
use yii\widgets\ActiveForm;
use yii\helpers\Html;
use app\models\ProvinceUeb;
/* @var $this \yii\web\View */
/* @var $model \app\models\User|bool|false */
$this->title="Mi cuenta";
?>

<div class="buy-request-status-index">
    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?=$this->title?></h4>
            <p class="card-category">Gestiona la información del usuario.</p>
        </div>
        <div class="card-body" style="padding: 15px">
            <?php $form = ActiveForm::begin(['id' => 'user_form']); ?>
            <div class="row">
                <div class="col-sm-4">
                    <?= $form->field($model, 'username')->textInput(['disabled'=>true]) ?>
                </div>
                <div class="col-sm-4">
                    <?= $form->field($model, 'full_name')->textInput() ?>
                </div>
                <div class="col-sm-4">
                    <?= $form->field($model, 'cargo')->textInput() ?>
                </div>
                <div class="col-sm-4">
                    <?= $form->field($model, 'email')->textInput(['type'=>'email']) ?>
                </div>
                <div class="col-sm-4">
                    <?= $form->field($model, 'phone_number')->textInput(['type'=>'phonenumber']) ?>
                </div>
                <div class="col-sm-4">
                    <?= $form->field($model, 'province_ueb')->dropDownList(\app\models\ProvinceUeb::combo(), ['prompt' => 'Seleccione',
                        'disabled'=>true, ]) ?>
                </div>
                <div class="col-sm-4">
                    <?= $form->field($model, 'rol')->dropDownList(\app\models\Rbac::comboRoles(),['disabled'=>true]) ?>
                </div>
            </div>
            <div class="form-group">
                <?= Html::submitButton('Guardar', ['class' => 'btn btn-success']) ?>
                <?= Html::button('Cambiar contraseña',
                    [
                            'class' => 'btn btn-primary',
                        'onClick'=>'changePassword()'
                        ]) ?>
            </div>

            <?php ActiveForm::end(); ?>
        </div>
    </div>
</div>
<?php
$this->registerJsFile('@web/js/user/changePassword.js',['depends'=>\yii\web\JqueryAsset::className()])
?>

