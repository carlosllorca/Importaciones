<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;
/**
 * This is the model class for table "demand_item".
 *
 * @property int $id
 * @property int $demand_id
 * @property int $validated_list_item_id
 * @property float $price
 * @property int $quantity
 * @property int|null $buy_request_id
 * @property boolean $internal_distribution
 * @property boolean $cancelled
 * @property string $cancelled_msg
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
            [['internal_distribution','cancelled'], 'boolean'],
            [['quantity'], 'integer','min'=>0],
            ['cancelled_msg','string', 'max'=>150],
            [['buy_request_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequest::className(), 'targetAttribute' => ['buy_request_id' => 'id']],
            [['demand_id'], 'exist', 'skipOnError' => true, 'targetClass' => Demand::className(), 'targetAttribute' => ['demand_id' => 'id']],
            [['validated_list_item_id'], 'exist', 'skipOnError' => true, 'targetClass' => ValidatedListItem::className(), 'targetAttribute' => ['validated_list_item_id' => 'id']],
        ];
    }
    /**
     * Setea la información de la última modificación de la tupla.
     * @return array|array[]
     */
    public function behaviors()
    {
        return [
            [
                'class' => TimestampBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['created_at','updated_at'],
                    ActiveRecord::EVENT_BEFORE_UPDATE => ['updated_at'],

                ],
                'value' => date('Y-m-d H:i:s'),
            ],
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
            'price' => 'Precio',
            'quantity' => 'Cantidad',
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
    public function status($withHtml=false){
        if($this->internal_distribution){
            return $withHtml?"<b class='text-success' >Distribución interna</b>":"Distribución interna";
        }elseif ($this->cancelled){
            return $withHtml?"<b class='text-gray'>Cancelado. {$this->cancelled_msg}</b>":$this->cancelled_msg;

        }
        elseif ($this->buy_request_id){
            return $withHtml?"<b class='text-success'>{$this->buyRequest->code}</b>":$this->buyRequest->code;

        }else{
            return $withHtml?"<b class='text-danger'>Sin clasificar</b>":"Sin clasificar";
        }

    }
}
