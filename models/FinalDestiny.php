<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "final_destiny".
 *
 * @property int $id
 * @property string $label
 * @property string $code
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
            [['label','code'], 'required'],
            [['label'], 'string', 'max' => 150],
            [['code'], 'string', 'max' => 3],
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
            'code'=> 'Código',
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
