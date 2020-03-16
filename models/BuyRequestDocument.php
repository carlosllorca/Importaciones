<?php

namespace app\models;

use kartik\file\FileInput;
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
 * @property int $document_status_id
 * @property boolean $evaluation
 * @property FileInput $documento
 *
 * @property BuyRequest $buyRequest
 * @property DocumentStatus $documentStatus
 * @property DocumentType $documentType
 * @property User $lastUpdatedBy
 */
class BuyRequestDocument extends \yii\db\ActiveRecord
{
    public $documento;
    public $evaluation;
    const SCENARIO_CUSTOM_DOCUMENT='SECENARIO_CUSTOM_DOCUMENT';
    const SCENARIO_UPLOAD_DOCUMENT='SECENARIO_UPLOAD_DOCUMENT';
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
            [['buy_request_id','document_status_id'], 'required'],
            [['buy_request_id', 'last_updated_by', 'document_type_id'], 'default', 'value' => null],
            [['buy_request_id', 'last_updated_by', 'document_type_id'], 'integer'],
            [['evaluation'], 'boolean'],
            [['custom_file','documento'], 'required','on'=>self::SCENARIO_CUSTOM_DOCUMENT],
            [['documento'], 'required','on'=>self::SCENARIO_UPLOAD_DOCUMENT],
            [['custom_file'], 'string','max'=>50],

            [['documento'], 'file', 'skipOnEmpty' => true, 'extensions' => 'pdf,doc,docx','maxSize' => 2048*1024 ],
            [['created_date', 'last_update'], 'safe'],
            [['url_to_file'], 'string'],

            [['buy_request_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequest::className(), 'targetAttribute' => ['buy_request_id' => 'id']],
            [['document_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => DocumentType::className(), 'targetAttribute' => ['document_type_id' => 'id']],
            [['last_updated_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['last_updated_by' => 'id']],
        ];
    }
    /*
     * Subir fichero
     */
    public function upload()
    {
        $name = Yii::$app->security->generateRandomString().'.'.$this->documento->extension;
        $this->documento->saveAs('request_files/' .$name);
        return '/request_files/' .$name;

    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'buy_request_id' => 'Buy Request ID',
            'last_updated_by' => 'Actualizado por',
            'created_date' => 'Creado',
            'last_update' => 'Última actualización',
            'evaluation' => '¿Evaluación positiva?',
            'url_to_file' => 'URL',
            'custom_file' => 'Nombre del archivo',

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
    public function getDocumentStatus()
    {
        return $this->hasOne(DocumentStatus::className(), ['id' => 'document_status_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getLastUpdatedBy()
    {
        return $this->hasOne(User::className(), ['id' => 'last_updated_by']);
    }

}
