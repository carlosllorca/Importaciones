<?php

namespace app\models;
use yii\helpers\ArrayHelper;
use Yii;

/**
 * This is the model class for table "payment_method".
 *
 * @property int $id
 * @property string $label
 * @property string $description
 * @property boolean $active
 *
 * @property Demand[] $demands
 */
class PaymentMethod extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    const OTRO_ID=5;
    public static function tableName()
    {
        return 'payment_method';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label','active'], 'required'],
            [['label'], 'string', 'max' => 150],
            [['description'], 'string'],
            [['active'], 'boolean'],
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
            'description' => 'Descripción',
            'active' => 'Activo',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDemands()
    {
        return $this->hasMany(Demand::className(), ['payment_method_id' => 'id']);
    }
    public static function combo(){
        return ArrayHelper::map(self::find()->where(['active'=>true])->orderBy('label')->all(),'id','label');
    }
}
