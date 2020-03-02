<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "buy_request_document".
 *
 * @property int $id
 * @property int $buy_request_id
 * @property int|null $last_updated_by
 * @property string|null $created_date
 * @property string|null $last_update
 * @property string|null $url_to_file
 * @property string|null $custom_file
 * @property int $document_type_id
 *
 * @property BuyRequest $buyRequest
 * @property DocumentType $documentType
 * @property User $lastUpdatedBy
 */
class BuyRequestDocument extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'buy_request_document';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['buy_request_id', 'document_type_id'], 'required'],
            [['buy_request_id', 'last_updated_by', 'document_type_id'], 'default', 'value' => null],
            [['buy_request_id', 'last_updated_by', 'document_type_id'], 'integer'],
            [['created_date', 'last_update'], 'safe'],
            [['url_to_file'], 'string'],
            [['custom_file'], 'string', 'max' => 255],
            [['buy_request_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequest::className(), 'targetAttribute' => ['buy_request_id' => 'id']],
            [['document_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => DocumentType::className(), 'targetAttribute' => ['document_type_id' => 'id']],
            [['last_updated_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['last_updated_by' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'buy_request_id' => 'Buy Request ID',
            'last_updated_by' => 'Last Updated By',
            'created_date' => 'Created Date',
            'last_update' => 'Last Update',
            'url_to_file' => 'Url To File',
            'custom_file' => 'Custom File',
            'document_type_id' => 'Document Type ID',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequest()
    {
        return $this->hasOne(BuyRequest::className(), ['id' => 'buy_request_id']);
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
    public function getLastUpdatedBy()
    {
        return $this->hasOne(User::className(), ['id' => 'last_updated_by']);
    }

}
