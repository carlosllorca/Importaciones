<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "client".
 *
 * @property int $id
 * @property string|null $client_code
 * @property string $name
 * @property string $address
 * @property int $organism_id
 * @property int $province_ueb
 *
 * @property Organism $organism
 * @property ProvinceUeb $provinceUeb
 * @property Demand[] $demands
 */
class Client extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'client';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name', 'address', 'organism_id', 'province_ueb'], 'required'],
            [['address'], 'string'],
            [['organism_id', 'province_ueb'], 'default', 'value' => null],
            [['organism_id', 'province_ueb'], 'integer'],
            [['client_code'], 'string', 'max' => 10],
            [['name'], 'string', 'max' => 150],
            [['organism_id'], 'exist', 'skipOnError' => true, 'targetClass' => Organism::className(), 'targetAttribute' => ['organism_id' => 'id']],
            [['province_ueb'], 'exist', 'skipOnError' => true, 'targetClass' => ProvinceUeb::className(), 'targetAttribute' => ['province_ueb' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'client_code' => 'Client Code',
            'name' => 'Name',
            'address' => 'Address',
            'organism_id' => 'Organism ID',
            'province_ueb' => 'Province Ueb',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOrganism()
    {
        return $this->hasOne(Organism::className(), ['id' => 'organism_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProvinceUeb()
    {
        return $this->hasOne(ProvinceUeb::className(), ['id' => 'province_ueb']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDemands()
    {
        return $this->hasMany(Demand::className(), ['client_id' => 'id']);
    }
}
