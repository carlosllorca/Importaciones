<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\User */
/* @var $form yii\widgets\ActiveForm */

if (!$model->isNewRecord) {
    echo $this->render('_addPermDocForm', ['model' => $newPerm, 'user' => $model]);
    ?>

    <!-- Modal -->
    <div class="modal fade" style="margin-top: 20%" id="update-file-access-modal" tabindex="-1" role="dialog"
         aria-labelledby="Seleccionar ganadores" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">

            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Actualizar acceso a tipo de documento</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="update-access-file-data">
                </div>
            </div>
        </div>
    </div>
    <?php


}
?>

<div class="user-form">
    <?php $form = ActiveForm::begin(); ?>
    <div class="row">
        <div class="col-md-12">
            <p style="text-align: center" class="title"><b>Datos Generales</b></p>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-6 col-md-4">
            <?= $form->field($model, 'username')->textInput(['maxlength' => true, 'disabled' => !$model->isNewRecord]) ?>
        </div>
        <div class="col-sm-6 col-md-4">
            <?= $form->field($model, 'full_name')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-sm-6 col-md-4">
            <?= $form->field($model, 'email')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-sm-6 col-md-4">
            <?= $form->field($model, 'cargo')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-sm-6 col-md-4">
            <?= $form->field($model, 'phone_number')->textInput(['maxlength' => true]) ?>
        </div>


        <div class="col-sm-6 col-md-4">
            <?= $form->field($model, 'rol')->dropDownList(\app\models\Rbac::comboRoles()) ?>
        </div>
        <?php
        if ($model->isNewRecord) {
            ?>
            <div class="col-sm-6 col-md-4">
                <?= $form->field($model, 'password')->passwordInput() ?>
            </div>
            <div class="col-sm-6 col-md-4">
                <?= $form->field($model, 'confirm_password')->passwordInput() ?>
            </div>
            <?php
        }
        ?>


        <div class="col-sm-6 col-md-4" id="ueb" class="<?= $model->rol != \app\models\Rbac::$UEB ? "" : "hidden" ?>">
            <?= $form->field($model, 'province_ueb')->dropDownList(\app\models\ProvinceUeb::combo(), ['prompt' => 'Seleccione']) ?>
        </div>
    </div>
    <?php
    if (!$model->isNewRecord) {
        ?>
        <div class="row">
            <div class="col-md-12">
                <p style="text-align: center" class="title"><b>Acceso a tipos de documentos</b></p>
            </div>
            <?php
            if ($model->documentTypePermissions) {
                $p = 1;
                ?>
                <div class="col-sm-12">
                    <?php
                    if (Yii::$app->user->can('user/addfileaccess')) {
                        ?>

                        <p><?= Html::a('Añadir permiso',
                                '#',
                                [
                                    'class' => 'btn btn-primary',

                                    'data-toggle' => "modal",
                                    'data-target' => "#add-file-access-modal"
                                ]) ?></p>
                        <?php
                    }
                    ?>
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>No.</th>
                            <th>Documento</th>
                            <th>Puede ver</th>
                            <th>Puede modificar</th>
                            <th></th>


                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        foreach ($model->activesDocumentTypePermission() as $documentTypePermission) {
                            ?>
                            <tr>
                                <th><?= $p++ ?></th>
                                <th><?= $documentTypePermission->documentType->label ?></th>
                                <th><?= Yii::$app->formatter->asBoolean($documentTypePermission->allow_view) ?></th>
                                <th><?= Yii::$app->formatter->asBoolean($documentTypePermission->allow_update) ?></th>
                                <th>
                                    <?php
                                    if (Yii::$app->user->can('user/updatedocumentaccess')) {
                                        echo Html::a("<span class='glyphicon glyphicon-pencil'></span>", '#',
                                            [
                                                'title' => 'Actualizar el acceso al documento',
                                                'onclick'=>"loadUpdateAccess({$documentTypePermission->id})",
                                                'data-toggle' => "modal",
                                                'data-target' => "#update-file-access-modal"
                                            ]);
                                    }
                                    if (Yii::$app->user->can('user/deletedocumentaccess')) {
                                        echo Html::a("<span class='glyphicon glyphicon-trash'></span>", ['delete-document-access', 'id' => $documentTypePermission->id],
                                            ['title' => 'Eliminar el acceso al documento', 'data-confirm' => '¿Está seguro que desea eliminar el acceso al documento para este usuario?']);
                                    }
                                    ?>
                                </th>


                            </tr>
                            <?php
                        }
                        ?>
                        </tbody>
                    </table>

                </div>
                <?php
            } else {
                ?>
                <div class="col-md-12">
                    <p style="padding: 20px;padding-bottom: 0px;margin-bottom: 0px; font-weight: bold;color: #cecece;text-align: center">
                        Este usuario no tiene acceso a ningún documento.
                        <?php
                        if (Yii::$app->user->can('user/addfileaccess')){
                        ?>

                    <p style="text-align: center"><?= Html::a('<b>Añadir permiso</b>',
                            '#',
                            [
                                'class' => 'link',
                                'data-toggle' => "modal",
                                'data-target' => "#add-file-access-modal"
                            ]) ?></p>
                    <?php
                    }
                    ?>

                    </p>


                </div>
                <?php
            }
            ?>
        </div>

        <?php
    }
    ?>


    <div class="form-group">
        <?= Html::submitButton('Guardar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
<?php
$this->registerJsFile('/js/user/_form.js', ['depends' => \yii\web\JqueryAsset::className()]);
?>
