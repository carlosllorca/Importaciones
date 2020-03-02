<?php

namespace app\models;

use kartik\file\FileInput;
use Yii;
use yii\base\InvalidConfigException;
use yii\db\Exception;

use yii\helpers\ArrayHelper;
use yii\web\ForbiddenHttpException;
use yii\web\UploadedFile;

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
 * @property int $buyer_assigned
 * @property int $dt_specialist_asigned
 * @property boolean $gol_approved
 * @property string $cancel_reason
 * @property int $destiny_id
 * @property int $payment_instrument_id
 * @property int $buy_condition_id

 * @property FileInput $blank_contract
 * @property FileInput $pliego
 * @property FileInput $buyer_fundamentation
 *
 * @property BuyCondition $buyCondition
 * @property PaymentInstrument $paymentInstrument
 * @property Destiny $destiny
 * @property BuyRequestStatus $buyRequestStatus
 * @property BuyRequestType $buyRequestType
 * @property User $createdBy
 * @property User $buyerAssigned
 * @property User $dtSpecialistAssigned
 * @property BuyRequestDocument[] $buyRequestDocuments
 * @property DemandItem[] $demandItems
 * @property BuyRequestProvider[] $buyRequestProviders
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
    const SCENARIO_GENERATE_LICITACION = 'ADD_LICITACION';
    public $blank_contract;
    public $pliego;
    public $buyer_fundamentation;
    public $ganadores;
    static  $seller_fields  =[
            DocumentType::FUNDAMENTACION_COMPRA_ID=>'buyer_fundamentation',
            DocumentType::PLIEGO_ID=>'pliego',
            DocumentType::PREFORMA_ID=>'blank_contract',

        ];
    public function rules()
    {
        return [
            [['code', 'created', 'created_by', 'buy_request_status_id', 'buy_request_type_id'], 'required'],
            [['created', 'last_update', 'bidding_start', 'bidding_end','buyer_assigned','dt_specialist_assigned',
                'ganadores'], 'safe'],
            [['created_by', 'buy_request_status_id', 'buy_request_type_id'], 'default', 'value' => null],
            [['created_by', 'buy_request_status_id', 'buy_request_type_id','destiny_id','payment_instrument_id','buy_condition_id'], 'integer'],
            [['gol_approved'],'boolean'],
            [['bidding_start','bidding_end','destiny_id','payment_instrument_id','buy_condition_id'],'required','on'=>self::SCENARIO_GENERATE_LICITACION],
            ['cancel_reason','string'],
            [['blank_contract','pliego','buyer_fundamentation'], 'file', 'skipOnEmpty' => true, 'extensions' => 'pdf,doc,docx','maxSize' => 2048*1024 ],
            [['bidding_start','bidding_end'], 'invalidRangeDate'],
            [['bidding_start','bidding_end'], 'beforeToday'],
            [['code'], 'string', 'max' => 50],
            [['buy_request_status_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestStatus::className(), 'targetAttribute' => ['buy_request_status_id' => 'id']],
            [['buy_request_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestType::className(), 'targetAttribute' => ['buy_request_type_id' => 'id']],
            [['created_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['created_by' => 'id']],
            [['destiny_id'], 'exist', 'skipOnError' => true, 'targetClass' => Destiny::className(), 'targetAttribute' => ['destiny_id' => 'id']],
            [['buy_condition_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyCondition::className(), 'targetAttribute' => ['buy_condition_id' => 'id']],
            [['payment_instrument_id'], 'exist', 'skipOnError' => true, 'targetClass' => PaymentInstrument::className(), 'targetAttribute' => ['payment_instrument_id' => 'id']]
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
            'code' => 'Código',
            'created' => 'Fecha',
            'last_update' => 'Última actualización',
            'created_by' => 'Creado por',
            'buy_request_status_id' => 'Estado',
            'bidding_start' => 'Fecha Inicio',
            'bidding_end' => 'Fecha Fin',
            'buy_request_type_id' => 'Tipo',
            'destiny_id' => 'Puerto de Destino',
            'payment_instrument_id' => 'Instrumento de pago',
            'buy_condition_id' => 'Condición de la compra',
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
    public function getBuyerAssigned()
    {
        return $this->hasOne(User::className(), ['id' => 'buyer_assigned']);
    }
    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDtSpecialistAssigned()
    {
        return $this->hasOne(User::className(), ['id' => 'dt_specialist_asigned']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestDocuments()
    {
        return $this->hasMany(BuyRequestDocument::className(), ['buy_request_id' => 'id']);
    }

    /**
     * @return BuyRequestDocument[]
     */
    public function documentsUser()
    {
        $items =[];
        foreach ($this->buyRequestDocuments as $buyRequestDocument){
            if($buyRequestDocument->documentType->active&&$buyRequestDocument->documentType->userLoggedCanView()){
                array_push($items,$buyRequestDocument);
            }
        }
        return $items;
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
    public function getBuyCondition()
    {
        return $this->hasOne(BuyCondition::className(), ['id' => 'buy_condition_id']);
    }
    /**

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
     * Demandas asociadas a las solicitudes de compra
     */
    public function getDemands(){
        return Demand::find()->innerJoinWith('demandItems')->where(['demand_item.buy_request_id'=>$this->id])->groupBy('demand.id')->all();
    }
    /**
     * Relación de productos agrupados por tipo categoría
     * @return ValidatedListItem[]
     */
    public function getProducts(){
        return ValidatedListItem::find()
            ->addSelect(["SUM(demand_item.quantity) as quantity",'product_name','demand_item.price as price'])
            ->innerJoinWith('demandItems')
            ->where(['demand_item.buy_request_id'=>$this->id])
            ->groupBy(['validated_list_item.id','demand_item.price'])->all();
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestProviders()
    {
        return $this->hasMany(BuyRequestProvider::className(), ['buy_request_id' => 'id']);
    }

    /**
     * Monto total de la orden de compra.
     * @param bool $formated
     * @return float|int|string
     * @throws InvalidConfigException
     */
    public function ammount($formated=false){
        $amount = 0;
        foreach ($this->demandItems as $demandItem){
            $amount+=$demandItem->quantity*$demandItem->price;
        }
        return $formated?Yii::$app->formatter->asCurrency($amount):$amount;
    }

    /**
     * Clases para formatear los etados de las solicitudes
     * @return string
     */
    public function classByStatus(){
        switch ($this->buy_request_status_id){
            case BuyRequestStatus::$BORRADOR_ID;
                return 'text-secondary';
                break;
            case BuyRequestStatus::$SIN_TRAMITAR_ID:
                return 'text-primary';
                break;
            case BuyRequestStatus::$CANCELADA_ID:
                return 'text-danger';
                break;

            default:
                return 'text-dark';
                break;
        }
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
            array_push($used, $demand->code);
        }
        $next = true;
        for ($i = 1; $next; $i++) {
            $str = str_pad($i, 3, '0', STR_PAD_LEFT);
            $currentCode = $startingCode . $str;
            if (!in_array($currentCode, $used)) {
                $availableCode = $currentCode;
                $next = false;
            }
        }
        $this->code=  $availableCode;
        return true;
    }

    /**
     * Devuelve arreglo con los clientes asociados a las solicitudes de compra.
     * @return Client[]
     */
    public function clientes(){
        $clientes = [];
        $idsClientes=[];
        foreach ($this->demandItems as $demandItem){
            if(!in_array($demandItem->demand->client->id,$idsClientes)){
                array_push($idsClientes,$demandItem->demand->client->id);
                array_push($clientes,$demandItem->demand->client);
            }

        }
        return$clientes;
    }
    public static function comboAvailableBuyRequest($type=false)
    {
        $models = self::find()->where(['buy_request_status_id'=>BuyRequestStatus::$BORRADOR_ID]);
        if($type){
            $models=$models->andWhere(['buy_request_type_id'=>$type]);
        }
        return ArrayHelper::map($models->all(),'id','code');
    }
    public function arrayValidatedList(){
        $vl = [];
        foreach ($this->demandItems as $demandItem){
            if(!in_array($demandItem->demand->validated_list_id,$vl)){
                array_push($vl,$demandItem->demand->validated_list_id);
            }
        }
        return $vl;
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
    public function getWinners(){
        $winners=[];
        foreach ($this->buyRequestProviders as $buyRequestProvider){
            if($buyRequestProvider->winner)
                array_push($winners ,$buyRequestProvider);
        }
        return $winners;
    }

    /**
     * @return BuyRequestProvider[]
     */
    public function getFinalistas(){
        $winners=[];
        foreach ($this->buyRequestProviders as $buyRequestProvider){
            if($buyRequestProvider->provider_status_id==ProviderStatus::$OFERTA_APROBADA_ID)
                array_push($winners ,$buyRequestProvider);
        }
        return $winners;
    }
    public function comboFinalistas(){
        return ArrayHelper::map(
            BuyRequestProvider::find()
            ->andWhere(['provider_status_id'=>ProviderStatus::$OFERTA_APROBADA_ID])
            ->andWhere(['buy_request_id'=>$this->id])->all(),'id',function($model){return $model->provider->name;}
        );
    }
    public function loadInitialExpedientFilesUrl(){
        $a = ['buyer_fundamentation','pliego','blank_contract'];
        $url=[];
        foreach ($a as $i){
            $this->$i = UploadedFile::getInstance($this, $i);
            if($this->$i){
                $file= $this->upload($i);
                if($file){
                    $url[$i]= $file;
                }
            }else{
                $url[$i]=false;
            }
        }
        return $url;

    }

    /**
     * Generar el árbol de documentos necesarios del expediente.
     */
    public function generateFiledTree($fileUploaded){
        //todo: Mejorar este método teniendo en cuenta los ficheros reales del tipo de solicitud. Modelar esto en BD
        $fields = DocumentType::find()->where(['active'=>true])->all();
        foreach ($fields as $field){
            $doc = new BuyRequestDocument();
            $doc->document_type_id=$field->id;
            $doc->buy_request_id=$this->id;
            if(isset(self::$seller_fields[$field->id])&&$fileUploaded[self::$seller_fields[$field->id]]){
                $doc->url_to_file=$fileUploaded[self::$seller_fields[$field->id]];
                $doc->last_updated_by=User::userLogged()->id;
                $doc->last_update=date('Y-m-d');
            }
            $doc->save(false);
        }

    }

}
