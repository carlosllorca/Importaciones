<?php

namespace app\models;

use Yii;
use kartik\file\FileInput;
/**
 * This is the model class for table "offert".
 *
 * @property int $id

 * @property int $upload_by
 * @property string $upload_date

 * @property string $expiration_date
 * @property string $url_file
 * @property int|null $evaluated_by
 * @property string $evaluation_date
 * @property bool|null $approved
 * @property string|null $url_evaluation
 * @property bool $winner
 * @property int $buy_request_provider_id
 * @property FileInput $oferta
 * @property FileInput $evaluacion
 *
 * @property BuyRequestProvider $buyRequestProvider
 * @property User $uploadBy
 * @property User $evaluatedBy
 */
class Offert extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    static $SCENARIO_EVALUATE_OFFERT='evaluate_offert';
    static $SCENARIO_UPLOAD_OFFERT='upload_offert';
    public $oferta;
    public $evaluacion;
    public static function tableName()
    {
        return 'offert';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [[ 'upload_by', 'upload_date', 'expiration_date', 'url_file', 'buy_request_provider_id'], 'required'],
            [[ 'upload_by', 'evaluated_by', 'buy_request_provider_id'], 'default', 'value' => null],
            [['upload_by', 'evaluated_by', 'buy_request_provider_id'], 'integer'],
            [['oferta'], 'file', 'skipOnEmpty' => true, 'extensions' => 'xls,xlsx','maxSize' => 2048*1024 ],
            [['evaluacion'], 'file', 'skipOnEmpty' => true, 'extensions' => 'doc,docx,pdf','maxSize' => 2048*1024 ],
            ['oferta','required','on'=>self::$SCENARIO_UPLOAD_OFFERT],
            [['approved','evaluacion'],'required','on'=>self::$SCENARIO_EVALUATE_OFFERT],
            [['upload_date', 'expiration_date', 'evaluation_date'], 'safe'],
            [['url_file', 'url_evaluation'], 'string'],
            [['approved', 'winner'], 'boolean'],
            [['oferta','evaluacion'], 'uploadFileRequired'],
            [['buy_request_provider_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestProvider::className(), 'targetAttribute' => ['buy_request_provider_id' => 'id']],
            [['upload_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['upload_by' => 'id']],
            [['evaluated_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['evaluated_by' => 'id']],
        ];
    }
    public function uploadFileRequired($attribute){
        if(!$this->transference_file){
            $this->addError($attribute,'Por favor adjunte una oferta.');
        }
    }
    /*
     * Subir fichero
     */
    public function upload()
    {
        $name = Yii::$app->security->generateRandomString().'.'.$this->oferta->extension;
        $this->oferta->saveAs('offerts/' .$name);
        return '/offerts/' .$name;

    }
    /**
    * Subir evaluacion
    */
    public function uploadEvaluation()
    {
        $name = Yii::$app->security->generateRandomString().'.'.$this->evaluacion->extension;
        $this->evaluacion->saveAs('evaluations/' .$name);
        return '/evaluations/' .$name;

    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',

            'upload_by' => 'Subido por',
            'upload_date' => 'Fecha de creación',

            'expiration_date' => 'Expira',
            'url_file' => 'Url File',
            'evaluated_by' => 'Evaluado por',
            'evaluation_date' => 'Fecha Evaluación',
            'approved' => '¿Evaluación positiva?',
            'url_evaluation' => 'Url Evaluation',
            'winner' => 'Ganador',
            'buy_request_provider_id' => 'Buy Request Provider ID',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestProvider()
    {
        return $this->hasOne(BuyRequestProvider::className(), ['id' => 'buy_request_provider_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUploadBy()
    {
        return $this->hasOne(User::className(), ['id' => 'upload_by']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getEvaluatedBy()
    {
        return $this->hasOne(User::className(), ['id' => 'evaluated_by']);
    }
}
