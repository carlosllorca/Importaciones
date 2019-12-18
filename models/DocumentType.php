<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "document_type".
 *
 * @property int $id
 * @property string $label
 * @property bool $required
 *
 * @property BuyRequestDocument[] $buyRequestDocuments
 * @property DocumentTypePermission[] $documentTypePermissions
 */
class DocumentType extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'document_type';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['required'], 'boolean'],
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
            'label' => 'Nombre',
            'required' => 'Requerido',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestDocuments()
    {
        return $this->hasMany(BuyRequestDocument::className(), ['document_type_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDocumentTypePermissions()
    {
        return $this->hasMany(DocumentTypePermission::className(), ['document_type_id' => 'id']);
    }
    public static function combo(){
        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }
}
