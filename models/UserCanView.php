<?php

namespace app\models;

use Yii;
use yii\behaviors\TimestampBehavior;
use yii\db\ActiveRecord;

/**
 * This is the model class for table "user_can_view".
 *
 * @property int $id
 * @property int $user_id
 * @property int $buy_request_type_id
 * @property string $created_at
 * @property string $updated_at
 *
 * @property BuyRequestType $buyRequestType
 * @property User $user
 */
class UserCanView extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'user_can_view';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['user_id', 'buy_request_type_id', 'updated_at'], 'required'],
            [['user_id', 'buy_request_type_id'], 'default', 'value' => null],
            [['user_id', 'buy_request_type_id'], 'integer'],
            [['created_at', 'updated_at'], 'safe'],
            [['buy_request_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestType::className(), 'targetAttribute' => ['buy_request_type_id' => 'id']],
            [['user_id'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['user_id' => 'id']],
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
            'user_id' => 'User ID',
            'buy_request_type_id' => 'Buy Request Type ID',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];
    }

    /**
     * Gets query for [[BuyRequestType]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestType()
    {
        return $this->hasOne(BuyRequestType::className(), ['id' => 'buy_request_type_id']);
    }

    /**
     * Gets query for [[User]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::className(), ['id' => 'user_id']);
    }
}
