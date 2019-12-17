<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "demand".
 *
 * @property int $id
 * @property string $client_contract_number
 * @property int $client_id
 * @property int $payment_method_id
 * @property string|null $other_execution
 * @property int $deployment_part_id
 * @property string|null $other_deploy
 * @property int $waranty_time_id
 * @property string|null $warranty_specification
 * @property int $purchase_reason_id
 * @property bool|null $require_replacement_part
 * @property string|null $replacement_part_details
 * @property bool|null $require_post_warranty
 * @property string|null $post_warranty_details
 * @property bool|null $require_technic_asistance
 * @property string|null $technic_asistance_details
 * @property string $created_date
 * @property string|null $sending_date
 * @property string|null $rejected_reason
 * @property string|null $observation
 * @property int $validated_list_id
 * @property int $seller_requirement_id
 * @property int $demand_status_id
 * @property int $created_by
 *
 * @property Client $client
 * @property DemandStatus $demandStatus
 * @property DeploymentPart $deploymentPart
 * @property PaymentMethod $paymentMethod
 * @property PurchaseReason $purchaseReason
 * @property User $createdBy
 * @property ValidatedList $validatedList
 * @property WarrantyTime $warantyTime
 * @property DemandItem[] $demandItems
 */
class Demand extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'demand';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['client_contract_number', 'client_id', 'payment_method_id', 'deployment_part_id', 'waranty_time_id', 'purchase_reason_id', 'created_date', 'validated_list_id', 'seller_requirement_id', 'demand_status_id', 'created_by'], 'required'],
            [['client_id', 'payment_method_id', 'deployment_part_id', 'waranty_time_id', 'purchase_reason_id', 'validated_list_id', 'seller_requirement_id', 'demand_status_id', 'created_by'], 'default', 'value' => null],
            [['client_id', 'payment_method_id', 'deployment_part_id', 'waranty_time_id', 'purchase_reason_id', 'validated_list_id', 'seller_requirement_id', 'demand_status_id', 'created_by'], 'integer'],
            [['other_execution', 'other_deploy', 'warranty_specification', 'replacement_part_details', 'post_warranty_details', 'technic_asistance_details', 'rejected_reason', 'observation'], 'string'],
            [['require_replacement_part', 'require_post_warranty', 'require_technic_asistance'], 'boolean'],
            [['created_date', 'sending_date'], 'safe'],
            [['client_contract_number'], 'string', 'max' => 50],
            [['client_id'], 'exist', 'skipOnError' => true, 'targetClass' => Client::className(), 'targetAttribute' => ['client_id' => 'id']],
            [['demand_status_id'], 'exist', 'skipOnError' => true, 'targetClass' => DemandStatus::className(), 'targetAttribute' => ['demand_status_id' => 'id']],
            [['deployment_part_id'], 'exist', 'skipOnError' => true, 'targetClass' => DeploymentPart::className(), 'targetAttribute' => ['deployment_part_id' => 'id']],
            [['payment_method_id'], 'exist', 'skipOnError' => true, 'targetClass' => PaymentMethod::className(), 'targetAttribute' => ['payment_method_id' => 'id']],
            [['purchase_reason_id'], 'exist', 'skipOnError' => true, 'targetClass' => PurchaseReason::className(), 'targetAttribute' => ['purchase_reason_id' => 'id']],
            [['created_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['created_by' => 'id']],
            [['validated_list_id'], 'exist', 'skipOnError' => true, 'targetClass' => ValidatedList::className(), 'targetAttribute' => ['validated_list_id' => 'id']],
            [['waranty_time_id'], 'exist', 'skipOnError' => true, 'targetClass' => WarrantyTime::className(), 'targetAttribute' => ['waranty_time_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'client_contract_number' => 'Client Contract Number',
            'client_id' => 'Client ID',
            'payment_method_id' => 'Payment Method ID',
            'other_execution' => 'Other Execution',
            'deployment_part_id' => 'Deployment Part ID',
            'other_deploy' => 'Other Deploy',
            'waranty_time_id' => 'Waranty Time ID',
            'warranty_specification' => 'Warranty Specification',
            'purchase_reason_id' => 'Purchase Reason ID',
            'require_replacement_part' => 'Require Replacement Part',
            'replacement_part_details' => 'Replacement Part Details',
            'require_post_warranty' => 'Require Post Warranty',
            'post_warranty_details' => 'Post Warranty Details',
            'require_technic_asistance' => 'Require Technic Asistance',
            'technic_asistance_details' => 'Technic Asistance Details',
            'created_date' => 'Created Date',
            'sending_date' => 'Sending Date',
            'rejected_reason' => 'Rejected Reason',
            'observation' => 'Observation',
            'validated_list_id' => 'Validated List ID',
            'seller_requirement_id' => 'Seller Requirement ID',
            'demand_status_id' => 'Demand Status ID',
            'created_by' => 'Created By',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getClient()
    {
        return $this->hasOne(Client::className(), ['id' => 'client_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDemandStatus()
    {
        return $this->hasOne(DemandStatus::className(), ['id' => 'demand_status_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDeploymentPart()
    {
        return $this->hasOne(DeploymentPart::className(), ['id' => 'deployment_part_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPaymentMethod()
    {
        return $this->hasOne(PaymentMethod::className(), ['id' => 'payment_method_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPurchaseReason()
    {
        return $this->hasOne(PurchaseReason::className(), ['id' => 'purchase_reason_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCreatedBy()
    {
        return $this->hasOne(User::className(), ['id' => 'created_by']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getValidatedList()
    {
        return $this->hasOne(ValidatedList::className(), ['id' => 'validated_list_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getWarantyTime()
    {
        return $this->hasOne(WarrantyTime::className(), ['id' => 'waranty_time_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDemandItems()
    {
        return $this->hasMany(DemandItem::className(), ['demand_id' => 'id']);
    }
}
