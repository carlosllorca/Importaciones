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
 * @property string|null $last_update
 * @property int $created_by
 * @property int $buy_request_status_id
 * @property int $buy_request_type_id
 * @property string|null $approved_date
 * @property int|null $approved_by
 * @property string|null $cancel_reason
 *  @property int|null $buyer_assigned
 * @property int|null $buy_approved_by
 * @property string|null $buy_approved_date
 * @property int|null $dt_specialist_assigned
 * @property string|null $dt_approved_date
 * @property int|null $dt_approved_by

 * @property FileInput $blank_contract
 * @property FileInput $pliego
 * @property FileInput $buyer_fundamentation
 *
 * @property BuyRequestStatus $buyRequestStatus
 * @property BuyRequestType $buyRequestType
 * @property User $createdBy
 * @property User $approvedBy
 * @property BuyRequestDocument[] $buyRequestDocuments
 * @property BuyRequestInternational $buyRequestInternational
 * @property BuyRequestProvider[] $buyRequestProviders
 * @property DemandItem[] $demandItems
 * @property EmailNotify[] $emailNotifies
 * @property RequestStage[] $requestStages
 *  @property User $buyerAssigned
 * @property User $buyApprovedBy
 * @property User $dtSpecialistAssigned
 * @property User $dtApprovedBy
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
            [['created', 'last_update', 'approved_date','ganadores'], 'safe'],
            [['created_by', 'buy_request_status_id', 'buy_request_type_id', 'approved_by', 'buyer_assigned', 'buy_approved_by', 'dt_specialist_assigned', 'dt_approved_by'], 'default', 'value' => null],
            [['created_by', 'buy_request_status_id', 'buy_request_type_id', 'approved_by','buyer_assigned', 'buy_approved_by', 'dt_specialist_assigned', 'dt_approved_by'], 'integer'],
            [['cancel_reason'], 'string'],
            [['code'], 'string', 'max' => 50],

            [['buy_request_status_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestStatus::className(), 'targetAttribute' => ['buy_request_status_id' => 'id']],
            [['buy_request_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestType::className(), 'targetAttribute' => ['buy_request_type_id' => 'id']],
            [['created_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['created_by' => 'id']],
            [['approved_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['approved_by' => 'id']],

            [['buyer_assigned'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['buyer_assigned' => 'id']],
            [['buy_approved_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['buy_approved_by' => 'id']],
            [['dt_specialist_assigned'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['dt_specialist_assigned' => 'id']],
            [['dt_approved_by'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['dt_approved_by' => 'id']],
        ];
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
    public function getApprovedBy()
    {
        return $this->hasOne(User::className(), ['id' => 'approved_by']);
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
    public function getBuyRequestInternational()
    {
        return $this->hasOne(BuyRequestInternational::className(), ['buy_request_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestProviders()
    {
        return $this->hasMany(BuyRequestProvider::className(), ['buy_request_id' => 'id']);
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
    public function getEmailNotifies()
    {
        return $this->hasMany(EmailNotify::className(), ['buy_request_id' => 'id']);
    }
    /**
     * Gets query for [[BuyerAssigned]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getBuyerAssigned()
    {
        return $this->hasOne(User::className(), ['id' => 'buyer_assigned']);
    }

    /**
     * Gets query for [[BuyApprovedBy]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getBuyApprovedBy()
    {
        return $this->hasOne(User::className(), ['id' => 'buy_approved_by']);
    }

    /**
     * Gets query for [[DtSpecialistAssigned]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getDtSpecialistAssigned()
    {
        return $this->hasOne(User::className(), ['id' => 'dt_specialist_assigned']);
    }

    /**
     * Gets query for [[DtApprovedBy]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getDtApprovedBy()
    {
        return $this->hasOne(User::className(), ['id' => 'dt_approved_by']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getRequestStages()
    {
        return $this->hasMany(RequestStage::className(), ['buy_request_id' => 'id']);
    }
    public function requestStageOrdenados()
    {
        return RequestStage::find()->innerJoinWith('stage')->where(['stage.active'=>true])->andWhere(['buy_request_id'=>$this->id])->orderBy('stage.order')->all();
    }
    public function currentStage(){

        foreach ($this->requestStageOrdenados() as $requestStage){
            if(!$requestStage->real_end)
                return $requestStage;
            $last = $requestStage;
        }
        return new RequestStage();
    }
    public function cicloCompletado(){
        return RequestStage::find()->where(['buy_request_id'=>$this->id])->andWhere(['real_end'=>null])->count()==0;

    }



    /**
     * @return BuyRequestDocument[]
     */
    public function documentsUser()
    {
        $items =[];
        foreach ($this->buyRequestDocuments as $buyRequestDocument){
            if(!$buyRequestDocument->document_type_id&&Yii::$app->user->can('buyrequest/uploadotherdocs')){
                array_push($items,$buyRequestDocument);
            }
            else if($buyRequestDocument->documentType&&$buyRequestDocument->documentType->active&&$buyRequestDocument->documentType->userLoggedCanView()){
                array_push($items,$buyRequestDocument);
            }
        }
        return $items;
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
    public function allDocumentOk(){
        foreach ($this->buyRequestDocuments as $buyRequestDocument){
            if($buyRequestDocument->document_status_id!=DocumentStatus::$APROBADO_ID&&$buyRequestDocument->documentType->required)
                return false;
        }
        return true;
    }
    public function lastUploadDocumentDate(){
        $lastDate=0;
        foreach ($this->buyRequestDocuments as $buyRequestDocument){
            if(strtotime($buyRequestDocument->last_update)>$lastDate)
                $lastDate=strtotime($buyRequestDocument->last_update);
        }
        return date('Y-m-d',$lastDate);

    }





}
