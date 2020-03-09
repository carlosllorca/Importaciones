<?php

namespace app\models;

use kartik\file\FileInput;
use Yii;

/**
 * This is the model class for table "buy_request_international".
 *
 * @property int $id
 * @property int $buy_request_id
 * @property string|null $bidding_start
 * @property string|null $bidding_end
 * @property int|null $buyer_assigned
 * @property int|null $buy_approved_by
 * @property string|null $buy_approved_date
 * @property int|null $dt_specialist_assigned
 * @property string|null $dt_approved_date
 * @property int|null $dt_approved_by
 * @property int|null $destiny_id
 * @property int|null $payment_instrument_id
 * @property int|null $buy_condition_id
 * @property string|null $message
 *
 * @property FileInput $blank_contract
 * @property FileInput $pliego
 * @property FileInput $buyer_fundamentation
 *
 * @property BuyCondition $buyCondition
 * @property BuyRequest $buyRequest
 * @property User $buyerAssigned
 * @property User $dtSpecialistAssigned
 * @property Destiny $destiny
 * @property PaymentInstrument $paymentInstrument
 * @property User $buyApprovedBy
 * @property User $dtApprovedBy
 */
class BuyRequestInternational extends \yii\db\ActiveRecord
{
    const SCENARIO_GENERATE_LICITACION = 'ADD_LICITACION';
    public $blank_contract;
    public $pliego;
    public $buyer_fundamentation;
    public $ganadores;
    public $message;
    static  $seller_fields  =[
        DocumentType::FUNDAMENTACION_COMPRA_ID=>'buyer_fundamentation',
        DocumentType::PLIEGO_ID=>'pliego',
        DocumentType::PREFORMA_ID=>'blank_contract',

    ];

    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'buy_request_international';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['buy_request_id'], 'required'],
            [['buy_request_id', 'buyer_assigned', 'buy_approved_by', 'dt_specialist_assigned', 'dt_approved_by', 'destiny_id', 'payment_instrument_id', 'buy_condition_id'], 'default', 'value' => null],
            [['buy_request_id', 'buyer_assigned', 'buy_approved_by', 'dt_specialist_assigned', 'dt_approved_by', 'destiny_id', 'payment_instrument_id', 'buy_condition_id'], 'integer'],
            [['bidding_start', 'bidding_end', 'buy_approved_date', 'dt_approved_date','ganadores'], 'safe'],
            [['message','bidding_start','bidding_end','buy_condition_id'],'required','on'=>self::SCENARIO_GENERATE_LICITACION],
            [['bidding_start','bidding_end'], 'invalidRangeDate'],
            [['bidding_end'], 'beforeToday'],
            [['blank_contract','pliego','buyer_fundamentation'], 'file', 'skipOnEmpty' => true, 'extensions' => 'pdf,doc,docx','maxSize' => 2048*1024 ],
            [['buy_condition_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyCondition::className(), 'targetAttribute' => ['buy_condition_id' => 'id']],
            [['buy_request_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequest::className(), 'targetAttribute' => ['buy_request_id' => 'id']],
            [['destiny_id'], 'exist', 'skipOnError' => true, 'targetClass' => Destiny::className(), 'targetAttribute' => ['destiny_id' => 'id']],
            [['payment_instrument_id'], 'exist', 'skipOnError' => true, 'targetClass' => PaymentInstrument::className(), 'targetAttribute' => ['payment_instrument_id' => 'id']],
            [['buy_approved_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['buy_approved_by' => 'id']],
            [['dt_approved_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['dt_approved_by' => 'id']],
        ];
    }
    function invalidRangeDate($attribute)
    {
        $start = strtotime($this->bidding_start);
        $end = strtotime($this->bidding_end);
        if ($end < $start) {
            $this->addError($attribute, "El rango de fechas seleccionado no es válido.");
        }
    }
    function beforeToday($attribute)
    {
        $date = strtotime($this->$attribute);
        $today = strtotime(date('Y-m-d'));
        if ($date < $today) {
            $this->addError($attribute, "La fecha no puede estar en el pasado.");
        }
    }
    /*
     * Subir fichero
     */
    public function upload($file)
    {
        $name = Yii::$app->security->generateRandomString().'.'.$this->$file->extension;
        $this->$file->saveAs('request_files/' .$name);
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
            'bidding_start' => 'Inicio',
            'bidding_end' => 'Fin',
            'buyer_assigned' => 'Buyer Assigned',
            'buy_approved_by' => 'Buy Approved By',
            'buy_approved_date' => 'Buy Approved Date',
            'dt_specialist_assigned' => 'Dt Specialist Assigned',
            'dt_approved_date' => 'Dt Approved Date',
            'dt_approved_by' => 'Dt Approved By',
            'destiny_id' => 'Destino',
            'payment_instrument_id' => 'Instrumento de pago',
            'buy_condition_id' => 'Condición de la compra',
            'message'=>'Cuerpo del mensaje'
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyCondition()
    {
        return $this->hasOne(BuyCondition::className(), ['id' => 'buy_condition_id']);
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
    public function getBuyerAssigned()
    {
        return $this->hasOne(User::className(), ['id' => 'buyer_assigned']);
    }
    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyApprovedBy()
    {
        return $this->hasOne(User::className(), ['id' => 'buy_approved_by']);
    }
    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDtSpecialistAssigned()
    {
        return $this->hasOne(User::className(), ['id' => 'dt_specialist_assigned']);
    }
    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDtApprovedBy()
    {
        return $this->hasOne(User::className(), ['id' => 'dt_approved_by']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDestiny()
    {
        return $this->hasOne(Destiny::className(), ['id' => 'destiny_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPaymentInstrument()
    {
        return $this->hasOne(PaymentInstrument::className(), ['id' => 'payment_instrument_id']);
    }



    /**
     * Licitación activa?
     * @return bool
     */
    function biddingActive()
    {
        $start = strtotime($this->bidding_start);
        $end = strtotime($this->bidding_end);
        $now= strtotime(date('Y-m-d'));
        return $now>=$start&&$now<=$end;

    }
    public function biddingEnd()
    {
        $end = strtotime($this->bidding_end);
        $now= strtotime(date('Y-m-d'));
        return $now>$end;
    }
    public function notifyProviders(){
        $providerEmails= [];
        foreach ($this->buyRequest->buyRequestProviders as $buyRequestProvider){
            array_push($providerEmails,$buyRequestProvider->provider->contact_email);
        }
        $urlFile = Yii::$app->xlsModels->xlsSolicitudOfertas($this->buyRequest);

        try {
            Yii::$app->mailer->compose()
                ->setFrom([ Yii::$app->params['senderEmail']=>Yii::$app->params['senderName']])
                ->setBcc($providerEmails)
                ->setHtmlBody($this->message)
                ->setTo([$this->buyApprovedBy->email, $this->buyerAssigned->email])
                ->setReplyTo([$this->buyApprovedBy->email, $this->buyerAssigned->email])
                ->attach($urlFile)
                ->setSubject('Solicitud de ofertas No. ' . $this->buyRequest->code)
                ->send();
            $model = new EmailNotify();
            $model->buy_request_id=$this->buy_request_id;
            $model->bidding_start=$this->bidding_start;
            $model->bidding_end=$this->bidding_end;
            $model->sended_date=date('Y-m-d');
            $model->body=$this->message;
            $model->attachment=$urlFile;
            if($model->validate()){
                $model->save();
            }else{
                Yii::$app->session->setFlash('danger','Ocurrió un problema al guardar la información de la licitación.');
            }


        }catch (\Exception $e){
            Yii::$app->session->setFlash('danger','Error notificando a proveedores. Inténtelo de nuevo más tarde.');
            return false;
        }

    }
}
