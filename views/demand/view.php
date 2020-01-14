<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\Demand */

$this->title = "Detalles de la demanda";
$this->params['breadcrumbs'][] = ['label' => 'Demandas', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>

<div class="buy-request-status-index">

    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?=$this->title?></h4>
            <p class="card-category">Estados por los que transita una oferta</p>
        </div>
        <div class="card-body" style="padding: 15px">

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
    </div>
</div>
