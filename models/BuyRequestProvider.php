<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "buy_request_provider".
 *
 * @property int $id
 * @property int $buy_request_id
 * @property int $provider_id
 * @property int $provider_status_id
 * @property boolean $winner
 *
 * @property BuyRequest $buyRequest
 * @property Provider $provider
 * @property ProviderStatus $providerStatus
 * @property Offert[] $offerts
 * @property Offert $approvedOffert
 */
class BuyRequestProvider extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'buy_request_provider';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['buy_request_id', 'provider_id', 'provider_status_id'], 'required'],
            [['buy_request_id', 'provider_id', 'provider_status_id'], 'default', 'value' => null],
            [['buy_request_id', 'provider_id', 'provider_status_id'], 'integer'],
            ['winner','boolean'],
            [['buy_request_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequest::className(), 'targetAttribute' => ['buy_request_id' => 'id']],
            [['provider_id'], 'exist', 'skipOnError' => true, 'targetClass' => Provider::className(), 'targetAttribute' => ['provider_id' => 'id']],
            [['provider_status_id'], 'exist', 'skipOnError' => true, 'targetClass' => ProviderStatus::className(), 'targetAttribute' => ['provider_status_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'buy_request_id' => 'Buy Request ID',
            'provider_id' => 'Provider ID',
            'provider_status_id' => 'Provider Status ID',
            'winner' => 'Ganador',
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
    public function getProvider()
    {
        return $this->hasOne(Provider::className(), ['id' => 'provider_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProviderStatus()
    {
        return $this->hasOne(ProviderStatus::className(), ['id' => 'provider_status_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOfferts()
    {
        return $this->hasMany(Offert::className(), ['buy_request_provider_id' => 'id']);
    }
    /**
     * @return \yii\db\ActiveQuery
     */
    public function getApprovedOffert()
    {
        return $this->hasOne(Offert::className(), ['buy_request_provider_id' => 'id'])->where(['offert.approved'=>true]);
    }

}
