<?php

namespace app\models;

use Yii;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "buy_request_status".
 *
 * @property int $id
 * @property string $label
 *
 * @property BuyRequest[] $buyRequests
 */
class BuyRequestStatus extends \yii\db\ActiveRecord
{
    static $BORRADOR_ID=1;
    static $SIN_TRAMITAR_ID=2;
    static $CANCELADA_ID=3;
    static $LICITANDO=4;
    static $EVALUANDO_OFERTAS=5;
    static $EN_PROCESO=6;
    static $CERRADA=7;


    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'buy_request_status';
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
    public function getBuyRequests()
    {
        return $this->hasMany(BuyRequest::className(), ['buy_request_status_id' => 'id']);
    }
    /**
     * Combo estado de las solicitudes
     */
    public static function combo(){
        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }
}
