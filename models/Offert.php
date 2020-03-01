<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "offert".
 *
 * @property int $id
 * @property int $offert_status_id
 * @property int $upload_by
 * @property string $upload_date
 * @property string $recived_date
 * @property string $expiration_date
 * @property string $url_file
 * @property int|null $evaluated_by
 * @property string $evaluation_date
 * @property bool|null $approved
 * @property string|null $url_evaluation
 * @property bool $winner
 * @property int $buy_request_provider_id
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
            [['offert_status_id', 'upload_by', 'upload_date', 'recived_date', 'expiration_date', 'url_file', 'evaluation_date', 'winner', 'buy_request_provider_id'], 'required'],
            [['offert_status_id', 'upload_by', 'evaluated_by', 'buy_request_provider_id'], 'default', 'value' => null],
            [['offert_status_id', 'upload_by', 'evaluated_by', 'buy_request_provider_id'], 'integer'],
            [['upload_date', 'recived_date', 'expiration_date', 'evaluation_date'], 'safe'],
            [['url_file', 'url_evaluation'], 'string'],
            [['approved', 'winner'], 'boolean'],
            [['buy_request_provider_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestProvider::className(), 'targetAttribute' => ['buy_request_provider_id' => 'id']],
            [['upload_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['upload_by' => 'id']],
            [['evaluated_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['evaluated_by' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'offert_status_id' => 'Offert Status ID',
            'upload_by' => 'Upload By',
            'upload_date' => 'Upload Date',
            'recived_date' => 'Recived Date',
            'expiration_date' => 'Expiration Date',
            'url_file' => 'Url File',
            'evaluated_by' => 'Evaluated By',
            'evaluation_date' => 'Evaluation Date',
            'approved' => 'Approved',
            'url_evaluation' => 'Url Evaluation',
            'winner' => 'Winner',
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
