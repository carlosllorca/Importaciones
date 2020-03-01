<?php

namespace app\models;

use Yii;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "buy_condition".
 *
 * @property int $id
 * @property string $label
 *
 * @property BuyRequest[] $buyRequests
 */
class BuyCondition extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'buy_condition';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['label'], 'string','max'=>15],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'label' => 'Label',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequests()
    {
        return $this->hasMany(BuyRequest::className(), ['buy_condition_id' => 'id']);
    }
    /**
     * Combo estado de las solicitudes
     */
    public static function combo(){
        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }

}
