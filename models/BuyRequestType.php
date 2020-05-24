<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "buy_request_type".
 *
 * @property int $id
 * @property string $label
 *
 * @property BuyRequest[] $buyRequests
 */
class BuyRequestType extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'buy_request_type';
    }
    static  $INTERNACIIONAL_ID= 1;
    static  $NACIONAL_ID= 2;
    static  $TYPE_711= 3;

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
            'label' => 'Label',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequests()
    {
        return $this->hasMany(BuyRequest::className(), ['buy_request_type_id' => 'id']);
    }
    /**
     * Combo tipos de solicitud de compra
     */
    public static  function combo(){
        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }
}
