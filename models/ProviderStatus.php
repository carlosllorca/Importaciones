<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;

/**
 * This is the model class for table "provider_status".
 *
 * @property int $id
 * @property string $label
 *
 * @property BuyRequestProvider[] $buyRequestProviders
 */
class ProviderStatus extends \yii\db\ActiveRecord
{
    static $SOLICITUD_ENVIADA_ID=1;
    static $OFERTA_RECIBIDA_ID=2;
    static $OFERTA_APROBADA_ID=3;
    static $OFERTA_RECHAZADA_ID=4;

    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'provider_status';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['label'], 'string', 'max' => 50],
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
    public function getBuyRequestProviders()
    {
        return $this->hasMany(BuyRequestProvider::className(), ['provider_status_id' => 'id']);
    }
}
