<?php

namespace app\models;

use Yii;

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
}
