<?php

namespace app\models;

use Yii;
use yii\db\Exception;
use yii\helpers\ArrayHelper;
use yii\web\ForbiddenHttpException;

/**
 * This is the model class for table "buy_request".
 *
 * @property int $id
 * @property string $code
 * @property string $created
 * @property string $last_update
 * @property int $created_by
 * @property int $buy_request_status_id
 * @property string $bidding_start
 * @property string $bidding_end
 * @property int $buy_request_type_id
 *
 * @property BuyRequestStatus $buyRequestStatus
 * @property BuyRequestType $buyRequestType
 * @property User $createdBy
 * @property BuyRequestDocument[] $buyRequestDocuments
 * @property DemandItem[] $demandItems
 * @property Offert[] $offerts
 */
class BuyRequest extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'buy_request';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['code', 'created', 'created_by', 'buy_request_status_id', 'buy_request_type_id'], 'required'],
            [['created', 'last_update', 'bidding_start', 'bidding_end'], 'safe'],
            [['created_by', 'buy_request_status_id', 'buy_request_type_id'], 'default', 'value' => null],
            [['created_by', 'buy_request_status_id', 'buy_request_type_id'], 'integer'],
            [['code'], 'string', 'max' => 50],
            [['buy_request_status_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestStatus::className(), 'targetAttribute' => ['buy_request_status_id' => 'id']],
            [['buy_request_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestType::className(), 'targetAttribute' => ['buy_request_type_id' => 'id']],
            [['created_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['created_by' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'code' => 'Code',
            'created' => 'Created',
            'last_update' => 'Last Update',
            'created_by' => 'Created By',
            'buy_request_status_id' => 'Buy Request Status ID',
            'bidding_start' => 'Bidding Start',
            'bidding_end' => 'Bidding End',
            'buy_request_type_id' => 'Buy Request Type ID',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestStatus()
    {
        return $this->hasOne(BuyRequestStatus::className(), ['id' => 'buy_request_status_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestType()
    {
        return $this->hasOne(BuyRequestType::className(), ['id' => 'buy_request_type_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCreatedBy()
    {
        return $this->hasOne(User::className(), ['id' => 'created_by']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestDocuments()
    {
        return $this->hasMany(BuyRequestDocument::className(), ['buy_request_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDemandItems()
    {
        return $this->hasMany(DemandItem::className(), ['buy_request_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOfferts()
    {
        return $this->hasMany(Offert::className(), ['buy_request_id' => 'id']);
    }

    /**
     * Get available code for set in code depending type of buyRequest
     * @return bool|string
     * @throws ForbiddenHttpException
     */
    public function setCode()
    {
        $availableCode = false;
        $startingCode='';
        switch ($this->buy_request_type_id){
            case BuyRequestType::$INTERNACIIONAL_ID;
            $startingCode= 'SI-';
            break;
            case BuyRequestType::$NACIONAL_ID;
            $startingCode="SN-";
            break;
            default:
                throw new ForbiddenHttpException("No hay un algoritomo configurado en el sistema para el tipo de solicitud que intenta crear.");
                break;

        }

        $startingCode = $startingCode. date('Y') . "-";
        $demands = BuyRequest::find()->where(['not', ['code' => null]])
            ->andWhere(['buy_request_type_id'=>$this->buy_request_type_id])
            ->andWhere(['ilike', 'code', $startingCode])
            ->orderBy(['code' => SORT_ASC])->all();
        $used = [];
        foreach ($demands as $demand) {
            array_push($used, $demand->demand_code);
        }
        $next = true;
        for ($i = 1; $next; $i++) {
            $str = str_pad($i, 5, '0', STR_PAD_LEFT);
            $currentCode = $startingCode . $str;
            if (!in_array($currentCode, $used)) {
                $availableCode = $currentCode;
                $next = false;
            }
        }
        $this->code=  $availableCode;
        return true;
    }
    public static function comboAvailableBuyRequest($type=false)
    {
        $models = self::find()->where(['buy_request_status_id'=>BuyRequestStatus::$BORRADOR_ID]);
        if($type){
            $models=$models->andWhere(['buy_request_type_id'=>$type]);
        }
        return ArrayHelper::map($models->all(),'id','code');


    }
}
