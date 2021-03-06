<?php

namespace app\models;

use Codeception\Module\Cli;
use Yii;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;
use yii\behaviors\TimestampBehavior;
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
    public function rules()
    {
        return [
            [['name', 'address', 'organism_id', 'province_ueb','client_code'], 'required'],
            [['address'], 'string'],
            [['organism_id', 'province_ueb'], 'default', 'value' => null],
            [['organism_id', 'province_ueb'], 'integer'],
            [['client_code'], 'string', 'max' => 10],
            [['name'], 'string', 'max' => 100],
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
            'client_code' => 'Código de cliente',
            'name' => 'Nombre',
            'address' => 'Dirección',
            'organism_id' => 'Organismo',
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
    public static  function comboUeb(){
        $models = Client::find()->where(['province_ueb'=>Yii::$app->user->identity->province_ueb])->all();
        return ArrayHelper::map($models,'id','name');
    }
    public static function combo(){
        $models = Client::find()->all();
        return ArrayHelper::map($models,'id','name');
    }
}
