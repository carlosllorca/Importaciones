<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "destiny".
 *
 * @property int $id
 * @property string $label
 *
 * @property BuyRequestInternational[] $buyRequestInternationals
 */
class Destiny extends \yii\db\ActiveRecord
{
    static $HABANA_ID=1;
    static $SANTIAGO_ID=2;
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'destiny';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['label'], 'string','max'=>50],
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
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestInternationals()
    {
        return $this->hasMany(BuyRequestInternational::className(), ['destiny_id' => 'id']);
    }
    /**
     * Combo estado de las solicitudes
     */
    public static function combo(){
        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }
}
