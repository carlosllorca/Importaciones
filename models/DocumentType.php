<?php

namespace app\models;
use yii\helpers\ArrayHelper;
use Yii;

/**
 * This is the model class for table "document_type".
 *
 * @property int $id
 * @property string $label
 * @property bool $required
 * @property bool $active
 *
 * @property BuyRequestDocument[] $buyRequestDocuments
 * @property DocumentTypePermission[] $documentTypePermissions
 */
class DocumentType extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    const PLIEGO_ID=1;
    const PREFORMA_ID=2;
    const FUNDAMENTACION_COMPRA_ID=3;
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
            [['required','active'], 'boolean'],
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
            'active' => 'Activo',
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
    public static function combo($differentTo=[]){
        return ArrayHelper::map(self::find()->where(['active'=>true])
            ->andWhere(['not',['id'=>$differentTo]])
            ->orderBy('label')->all(),'id','label');
    }
}
