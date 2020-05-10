<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\select2\Select2;
use kartik\depdrop\DepDrop;
use yii\helpers\Url;
/* @var $this yii\web\View */
/* @var $model app\models\Demand */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="demand-form">
    <?php $form = ActiveForm::begin(); ?>
    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'organism')->widget(Select2::classname(), [
                'data' => \app\models\Organism::combo(true),
                'id'=>'cat-id',
                'options' => ['placeholder' => 'Seleccione ...','id'=>'cat-id',],

                'pluginOptions' => [
                    'allowClear' => true
                ],
            ]);?>
        </div>
        <div class="col-md-4">
            <?= $form->field($model, 'client_id')->widget(DepDrop::classname(), [
                'type' => DepDrop::TYPE_SELECT2,

                'pluginOptions'=>[
                        'initialize'=>true,
                    'depends'=>['cat-id'],
                    'placeholder'=>'Seleccione...',
                    'url'=>Url::to(['/client/combo'])
                ]
            ]);
            ?>
        </div>
        <div class="col-md-4">
            <?= $form->field($model, 'client_contract_number')->textInput(['maxlength' => true]) ?>
        </div>


        <div class="col-md-4"></div>
        <div class="col-md-4"></div>
    </div>
    <div class="card card-stats" style="margin-bottom: 0px">
        <div class="card-header card-header-warning card-header-icon" style="padding: 5px 10px">

            <p style="text-align: center;color: white; font-weight: bold;margin-bottom: 0px">Requerimientos</p>

        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4" style="text-align: left">
                    <?= $form->field($model, 'payment_method_id')->widget(Select2::classname(), [
                        'data' => \app\models\PaymentMethod::combo(),
                        'options' => [
                                'placeholder' => 'Seleccione ...',
                             'options' => \app\models\PaymentMethod::extraData(),

                            'id'=>'payment_method'
                        ],

                        'pluginEvents'=>[
                            "select2:select" => "function(el,val) { validar('payment_method');createTooltips(el.params.data.id) }",
                        ]
                    ]);?>
                    <div id="details-payment_method" class="hidden">
                        <?= $form->field($model, 'other_execution')->textarea(['rows' => 2])->label('Especifique') ?>
                    </div>

                </div>
                <div class="col-md-4" style="text-align: left">
                    <?= $form->field($model, 'deployment_part_id')->widget(Select2::classname(), [
                        'data' => \app\models\DeploymentPart::combo(),
                        'options' => ['placeholder' => 'Seleccione ...','id'=>'deployment_parts'],
                        'pluginEvents'=>[
                            "change" => "function(el) { validar('deployment_parts') }",
                        ]

                    ]);?>
                    <div class="<?=$model->payment_method_id!=\app\models\DeploymentPart::OTRO_ID?'hidden':''?>" id="details-deployment_parts"  >
                        <?= $form->field($model, 'other_deploy')->textarea(['rows' => 2])->label('Especifique') ?>
                    </div>

                </div>
                <div class="col-md-4" style="text-align: left">
                    <?=$form->field($model, 'waranty_time_id')->widget(Select2::classname(), [
                        'data' => \app\models\WarrantyTime::combo(),
                        'options' => ['placeholder' => 'Seleccione ...'],
                        'pluginOptions' => [
                            'allowClear' => true
                        ],
                    ]);?>
                    <?= $form->field($model, 'warranty_specification')->textarea(['rows' => 2]) ->label('Especificaciones de la garantía')?>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <div class="stats">

            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-4">
            <?= $form->field($model, 'purchase_reason_id')->widget(Select2::classname(), [
                'data' => \app\models\PurchaseReason::combo(),
                'options' => ['placeholder' => 'Seleccione ...'],
                'pluginOptions' => [
                    'allowClear' => true
                ],
            ]);?>
        </div>
        <div class="col-md-4">
            <?= $form->field($model, 'validated_list_id')->widget(Select2::classname(), [
                'data' => \app\models\ValidatedList::combo(),
                'options' => ['placeholder' => 'Seleccione ...'],
                'pluginOptions' => [
                    'allowClear' => true
                ],
            ]);?>

        </div>
        <div class="col-md-2"></div>
    </div>
    <div class="card card-stats" style="margin-bottom: 0px">
        <div class="card-header card-header-warning card-header-icon" style="padding: 5px 10px">

            <p style="text-align: center;color: white; font-weight: bold;margin-bottom: 0px">Piezas de respuesto, Post garantía, Asistencia Técnica y Capacitación</p>

        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-5" style="text-align: left">
                    <?= $form->field($model, 'require_replacement_part')->checkbox([])?>
                    <div id="field-demand-replacement_part_details" class="<?=$model->require_replacement_part?'':"hidden"?>">
                        <?= $form->field($model, 'replacement_part_details')->textarea(['rows' => 3])
                            ->label('Cantidades, código y descripción del fabricante')
                        ?>
                    </div>


                </div>
                <div class="col-md-2"></div>
                <div class="col-md-5" style="text-align: left">


                </div>

            </div>
            <div class="row">
                <div class="col-md-5" style="text-align: left">
                    <?= $form->field($model, 'require_technic_asistance')->checkbox() ?>
                    <div id="field-require_technic_asistance" class="<?=$model->require_technic_asistance?'':"hidden"?>">
                        <?= $form->field($model, 'technic_asistance_details')->textarea(['rows' => 3]) ?>
                    </div>

                </div>
                <div class="col-md-2"></div>
                <div class="col-md-5" style="text-align: left">
                    <?= $form->field($model, 'seller_requirement_id')->widget(Select2::classname(), [
                        'data' => \app\models\SellerRequirement::combo(),
                        'options' => ['placeholder' => 'Seleccione ...'],
                        'pluginOptions' => [
                            'allowClear' => true
                        ],
                    ]);?>
                    <?= $form->field($model, 'post_warranty_details')->textarea(['rows' => 3]) ?>
                </div>

            </div>


        </div>

    </div>
    <?= $form->field($model, 'observation')->textarea(['rows' => 3]) ?>

    <div class="form-group">
        <?= Html::submitButton('Guardar y añadir productos', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
<?php
$this->registerJsFile('/js/demand/_form.js',['depends'=>\yii\web\JqueryAsset::className()]);

?>