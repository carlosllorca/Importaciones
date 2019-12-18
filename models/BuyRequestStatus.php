<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "buy_request_status".
 *
 * @property int $id
 * @property string $label
 *
 * @property BuyRequest[] $buyRequests
 */
class BuyRequestStatus extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'buy_request_status';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['label'], 'string', 'max' => 50],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'label' => 'Nombre',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequests()
    {
        return $this->hasMany(BuyRequest::className(), ['buy_request_status_id' => 'id']);
    }
}
