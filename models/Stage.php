<?php

namespace app\models;

use Yii;

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
            [['active'], 'boolean'],
            [['label'], 'string', 'max' => 255],
            [['order', 'buy_request_type_id'], 'unique', 'targetAttribute' => ['order', 'buy_request_type_id']],
            [['buy_request_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestType::className(), 'targetAttribute' => ['buy_request_type_id' => 'id']],
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
}
