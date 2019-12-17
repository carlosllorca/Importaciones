<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "document_type_permission".
 *
 * @property int $id
 * @property int $document_type_id
 * @property string $role
 * @property bool $allow_view
 * @property bool $allow_update
 *
 * @property DocumentType $documentType
 */
class DocumentTypePermission extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'document_type_permission';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['document_type_id', 'role'], 'required'],
            [['document_type_id'], 'default', 'value' => null],
            [['document_type_id'], 'integer'],
            [['allow_view', 'allow_update'], 'boolean'],
            [['role'], 'string', 'max' => 150],
            [['document_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => DocumentType::className(), 'targetAttribute' => ['document_type_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'document_type_id' => 'Document Type ID',
            'role' => 'Role',
            'allow_view' => 'Allow View',
            'allow_update' => 'Allow Update',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDocumentType()
    {
        return $this->hasOne(DocumentType::className(), ['id' => 'document_type_id']);
    }
}
