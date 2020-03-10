<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "stage".
 *
 * @property int $id
 * @property int $label
 * @property int $order
 * @property int $buy_request_type_id
 * @property bool $active
 *
 * @property RequestStage[] $requestStages
 * @property BuyRequestType $buyRequestType
 */
class Stage extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'stage';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label', 'order', 'buy_request_type_id'], 'required'],
            [['label', 'order', 'buy_request_type_id'], 'default', 'value' => null],
            [['label', 'order', 'buy_request_type_id'], 'integer'],
            [['active'], 'boolean'],
            [['order', 'buy_request_type_id'], 'unique', 'targetAttribute' => ['order', 'buy_request_type_id']],
            [['buy_request_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestType::className(), 'targetAttribute' => ['buy_request_type_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'label' => 'Label',
            'order' => 'Order',
            'buy_request_type_id' => 'Buy Request Type ID',
            'active' => 'Active',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getRequestStages()
    {
        return $this->hasMany(RequestStage::className(), ['stage_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestType()
    {
        return $this->hasOne(BuyRequestType::className(), ['id' => 'buy_request_type_id']);
    }
}
