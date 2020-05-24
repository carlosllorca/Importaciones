<?php
use yii\widgets\ActiveForm;


/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest711 */
?>
<div class="form">
    <?php
    $form= ActiveForm::begin(['id'=>'form-presentar'])
    ?>
    <div class="row">
        <div class="col-sm-12">
            <?=$form->field($model,'seguiment_date')->textInput(['type'=>'date'])?>



        </div>
    </div>
    <div class="modal-footer">
        <?=\yii\helpers\Html::submitButton('Genenrar',[
                'class'=>'btn btn-primary'
        ])?>
    </div>
    <?php
    ActiveForm::end();
    ?>
</div>
