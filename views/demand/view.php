<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\Demand */

$this->title = $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Demands', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="demand-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'client_contract_number',
            'client_id',
            'payment_method_id',
            'other_execution:ntext',
            'deployment_part_id',
            'other_deploy:ntext',
            'waranty_time_id:datetime',
            'warranty_specification:ntext',
            'purchase_reason_id',
            'require_replacement_part:boolean',
            'replacement_part_details:ntext',
            'require_post_warranty:boolean',
            'post_warranty_details:ntext',
            'require_technic_asistance:boolean',
            'technic_asistance_details:ntext',
            'created_date',
            'sending_date',
            'rejected_reason:ntext',
            'observation:ntext',
            'validated_list_id',
            'seller_requirement_id',
            'demand_status_id',
            'created_by',
        ],
    ]) ?>

</div>
