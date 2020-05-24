<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "document_type_permission".
 *
 * @property int $id
 * @property int $document_type_id
 * @property bool $allow_view
 * @property bool $allow_update
 * @property int $user_id
 *
 * @property DocumentType $documentType
 * @property User $user
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
            [['document_type_id', 'user_id'], 'required'],
            [['document_type_id', 'user_id'], 'default', 'value' => null],
            [['document_type_id', 'user_id'], 'integer'],
            [['allow_view', 'allow_update'], 'boolean'],
            [['document_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => DocumentType::className(), 'targetAttribute' => ['document_type_id' => 'id']],
            [['user_id'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['user_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'document_type_id' => 'Tipo de documento',
            'allow_view' => 'Puede visualizar el documento.',
            'allow_update' => 'Puede modificar el documento.',
            'user_id' => 'User ID',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDocumentType()
    {
        return $this->hasOne(DocumentType::className(), ['id' => 'document_type_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::className(), ['id' => 'user_id']);
    }
}
