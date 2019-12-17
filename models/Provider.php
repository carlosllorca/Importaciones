<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "provider".
 *
 * @property int $id
 * @property string $name
 * @property int $country_id
 * @property string $address
 * @property bool $active
 * @property string $contact_name
 * @property string $contact_email
 *
 * @property Country $country
 * @property ProviderValidatedList[] $providerValidatedLists
 */
class Provider extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'provider';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name', 'country_id', 'address', 'contact_name', 'contact_email'], 'required'],
            [['name', 'address', 'contact_name', 'contact_email'], 'string'],
            [['country_id'], 'default', 'value' => null],
            [['country_id'], 'integer'],
            [['active'], 'boolean'],
            [['country_id'], 'exist', 'skipOnError' => true, 'targetClass' => Country::className(), 'targetAttribute' => ['country_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Name',
            'country_id' => 'Country ID',
            'address' => 'Address',
            'active' => 'Active',
            'contact_name' => 'Contact Name',
            'contact_email' => 'Contact Email',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCountry()
    {
        return $this->hasOne(Country::className(), ['id' => 'country_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProviderValidatedLists()
    {
        return $this->hasMany(ProviderValidatedList::className(), ['provider_id' => 'id']);
    }
}
