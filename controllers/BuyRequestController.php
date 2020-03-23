<?php

namespace app\controllers;

use app\models\BuyRequest;
use app\models\BuyRequestDocument;
use app\models\BuyRequestInternational;
use app\models\BuyRequestProvider;
use app\models\BuyRequestSearch;
use app\models\BuyRequestStatus;
use app\models\BuyRequestType;
use app\models\DemandItem;
use app\models\DemandStatus;
use app\models\Destiny;
use app\models\DocumentStatus;
use app\models\FormCloseNationalBidding;
use app\models\FormPropuesta;
use app\models\Offert;
use app\models\PaymentInstrument;
use app\models\Provider;
use app\models\ProviderStatus;
use app\models\Rbac;
use app\models\RequestStage;
use app\models\Stage;
use app\models\User;
use Mpdf\Config\ConfigVariables;
use Mpdf\Config\FontVariables;
use Mpdf\Mpdf;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use Yii;
use PhpOffice\PhpSpreadsheet\Reader\Html;
use yii\db\Exception;
use yii\filters\VerbFilter;
use yii\web\ForbiddenHttpException;
use yii\web\NotFoundHttpException;
use yii\web\Response;
use yii\web\UploadedFile;
use yii\widgets\ActiveForm;
use ZipArchive;

/**
 * BuyRequestController implements the CRUD actions for BuyRequest model.
 */
class BuyRequestController extends MainController
{
    /**
     * {@inheritdoc}
     */
    public function behaviors()
    {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['POST'],
                ],
            ],
        ];
    }
    /**
     * @inheritdoc
     */
    public function beforeAction($action)
    {
        if (in_array($action->id ,[ 'assign-user','reject'])) {
            $this->enableCsrfValidation = false;
        }

        return parent::beforeAction($action);
    }

    /**
     * Lists all BuyRequest models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new BuyRequestSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single BuyRequest model.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new BuyRequest model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new BuyRequest();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }

   public function actionUpdate($id){
       $model = $this->findModel($id);
       if((Rbac::getRole()==Rbac::$ESP_TECNICO||Rbac::getRole()==Rbac::$COMPRADOR_INTERNACIONAL)&&(!$model->buy_approved_by||!$model->dt_approved_by)){
           Yii::$app->session->setFlash('warning','Esta orden aún no ha sido aprobada para su edición.');
           return $this->redirect(['view','id'=>$model->id]);
       }
       switch ($model->buy_request_type_id){
           case BuyRequestType::$INTERNACIIONAL_ID:
               return $this->updateInternacional($model);
               break;
           case BuyRequestType::$NACIONAL_ID:
               return $this->updateNacional($model);
               break;
           default:
               new ForbiddenHttpException('Tipo de solicitud de compra no autorizado');


       }
   }

    /**
     * @param BuyRequest $model
     * @return string|Response
     */
    private function updateInternacional($model)
    {
        $active = 'demands_associated';
        if($model->buy_request_type_id==BuyRequestType::$INTERNACIIONAL_ID){
            if($model->buyRequestInternational){
                $form = $model->buyRequestInternational;
                $form->setScenario(BuyRequestInternational::SCENARIO_GENERATE_LICITACION);
                if ($form->load(Yii::$app->request->post()) && $form->save()) {
                    $model->buy_request_status_id=BuyRequestStatus::$LICITANDO;
                    foreach (Provider::related($model->arrayValidatedList(),$model->buy_request_type_id) as $provider){
                        if(BuyRequestProvider::find()->where(['buy_request_id'=>$model->id])
                            ->andWhere(['provider_id'=>$provider->id])->one()){
                        }else{
                            $m=new BuyRequestProvider();
                            $m->buy_request_id=$model->id;
                            $m->provider_id=$provider->id;
                            $m->provider_status_id=ProviderStatus::$SOLICITUD_ENVIADA_ID;
                            $m->save();
                        }
                    };
                    if($form->notifyProviders($this)){
                        $model->save(false);
                        $active= 'propuestas';
                        return $this->render('update', [
                            'form'=>$form,
                            'model' => $model,
                            'active'=>$active
                        ]);
                    }else{
                        Yii::$app->session->setFlash('danger','Tuvimos un problema para notificar a los proveedores. Inténtelo de nuevo más tardre');
                        return $this->render('update', [
                            'form'=>$form,
                            'model' => $model,
                            'active'=>$active
                        ]);
                    }
                    return $this->redirect(['view', 'id' => $model->id]);
                }

            }else{
                $form=new BuyRequestInternational();
            }
        }


        if(Yii::$app->user->can('buyrequest/viewassociateddemands')){
            $active = 'demands_associated';

        }elseif (Yii::$app->user->can('buyrequest/viewproducts')){
            $active = 'products';
        }
        elseif (Yii::$app->user->can('buyrequest/viewdocuments')){
            $active = 'documentos';
        }

        if(Yii::$app->request->isPost){
            $active= 'propuestas';
        }
        if(Yii::$app->request->get('provider')){
            $active= 'propuestas';
        }
        if(Yii::$app->request->get('section')){
            $active = Yii::$app->request->get('section');
        }
        return $this->render('update', [
            'model' => $model,
            'form'=>$form,
            'active'=>$active
        ]);
    }

    private function updateNacional($model)
    {
        $active = 'products';
        if(Yii::$app->request->get('provider')){
            $active= 'propuestas';
        }
        if(Yii::$app->request->get('section')){
            $active = Yii::$app->request->get('section');
        }

        return $this->render('update_nacional', [
            'model' => $model,
            'active'=>$active
        ]);
    }
    public function actionGenerateNacionalOffert($id){
        $model = new FormPropuesta();
        $model->setScenario(FormPropuesta::$SCENARIO_UPLOAD);
        $model->buy_request_id=$id;
        if (Yii::$app->request->isPost) {
            $model->oferta = UploadedFile::getInstance($model, 'oferta');
            if($model->oferta){
                $file= $model->upload();
                if($file){
                    $model->url_file = $file;
                    $model->setScenario(FormPropuesta::SCENARIO_DEFAULT);
                }
            }else{
                $emptyFile=true;
            }

        }

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            $mbr=BuyRequestProvider::findOne(['provider_id'=>$model->provider,'buy_request_id'=>$id]);
            if(!$mbr){
                $mbr=new BuyRequestProvider();
                $mbr->provider_id=$model->provider;
                $mbr->provider_status_id=ProviderStatus::$OFERTA_RECIBIDA_ID;
                $mbr->buy_request_id=$model->buy_request_id;
                $mbr->save(false);
            }else{
                $mbr->provider_status_id=ProviderStatus::$OFERTA_RECIBIDA_ID;
                $mbr->save(false);
            }


            $offert = new Offert();
            $offert->buy_request_provider_id=$mbr->id;
            $offert->upload_date=date('Y-m-d');
            $offert->expiration_date=date('Y-m-d',strtotime($model->expiration_date));
            $offert->upload_by=User::userLogged()->id;
            $offert->url_file=$model->url_file;
            $offert->save(false);
            Yii::$app->session->setFlash('success','Oferta registrada exitosamente. Pendiente de aprobación por un especialista técnico.');
            return $this->redirect(['/buy-request/update','id'=>$id,'provider'=>$mbr->id]);

        }
        return $this->renderAjax('_upload_nacional_offert',['model'=>$model]);
    }

    public function actionProviderDetails($id){
        $model = BuyRequestProvider::findOne($id);
        $newOffert= new Offert();
        $newOffert->upload_date=date('Y-m-d');
        $newOffert->upload_by=User::userLogged()->id;
        $newOffert->buy_request_provider_id=$model->id;
        return $this->renderAjax('_provider_details',['model'=>$model,'newOffert'=>$newOffert]);
    }

    /**
     * Deletes an existing BuyRequest model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        try{
            $model = $this->findModel($id);
            foreach ($model->demandItems as $demandItem){
                $demandItem->buy_request_id=null;
                $demandItem->demand->demand_status_id=DemandStatus::ACEPTADA_ID;
                $demandItem->save(false);
                $demandItem->demand->save(false);

            }
            Yii::$app->traza->saveLog("Solicitud {$model->code} eliminada.","La solicitud de compra {$model->code} ha sido eliminada.");
            $model->delete();
            Yii::$app->session->setFlash('success','Solicitud de compra eliminada.');
        }catch (\Exception $exception){
            Yii::$app->session->setFlash('danger',"No podemos eliminar este elemento. Está siendo utilizado.");
        }


        return $this->redirect(['index']);
    }

    /**
     * Finds the BuyRequest model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return BuyRequest the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = BuyRequest::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    /**
     * Permisos para ver las solicitudes vinculadas
     * @throws NotFoundHttpException
     */
    public function actionViewAssociatedDemands(){
        throw new NotFoundHttpException('Página no encontrada.');
    }
    /**
     * Permisos para ver las solicitudes vinculadas
     * @throws NotFoundHttpException
     */
    public function actionViewProducts(){
        throw new NotFoundHttpException('Página no encontrada.');
    }
    /**
     * Permisos para ver las solicitudes vinculadas
     * @throws NotFoundHttpException
     */
    public function actionViewPropuestas(){
        throw new NotFoundHttpException('Página no encontrada.');
    }
    public function actionRemoveItem($item){
        $demandItem = DemandItem::findOne($item);
        $demandItem->buy_request_id=null;
        $demandItem->save(false);
        $demandItem->demand->demand_status_id=DemandStatus::ACEPTADA_ID;
        $demandItem->demand->save(false);
    }
    public function actionApprove($id){
        $model =$this->findModel($id);
        $model->buy_request_status_id=BuyRequestStatus::$SIN_TRAMITAR_ID;
        $model->approved_by=User::userLogged()->id;
        $model->approved_date=date('Y-m-d');
        switch ($model->buy_request_type_id) {
            case (BuyRequestType::$INTERNACIIONAL_ID):
                $bri= new BuyRequestInternational();
                $bri->buy_request_id=$model->id;
                $bri->save(false);
                break;
        }

        $model->save(false);
        Yii::$app->session->setFlash('success','Solicitud aprobada.');
        return $this->redirect(['update','id'=>$model->id]);
    }
    public function actionGolApproved($id){
        $model =$this->findModel($id);
        $model->gol_approved=true;
        $model->save(false);
        Yii::$app->session->setFlash('success','Solicitud aprobada.');
        return $this->redirect(['view','id'=>$model->id]);
    }
    public function actionDtApproved($id){
        $model =$this->findModel($id);

            $model->dt_approved_by=User::userLogged()->id;
            $model->dt_approved_date=date('Y-m-d');
            $model->save(false);

        Yii::$app->session->setFlash('success','Solicitud aprobada.');
        return $this->redirect(['view','id'=>$model->id]);
    }
    public function actionBuyApproved($id){
        $model =$this->findModel($id);

            $model->buy_request_status_id=BuyRequestStatus::$LICITANDO;
            $model->save(false);
            $model->buy_approved_by=User::userLogged()->id;
            $model->buy_approved_date=date('Y-m-d');
            $model->save(false);

        Yii::$app->session->setFlash('success','Solicitud aprobada.');
        return $this->redirect(['view','id'=>$model->id]);
    }
    public function actionReject(){
        Yii::$app->response->format = Response::FORMAT_JSON;
        $raw_data = json_decode(Yii::$app->request->getRawBody());
        $reason = $raw_data->reason;
        $id=$raw_data->request;
        $model =$this->findModel($id);
        $model->cancel_reason=$reason;
        $model->buy_request_status_id=BuyRequestStatus::$CANCELADA_ID;
        $model->save(false);
        Yii::$app->session->setFlash('danger','Solicitud cancelada.');
        return ['success'=>true];
    }
    public function actionExport($id){
        $model = null;
        // return the pdf output as per the destination setting
       // Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;


        $model = $this->findModel($id);

        $this->pdfSolicitudCompra($model);
        $xls =  Yii::$app->xlsModels->xlsSolicitudCompra($model);

        $files = ['tmp/'.$model->code.'.pdf',$xls];
        $zipname = 'tmp/'.$model->code.'.zip';
        $zip = new ZipArchive();
        $zip->open($zipname,ZipArchive::CREATE);
        foreach ($files as $file) {
            $zip->addFile($file);
        }
        $zip->close();
        $this->downloadFile($model->code.'.zip');
        //$this->downloadFile('tmp/'.$model->code.'.zip');



    }
    private function pdfSolicitudCompra($model){
        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
        $defaultConfig = (new ConfigVariables())->getDefaults();
        $fontDirs = $defaultConfig['fontDir'];
        $defaultFontConfig = (new FontVariables())->getDefaults();
        $fontData = $defaultFontConfig['fontdata'];

        $mpdf = new Mpdf([
            'orientation'=>'L',
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
        //return $this->renderPartial('/buy-request/export',['model'=>$model]);
        $mpdf->SetDisplayMode('fullwidth');
        $stylesheet = file_get_contents('../web/css/pdf.css'); // external css
        $mpdf->WriteHTML($stylesheet, 1);
        $mpdf->WriteHTML($this->renderPartial('/buy-request/_pdf_solicitud_compra',['model'=>$model]),2);
//       $mpdf->AddPage();
//        $mpdf->WriteHTML($this->renderPartial('/buy-request/_pdf_solicitud_compra_productos',['model'=>$model]),2);

        $mpdf->Output('tmp/'.$model->code.'.pdf');
    }

    public function actionAssignUser(){
        Yii::$app->response->format = Response::FORMAT_JSON;
        $raw_data = json_decode(Yii::$app->request->getRawBody());
        $request = $raw_data->solicitud;
        $rol = $raw_data->action;
        $user=$raw_data->user;
        $model = $this->findModel($request);
        if($rol=='comprador'){
            $model->buyer_assigned=(int)($user);
            $model->save(false);
            Yii::$app->session->setFlash('success','Orden asignada al comprador '.$model->buyerAssigned->full_name.'.');
        }
        elseif ($rol=='et'){

            $model->dt_specialist_assigned=(int)($user);
            $model->save(false);
            Yii::$app->session->setFlash('success','Orden asignada al especialista técnico '.$model->dtSpecialistAssigned->full_name.'.');
        }

        return ['success'=>true];
    }
    public function actionAssignbuyer(){

    }
    public function actionAssignet(){

    }
    public function actionUploadOffert(){

    }
    public function actionSaveOfert($id){
        $model = new Offert();
        $model->setScenario(Offert::$SCENARIO_UPLOAD_OFFERT);
        $model->buy_request_provider_id=$id;
        $model->upload_date=date('Y-m-d');
        $model->upload_by=User::userLogged()->id;


        if (Yii::$app->request->isPost) {
            $model->oferta = UploadedFile::getInstance($model, 'oferta');
            if($model->oferta){
                $file= $model->upload();
                if($file){
                    $model->url_file = $file;
                    $model->setScenario(Offert::SCENARIO_DEFAULT);
                }
            }else{
                $emptyFile=true;
            }

        }

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            $model->save();
            $model->buyRequestProvider->provider_status_id=ProviderStatus::$OFERTA_RECIBIDA_ID;
            $model->buyRequestProvider->save(false);
            return $this->redirect(['/buy-request/update','id'=>$model->buyRequestProvider->buy_request_id,
                'provider'=>$model->buy_request_provider_id]);


        }
        return $this->renderAjax('_uploadOffert',['newOffert'=>$model]);
    }
    public function actionValidateOfert(){
        $model = new Offert();

        if (Yii::$app->request->isAjax && $model->load(Yii::$app->request->post())) {
            Yii::$app->response->format = Response::FORMAT_JSON;
            return ActiveForm::validate($model);
            Yii::$app->end();
        }
    }
    public function actionValidateEvaluateOfert($id){
        $model = Offert::findOne($id);
        $model->setScenario(Offert::$SCENARIO_EVALUATE_OFFERT);

        if (Yii::$app->request->isAjax && $model->load(Yii::$app->request->post())) {
            Yii::$app->response->format = Response::FORMAT_JSON;
            return ActiveForm::validate($model);
            Yii::$app->end();
        }
    }
    public function actionEvaluateOffert($id){
        $model= Offert::findOne($id);
        $model->setScenario(Offert::$SCENARIO_EVALUATE_OFFERT);
        if (Yii::$app->request->isPost) {
            $model->evaluacion = UploadedFile::getInstance($model, 'evaluacion');
            if($model->evaluacion){
                $file= $model->uploadEvaluation();
                if($file){
                    $model->url_evaluation = $file;
                }
                $model->setScenario(Offert::SCENARIO_DEFAULT);
            }else{
                $emptyFile=true;
            }
        }
        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            $model->evaluation_date=date('Y-m-d');
            $model->evaluated_by=User::userLogged()->id;
            $model->save();
            if($model->approved){
                $model->buyRequestProvider->provider_status_id=ProviderStatus::$OFERTA_APROBADA_ID;
            }else{
                $model->buyRequestProvider->provider_status_id=ProviderStatus::$OFERTA_RECHAZADA_ID;
            }
            $model->buyRequestProvider->save(false);
            return $this->redirect(['/buy-request/update','id'=>$model->buyRequestProvider->buy_request_id,
                'provider'=>$model->buy_request_provider_id]);


        }

        return $this->renderAjax('_evaluate_offert',['model'=>$model]);
    }
    public function actionSelectWinners($id){
        $model = BuyRequestInternational::findOne($id);
        $model->setScenario(BuyRequestInternational::SCENARIO_SELECT_WINNERS);

        if (Yii::$app->request->isPost) {
            $url = $model->loadInitialExpedientFilesUrl();
            $model->setScenario(BuyRequestInternational::SCENARIO_DEFAULT);
        }

        if ($model->load(Yii::$app->request->post()) ) {
                foreach ($model->ganadores as $ganadore){
                    $winner = BuyRequestProvider::findOne($ganadore);
                    $winner->winner=true;
                    $winner->save();

                }
                $model->buyRequest->buy_request_status_id=BuyRequestStatus::$EVALUANDO_OFERTAS;
                $model->buyRequest->save(false);
                $model->save(false);
                $model->generateFiledTree($url);
                Yii::$app->session->setFlash('success','Hemos presentado el expediente correctamente. Se ha generado el árbol de documentos necesarios para la aprobación.');
                return $this->redirect(['/buy-request/update', 'id' => $model->buyRequest->id,'section'=>'documentos']);

        }
        return $this->renderAjax('_select_winners',['model'=>$model]);

    }
    public function actionViewDocuments(){

    }
    public function actionCloseBidding($id){
        $model = new FormCloseNationalBidding(['buy_request_id' => $id]);
        $model->setScenario(FormCloseNationalBidding::SCENARIO_SELECT_WINNERS);
        if (Yii::$app->request->isPost) {
            $url = $model->loadInitialExpedientFilesUrl();
            $model->setScenario(BuyRequestInternational::SCENARIO_DEFAULT);
        }
        if ($model->load(Yii::$app->request->post()) ) {
            foreach ($model->ganadores as $ganadore){
                $winner = BuyRequestProvider::findOne($ganadore);
                $winner->winner=true;
                $winner->save();

            }
            $br = $model->buyRequest();
            $br->buy_request_status_id=BuyRequestStatus::$EVALUANDO_OFERTAS;
            $br->save(false);

            $model->generateFiledTree($url);
            Yii::$app->session->setFlash('success','Hemos presentado el expediente correctamente. Se ha generado el árbol de documentos necesarios para la aprobación.');
            return $this->redirect(['/buy-request/update', 'id' => $model->buyRequest()->id,'section'=>'documentos']);

        }


        return $this->renderAjax('_nacional_close_bidding',['model'=>$model]);
    }
    public function actionValidateMonitoring($id){
        $model = BuyRequestInternational::findOne($id);
        $model->setScenario(BuyRequestInternational::SCENARIO_START_TRANSPORTATION);
        if (Yii::$app->request->isAjax && $model->load(Yii::$app->request->post())) {

            Yii::$app->response->format = Response::FORMAT_JSON;
            return ActiveForm::validate($model);
            \Yii::$app->end();
        }
    }
    public function actionSendToMonitoring($id){
        $model = $this->findModel($id);
        switch ($model->buy_request_type_id){
            case BuyRequestType::$INTERNACIIONAL_ID:
                if($model->allDocumentOk()){

                    $form =BuyRequestInternational::findOne($model->buyRequestInternational->id);
                    $form->setScenario(BuyRequestInternational::SCENARIO_START_TRANSPORTATION);

                    if ($form->load(Yii::$app->request->post()) && $form->save()) {
                        $model->buy_request_status_id=BuyRequestStatus::$EN_PROCESO;
                        $model->save(false);
                        $current = $model->lastUploadDocumentDate();

                        foreach (Stage::getStagesByOrderType($model->buy_request_type_id) as $stage){
                            if($stage->order==2){
                                $d= $form->build_days-21;
                                $current = date('Y-m-d',strtotime($current."+ {$d} days"));
                            }elseif ($stage->order==8){
                                $d= $form->transport_days;
                                $current = date('Y-m-d',strtotime($current."+ {$d} days"));
                            }
                            $rs=new RequestStage();
                            $rs->buy_request_id=$id;
                            $rs->stage_id=$stage->id;
                            $rs->date_created=date('Y-m-d');
                            $rs->date_start=$current;
                            $next = date('Y-m-d',strtotime($current."+ {$rs->stage->duration} days"));
                            $rs->date_end=$next;
                            $rs->save(false);
                            $current=$next;
                        }
                        Yii::$app->session->setFlash('success','El ciclo de transportación ha sido iniciado. Por favor verifique las fechas de cumplimiento de cada hito.');
                        return $this->redirect(['/buy-request/update', 'id' => $model->id,'section'=>'transportation']);
                    }
                    return $this->renderAjax('_formTransportacion',['model'=>$form]);


                }else{
                    Yii::$app->session->setFlash('danger','No es posible terminar la evaluación de ofertas hasta que estén todos los documentos subidos y aprobados.');
                    return $this->redirect(['/buy-request/update', 'id' => $model->id]);
                }
                break;
            case BuyRequestType::$NACIONAL_ID:
                if($model->allDocumentOk()){
                        $model->buy_request_status_id=BuyRequestStatus::$EN_PROCESO;
                        $model->save(false);
                        $current = $model->lastUploadDocumentDate();
                        foreach (Stage::getStagesByOrderType($model->buy_request_type_id) as $stage){

                            $rs=new RequestStage();
                            $rs->buy_request_id=$id;
                            $rs->stage_id=$stage->id;
                            $rs->date_created=date('Y-m-d');
                            $rs->date_start=$current;
                            $next = date('Y-m-d',strtotime($current."+ {$rs->stage->duration} days"));
                            $rs->date_end=$next;
                            $rs->save(false);
                            $current=$next;
                        }
                        Yii::$app->session->setFlash('success','El ciclo de transportación ha sido iniciado. Por favor verifique las fechas de cumplimiento de cada hito.');
                        return $this->redirect(['/buy-request/update', 'id' => $model->id,'section'=>'transportation']);

                }else{
                    Yii::$app->session->setFlash('danger','No es posible terminar la evaluación de ofertas hasta que estén todos los documentos subidos y aprobados.');
                    return $this->redirect(['/buy-request/update', 'id' => $model->id]);
                }
                break;

        }



    }
    function dias_pasados($fecha_inicial,$fecha_final)
    {
        $dias = (strtotime($fecha_inicial)-strtotime($fecha_final))/86400;
        $dias = abs($dias); $dias = floor($dias);
        return $dias;
    }
    public function updateStage($id){


    }
    public function actionStageSuccess($id,$setSuccess=true){
        $model= RequestStage::findOne($id);
        $nextHito = $model->nextHito();
        if($nextHito){
            $model->nextHitoDate=$model->nextHito()->date_start;
        }

        if ($model->load(Yii::$app->request->post()) ) {
            if($setSuccess===true){
                $model->real_end=date('Y-m-d');
            }

            $dateStart= date('Y-m-d',strtotime($model->nextHitoDate));
            $model->save();
            if($nextHito&&$nextHito->date_start!=$dateStart){
                $dias = $this->dias_pasados($dateStart,$nextHito->date_start);
                $back=false;
                if(strtotime($dateStart)<strtotime($nextHito->date_start)){
                    $back=true;
                }
                $m=$nextHito;
                do{
                    if($back){
                        $m->date_start=date('Y-m-d',strtotime($m->date_start."- {$dias} days"));
                        $m->date_end=date('Y-m-d',strtotime($m->date_end."- {$dias} days"));
                    }else{
                        $m->date_start=date('Y-m-d',strtotime($m->date_start."+ {$dias} days"));
                        $m->date_end=date('Y-m-d',strtotime($m->date_end."+ {$dias} days"));
                    }

                    $m->save(false);
                    $m=$m->nextHito();


                    }while($m!=false);
            }


            if($model->buyRequest->cicloCompletado()){
                $model->buyRequest->buy_request_status_id=BuyRequestStatus::$CERRADA;
                $model->buyRequest->save(false);
                Yii::$app->session->setFlash('success','Has concluido el último hito. La orden ha sido cerrada.');
            }
            else{
                if($setSuccess===true){
                    Yii::$app->session->setFlash('success','Hito marcado como cumplido.');
                }else{
                    Yii::$app->session->setFlash('warning','Hito modificado.');
                }

            }

            return $this->redirect(['/buy-request/update', 'id' => $model->buy_request_id,'section'=>'transportation']);
        }
        return $this->renderAjax('_formHito',['model'=>$model]);








    }
    public function actionChangeBidding(){

    }
    public function actionUploadFileExpedient($id){
        if($id!='false'){
            $model = BuyRequestDocument::findOne($id);
            $model->setScenario(BuyRequestDocument::SCENARIO_UPLOAD_DOCUMENT);
        }else{
            $model = new BuyRequestDocument();

            $model->setScenario(BuyRequestDocument::SCENARIO_CUSTOM_DOCUMENT);
            $model->document_status_id=DocumentStatus::$APROBADO_ID;
            $model->evaluation=true;
            $model->buy_request_id=(int)Yii::$app->request->get('expediente');
        }

        if (Yii::$app->request->isPost) {
            $model->documento = UploadedFile::getInstance($model, 'documento');
            if($model->documento){
                $file= $model->upload();
                if($file){
                    $model->url_to_file = $file;
                    $model->setScenario(BuyRequestInternational::SCENARIO_DEFAULT);
                }
            }else{
                $emptyFile=true;
            }
        }
        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            if($model->evaluation){
                $model->document_status_id=DocumentStatus::$APROBADO_ID;
            }else{
                $model->document_status_id=DocumentStatus::$RECHAZADO_ID;
            }

            $model->last_update=date('Y-m-d');
            $model->last_updated_by=User::userLogged()->id;
            $model->created_date=date('Y-m-d');
            $model->save();
            Yii::$app->session->setFlash('success','Fichero subido correctamente');

            return $this->redirect(['/buy-request/update','id'=>$model->buy_request_id,
                'section'=>'documentos']);


        }
        return $this->renderAjax('_uploadFileExpedient',['model'=>$model]);
    }
    public function actionUpdateStage(){

    }

    public function actionUploadOtherDocs(){

    }
    public function actionViewTransportation(){

    }


}
