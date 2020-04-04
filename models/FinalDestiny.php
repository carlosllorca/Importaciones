<?php

namespace app\models;

use Yii;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "final_destiny".
 *
 * @property int $id
 * @property string $label
 *
 * @property BuyRequest711[] $buyRequest711s
 */
class FinalDestiny extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'final_destiny';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['label'], 'string', 'max' => 150],
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
     * Gets query for [[BuyRequest711s]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequest711s()
    {
        return $this->hasMany(BuyRequest711::className(), ['final_destiny_id' => 'id']);
    }
    public static function combo(){
        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }
}
