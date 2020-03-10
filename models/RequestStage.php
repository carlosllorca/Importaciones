<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "request_stage".
 *
 * @property int $id
 * @property string $date_created
 * @property string $date_start
 * @property string $date_end
 * @property string|null $real_end
 * @property int $stage_id
 * @property int $buy_request_id
 *
 * @property BuyRequest $buyRequest
 * @property Stage $stage
 */
class RequestStage extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'request_stage';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['date_created', 'date_start', 'date_end', 'stage_id', 'buy_request_id'], 'required'],
            [['date_created', 'date_start', 'date_end', 'real_end'], 'safe'],
            [['stage_id', 'buy_request_id'], 'default', 'value' => null],
            [['stage_id', 'buy_request_id'], 'integer'],
            [['buy_request_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequest::className(), 'targetAttribute' => ['buy_request_id' => 'id']],
            [['stage_id'], 'exist', 'skipOnError' => true, 'targetClass' => Stage::className(), 'targetAttribute' => ['stage_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'date_created' => 'Date Created',
            'date_start' => 'Date Start',
            'date_end' => 'Date End',
            'real_end' => 'Real End',
            'stage_id' => 'Stage ID',
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
    public function getStage()
    {
        return $this->hasOne(Stage::className(), ['id' => 'stage_id']);
    }
}
