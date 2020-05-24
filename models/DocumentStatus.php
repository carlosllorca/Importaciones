<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;

/**
 * This is the model class for table "document_status".
 *
 * @property int $id
 * @property string $label
 *
 * @property BuyRequestDocument[] $buyRequestDocuments
 */
class DocumentStatus extends \yii\db\ActiveRecord
{
    static $PENDIENTE_ID =1;
    static $APROBADO_ID =2;
    static $RECHAZADO_ID =3;

    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'document_status';
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
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['label'], 'string'],
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
    public function getBuyRequestDocuments()
    {
        return $this->hasMany(BuyRequestDocument::className(), ['document_status_id' => 'id']);
    }
    public function classByStatus(){
    switch ($this->id){
        case self::$PENDIENTE_ID:
        return 'text-warning text-uppercase';
            break;
        case self::$APROBADO_ID:
            return 'text-success text-uppercase';
            break;
        case self::$RECHAZADO_ID:
            return 'text-danger text-uppercase';
            break;
        default:
            return '';
            break;
    }
}
}
