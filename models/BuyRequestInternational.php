<?php

namespace app\models;

use kartik\file\FileInput;
use Mpdf\Config\ConfigVariables;
use Mpdf\Config\FontVariables;
use Mpdf\Mpdf;
use Yii;
use yii\web\Controller;
use yii\web\UploadedFile;
use ZipArchive;

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
 * @property int|null $transport_days
 * @property int|null $build_days
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
    const SCENARIO_SELECT_WINNERS = 'select_winners';
    const SCENARIO_START_TRANSPORTATION = 'START_TRANSPORTATION';
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
            [['buy_request_id',  'destiny_id', 'payment_instrument_id', 'buy_condition_id'], 'default', 'value' => null],
            [['buy_request_id', 'destiny_id', 'payment_instrument_id', 'buy_condition_id'], 'integer'],
            [['bidding_start', 'bidding_end','ganadores'], 'safe'],
            [['message','bidding_start','bidding_end','buy_condition_id'],'required','on'=>self::SCENARIO_GENERATE_LICITACION],
            [['transport_days','build_days'],'required','on'=>self::SCENARIO_START_TRANSPORTATION],
            [['transport_days','build_days'],'integer','min'=>0,'max'=>999],
            [['bidding_start','bidding_end'], 'invalidRangeDate'],
            [['bidding_end'], 'beforeToday','on'=>self::SCENARIO_GENERATE_LICITACION],
            [['blank_contract','pliego','buyer_fundamentation'], 'required','on'=>self::SCENARIO_SELECT_WINNERS],
            [['ganadores'], 'required','on'=>self::SCENARIO_SELECT_WINNERS,'message'=>'Debe seleccionar un ganador.'],
            [['blank_contract','pliego','buyer_fundamentation'], 'file', 'skipOnEmpty' => true, 'extensions' => 'pdf,doc,docx','maxSize' => 2048*1024 ],
            [['buy_condition_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyCondition::className(), 'targetAttribute' => ['buy_condition_id' => 'id']],
            [['buy_request_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequest::className(), 'targetAttribute' => ['buy_request_id' => 'id']],
            [['destiny_id'], 'exist', 'skipOnError' => true, 'targetClass' => Destiny::className(), 'targetAttribute' => ['destiny_id' => 'id']],
            [['payment_instrument_id'], 'exist', 'skipOnError' => true, 'targetClass' => PaymentInstrument::className(), 'targetAttribute' => ['payment_instrument_id' => 'id']],

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
            'blank_contract'=>'Preforma de contrato',
            'buyer_fundamentation'=>'Fundamentación de la compra',
            'buy_approved_by' => 'Buy Approved By',
            'buy_approved_date' => 'Buy Approved Date',
            'dt_specialist_assigned' => 'Dt Specialist Assigned',
            'dt_approved_date' => 'Dt Approved Date',
            'dt_approved_by' => 'Dt Approved By',
            'destiny_id' => 'Destino',
            'payment_instrument_id' => 'Instrumento de pago',
            'buy_condition_id' => 'Condición de la compra',
            'message'=>'Cuerpo del mensaje',
            'transport_days'=>'Dias de transportación',
            'build_days'=>'Dias para que la producción esté lista'
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
    /**
     * Generar el árbol de documentos necesarios del expediente.
     */
    public function generateFiledTree($fileUploaded){



                $fields = DocumentType::find()->where(['active'=>true])->andWhere(['buy_request_type_id'=>BuyRequestType::$INTERNACIIONAL_ID])->all();
                foreach ($fields as $field){
                    $doc = new BuyRequestDocument();
                    $doc->document_type_id=$field->id;
                    $doc->buy_request_id=$this->buyRequest->id;
                    $doc->document_status_id=DocumentStatus::$PENDIENTE_ID;
                    if(isset(self::$seller_fields[$field->id])&&$fileUploaded[self::$seller_fields[$field->id]]){
                        $doc->url_to_file=$fileUploaded[self::$seller_fields[$field->id]];
                        $doc->last_updated_by=User::userLogged()->id;
                        $doc->document_status_id=DocumentStatus::$APROBADO_ID;
                        $doc->last_update=date('Y-m-d');
                    }
                    $doc->save(false);
                }




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
     * Genera la portada del PDf Solicitud de oferta internacional.
     * @param Controller $controller
     * @return string
     * @throws \Mpdf\MpdfException
     */
    private function pdfRequestOfert($controller){
      //  Yii::$app->response->headers->add('Content-Type', 'application/pdf');
        $defaultConfig = (new ConfigVariables())->getDefaults();
        $fontDirs = $defaultConfig['fontDir'];
        $defaultFontConfig = (new FontVariables())->getDefaults();
        $fontData = $defaultFontConfig['fontdata'];

        $mpdf = new Mpdf([
           // 'orientation'=>'L',
            'format'=>'letter',
            'fontDir' => array_merge($fontDirs, [
                '../web/Roboto',
            ]),
            'fontdata' => $fontData + [
                    'roboto' => [
                        'R' => 'Roboto-Regular.ttf',
                        'B' => 'Roboto-Bold.ttf',
                        'I'=>'Roboto-LightItalic.ttf'
                    ],
                    'robotoitalic' => [
                        'R' => 'Roboto-Regular.ttf',

                        'I'=>'Roboto-LightItalic.ttf'
                    ],
                    'robotobold' => [
                        'R' => 'Roboto-Black.ttf',
                        'B' => 'Roboto-Black.ttf',

                    ]
                ],
            'default_font' => 'Roboto'
        ]);

        $mpdf->SetDisplayMode('fullwidth');
        $stylesheet = file_get_contents('../web/css/pdf.css'); // external css
        $mpdf->WriteHTML($stylesheet, 1);
        $mpdf->WriteHTML($controller->renderPartial('/buy-request/_pdf_solicitud_ofertas',['model'=>$this->buyRequest]),2);
        $mpdf->Output($this->buyRequest->code.'.pdf');
        return $this->buyRequest->code.'.pdf';
    }

    /**
     * @param Controller $controller
     * @return bool
     * @throws \yii\base\InvalidConfigException
     */
    public function notifyProviders($controller){
        $providerEmails= [];
        foreach ($this->buyRequest->buyRequestProviders as $buyRequestProvider){
            array_push($providerEmails,$buyRequestProvider->provider->contact_email);
        }
        $urlXls = Yii::$app->xlsModels->xlsSolicitudOfertas($this->buyRequest);
        $urlPdf = $this->pdfRequestOfert($controller);

        $files = [$urlPdf,$urlXls];

        $zipname = $this->buyRequest->code.'.zip';
        if (file_exists($zipname)) {
            $deleted = unlink($zipname);
        }
        $zip = new ZipArchive();
        $zip->open($zipname,ZipArchive::CREATE);
        foreach ($files as $file) {
            $zip->addFile($file);
        }
        $zip->close();
        try {
            Yii::$app->mailer->compose('notifyProviders',['buyRequest'=>$this->buyRequest,'message'=>$this->message])
                ->setFrom([ Yii::$app->params['senderEmail']=>Yii::$app->params['senderName']])
                ->setBcc($providerEmails)
                ->setTo([$this->buyRequest->buyApprovedBy->email, $this->buyRequest->buyerAssigned->email])
                ->setReplyTo([$this->buyRequest->buyApprovedBy->email, $this->buyRequest->buyerAssigned->email])
                ->attach($zipname)
                ->setSubject('Solicitud de ofertas No. ' . $this->buyRequest->code)
                ->send();
            $model = new EmailNotify();
            $model->buy_request_id=$this->buy_request_id;
            $model->bidding_start=$this->bidding_start;
            $model->bidding_end=$this->bidding_end;
            $model->sended_date=date('Y-m-d');
            $model->body=$this->message;
            $model->attachment=$zipname;
            if($model->validate()){
                $model->save();
            }else{
                Yii::$app->session->setFlash('danger','Ocurrió un problema al guardar la información de la licitación.');
            }
            return true;
        }catch (\Exception $e){
            Yii::$app->session->setFlash('danger','Error notificando a proveedores. Inténtelo de nuevo más tarde.');
            return false;
        }

    }
}
