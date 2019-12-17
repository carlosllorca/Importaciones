<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "user".
 *
 * @property int $id
 * @property string $username
 * @property string $full_name
 * @property string $email
 * @property string $password
 * @property string $created_at
 * @property string|null $last_login
 * @property int|null $province_ueb
 *
 * @property BuyRequest[] $buyRequests
 * @property BuyRequestDocument[] $buyRequestDocuments
 * @property Demand[] $demands
 * @property Log[] $logs
 * @property Offert[] $offerts
 * @property Offert[] $offerts0
 * @property ProvinceUeb $provinceUeb
 */
class User extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'user';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['username', 'full_name', 'email', 'password', 'created_at'], 'required'],
            [['created_at', 'last_login'], 'safe'],
            [['province_ueb'], 'default', 'value' => null],
            [['province_ueb'], 'integer'],
            [['username'], 'string', 'max' => 50],
            [['full_name'], 'string', 'max' => 200],
            [['email'], 'string', 'max' => 150],
            [['password'], 'string', 'max' => 100],
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
            'username' => 'Username',
            'full_name' => 'Full Name',
            'email' => 'Email',
            'password' => 'Password',
            'created_at' => 'Created At',
            'last_login' => 'Last Login',
            'province_ueb' => 'Province Ueb',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequests()
    {
        return $this->hasMany(BuyRequest::className(), ['created_by' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestDocuments()
    {
        return $this->hasMany(BuyRequestDocument::className(), ['last_updated_by' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDemands()
    {
        return $this->hasMany(Demand::className(), ['created_by' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getLogs()
    {
        return $this->hasMany(Log::className(), ['user_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOfferts()
    {
        return $this->hasMany(Offert::className(), ['upload_by' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOfferts0()
    {
        return $this->hasMany(Offert::className(), ['evaluated_by' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProvinceUeb()
    {
        return $this->hasOne(ProvinceUeb::className(), ['id' => 'province_ueb']);
    }
}
