<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "email_notify".
 *
 * @property int $id
 * @property string $bidding_start
 * @property string $bidding_end
 * @property string $sended_date
 * @property string $body
 * @property string $attachment
 * @property int $buy_request_id
 *
 * @property BuyRequest $buyRequest
 */
class EmailNotify extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'email_notify';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['bidding_start', 'bidding_end', 'sended_date', 'body', 'attachment', 'buy_request_id'], 'required'],
            [['bidding_start', 'bidding_end', 'sended_date'], 'safe'],
            [['body'], 'string'],
            [['buy_request_id'], 'default', 'value' => null],
            [['buy_request_id'], 'integer'],
            [['attachment'], 'string', 'max' => 150],
            [['buy_request_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequest::className(), 'targetAttribute' => ['buy_request_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'bidding_start' => 'Bidding Start',
            'bidding_end' => 'Bidding End',
            'sended_date' => 'Sended Date',
            'body' => 'Body',
            'attachment' => 'Attachment',
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
}
