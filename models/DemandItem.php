<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "demand_item".
 *
 * @property int $id
 * @property int $demand_id
 * @property int $validated_list_item_id
 * @property float $price
 * @property int $quantity
 * @property int|null $buy_request_id
 *
 * @property BuyRequest $buyRequest
 * @property Demand $demand
 * @property ValidatedListItem $validatedListItem
 */
class DemandItem extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'demand_item';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['demand_id', 'validated_list_item_id', 'price', 'quantity'], 'required'],
            [['demand_id', 'validated_list_item_id', 'quantity', 'buy_request_id'], 'default', 'value' => null],
            [['demand_id', 'validated_list_item_id', 'quantity', 'buy_request_id'], 'integer'],
            [['price'], 'number'],
            [['buy_request_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequest::className(), 'targetAttribute' => ['buy_request_id' => 'id']],
            [['demand_id'], 'exist', 'skipOnError' => true, 'targetClass' => Demand::className(), 'targetAttribute' => ['demand_id' => 'id']],
            [['validated_list_item_id'], 'exist', 'skipOnError' => true, 'targetClass' => ValidatedListItem::className(), 'targetAttribute' => ['validated_list_item_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'demand_id' => 'Demand ID',
            'validated_list_item_id' => 'Producto',
            'price' => 'Price',
            'quantity' => 'Quantity',
            'buy_request_id' => 'Buy Request ID',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequest()
    {
        return $this->hasOne(BuyRequest::className(), ['id' => 'buy_request_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDemand()
    {
        return $this->hasOne(Demand::className(), ['id' => 'demand_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getValidatedListItem()
    {
        return $this->hasOne(ValidatedListItem::className(), ['id' => 'validated_list_item_id']);
    }
}
