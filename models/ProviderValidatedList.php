<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "provider_validated_list".
 *
 * @property int $id
 * @property int $provider_id
 * @property int $validated_list_id
 *
 * @property Provider $provider
 * @property ValidatedList $validatedList
 */
class ProviderValidatedList extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'provider_validated_list';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['provider_id', 'validated_list_id'], 'required'],
            [['provider_id', 'validated_list_id'], 'default', 'value' => null],
            [['provider_id', 'validated_list_id'], 'integer'],
            [['provider_id'], 'exist', 'skipOnError' => true, 'targetClass' => Provider::className(), 'targetAttribute' => ['provider_id' => 'id']],
            [['validated_list_id'], 'exist', 'skipOnError' => true, 'targetClass' => ValidatedList::className(), 'targetAttribute' => ['validated_list_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'provider_id' => 'Provider ID',
            'validated_list_id' => 'Validated List ID',
        ];
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
    public function getValidatedList()
    {
        return $this->hasOne(ValidatedList::className(), ['id' => 'validated_list_id']);
    }
}
