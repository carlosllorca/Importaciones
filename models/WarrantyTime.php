<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "warranty_time".
 *
 * @property int $id
 * @property string $label
 *
 * @property Demand[] $demands
 */
class WarrantyTime extends \yii\db\ActiveRecord
{
    const UN_ANNO_ID=1;
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'warranty_time';
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
            [['label'], 'required'],
            [['label'], 'string', 'max' => 250],
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
    public function getDemands()
    {
        return $this->hasMany(Demand::className(), ['waranty_time_id' => 'id']);
    }
    public static function combo(){
        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }
}
