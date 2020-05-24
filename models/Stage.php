<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;
/**
 * This is the model class for table "stage".
 *
 * @property int $id
 * @property string $label
 * @property int $order
 * @property int $duration
 * @property int $buy_request_type_id
 * @property bool $active
 *
 * @property RequestStage[] $requestStages
 * @property BuyRequestType $buyRequestType
 */
class Stage extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'stage';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label', 'order', 'buy_request_type_id'], 'required'],
            [['order', 'buy_request_type_id'], 'default', 'value' => null],
            [['order', 'buy_request_type_id','duration'], 'integer'],
            [['order','duration'],'integer','min'=>0],
            [['active'], 'boolean'],
            [['label'], 'string', 'max' => 255],
            [['order', 'buy_request_type_id'], 'unique', 'targetAttribute' => ['order', 'buy_request_type_id']],
            [['buy_request_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestType::className(), 'targetAttribute' => ['buy_request_type_id' => 'id']],
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
            'order' => 'Orden',
            'buy_request_type_id' => 'Tipo de solicitud',
            'active' => 'Activo',
            'duration' => 'Duración',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getRequestStages()
    {
        return $this->hasMany(RequestStage::className(), ['stage_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestType()
    {
        return $this->hasOne(BuyRequestType::className(), ['id' => 'buy_request_type_id']);
    }

    /**
     * @param $orderType
     * @return Stage[]|array|\yii\db\ActiveRecord[]
     */
    public static function getStagesByOrderType($orderType){
        return self::find()->where(['active'=>true])->andWhere(['buy_request_type_id'=>$orderType])->orderBy('order ASC')->all();

    }
}
