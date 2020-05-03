<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
/**
 * This is the model class for table "request_stage".
 *
 * @property int $id
 * @property string $date_created
 * @property string $date_start
 * @property string $date_end
 * @property string $nextHitoDate;
 * @property string|null $real_end
 * @property int $stage_id
 * @property int $buy_request_id
 * @property string $details
 *
 * @property BuyRequest $buyRequest
 * @property Stage $stage
 */

class RequestStage extends ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'request_stage';
    }
    public $nextHitoDate;

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['date_created', 'date_start', 'date_end', 'stage_id', 'buy_request_id'], 'required'],
            [['date_created', 'date_start', 'date_end', 'real_end'], 'safe'],
            [['stage_id', 'buy_request_id'], 'default', 'value' => null],
            [['stage_id', 'buy_request_id'], 'integer'],
            [['details','nextHitoDate'], 'string'],
            [['buy_request_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequest::className(), 'targetAttribute' => ['buy_request_id' => 'id']],
            [['stage_id'], 'exist', 'skipOnError' => true, 'targetClass' => Stage::className(), 'targetAttribute' => ['stage_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'date_created' => 'Fecha creado',
            'date_start' => 'Fecha inicio',
            'date_end' => 'Fecha Fin',
            'real_end' => 'Cumplido',
            'details' => 'Observaciones',
            'nextHitoDate' => 'Fecha de inicio del próximo hito',
            'stage_id' => 'Stage ID',
            'buy_request_id' => 'Buy Request ID',
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
    public function getStage()
    {
        return $this->hasOne(Stage::className(), ['id' => 'stage_id']);
    }

    /**
     * Devuelve el siguiente hito
     * @return RequestStage|bool
     */
    public function nextHito(){
        $model = self::find()->where(['buy_request_id'=>$this->buy_request_id])
            ->innerJoinWith('stage')
            ->andWhere(['stage.order'=>($this->stage->order+1)])
            ->one();
        if($model)
            return $model;
        else
            return false;
    }

}
