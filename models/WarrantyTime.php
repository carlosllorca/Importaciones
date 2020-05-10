<?php

namespace app\models;

use Yii;
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
