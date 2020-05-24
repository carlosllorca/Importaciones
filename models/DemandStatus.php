<?php

namespace app\models;

use Yii;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "demand_status".
 *
 * @property int $id
 * @property string $label
 *
 * @property Demand[] $demands
 */
class DemandStatus extends \yii\db\ActiveRecord
{
    const BORRADOR_ID=1;
    const ENVIADA_ID=2;
    const ACEPTADA_ID=3;
    const RECHAZADA_ID=4;
    const CERRADA_ID=6;
    const TRAMITADA_ID=5;
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'demand_status';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['label'], 'string', 'max' => 100],
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
        return $this->hasMany(Demand::className(), ['demand_status_id' => 'id']);
    }
    public static function combo(){

        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }
}
