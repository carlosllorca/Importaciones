<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;
use yii\behaviors\TimestampBehavior;
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
