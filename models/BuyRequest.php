<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "buy_request".
 *
 * @property int $id
 * @property string $code
 * @property string $created
 * @property string $last_update
 * @property int $created_by
 * @property int $buy_request_status_id
 * @property string $bidding_start
 * @property string $bidding_end
 *
 * @property BuyRequestStatus $buyRequestStatus
 * @property User $createdBy
 * @property BuyRequestDocument[] $buyRequestDocuments
 * @property DemandItem[] $demandItems
 * @property Offert[] $offerts
 */
class BuyRequest extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'buy_request';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['code', 'created', 'last_update', 'created_by', 'buy_request_status_id', 'bidding_start', 'bidding_end'], 'required'],
            [['created', 'last_update', 'bidding_start', 'bidding_end'], 'safe'],
            [['created_by', 'buy_request_status_id'], 'default', 'value' => null],
            [['created_by', 'buy_request_status_id'], 'integer'],
            [['code'], 'string', 'max' => 50],
            [['buy_request_status_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestStatus::className(), 'targetAttribute' => ['buy_request_status_id' => 'id']],
            [['created_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['created_by' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'code' => 'Code',
            'created' => 'Created',
            'last_update' => 'Last Update',
            'created_by' => 'Created By',
            'buy_request_status_id' => 'Buy Request Status ID',
            'bidding_start' => 'Bidding Start',
            'bidding_end' => 'Bidding End',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestStatus()
    {
        return $this->hasOne(BuyRequestStatus::className(), ['id' => 'buy_request_status_id']);
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
    public function getBuyRequestDocuments()
    {
        return $this->hasMany(BuyRequestDocument::className(), ['buy_request_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDemandItems()
    {
        return $this->hasMany(DemandItem::className(), ['buy_request_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOfferts()
    {
        return $this->hasMany(Offert::className(), ['buy_request_id' => 'id']);
    }
}
