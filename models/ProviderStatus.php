<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "provider_status".
 *
 * @property int $id
 * @property string $label
 *
 * @property BuyRequestProvider[] $buyRequestProviders
 */
class ProviderStatus extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'provider_status';
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
            'label' => 'Label',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestProviders()
    {
        return $this->hasMany(BuyRequestProvider::className(), ['provider_status_id' => 'id']);
    }
}
