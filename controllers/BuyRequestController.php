<?php

namespace app\controllers;

use app\models\BuyRequest;
use app\models\BuyRequestProvider;
use app\models\BuyRequestSearch;
use app\models\BuyRequestStatus;
use app\models\BuyRequestType;
use app\models\DemandItem;
use app\models\DemandStatus;
use app\models\Destiny;
use app\models\Offert;
use app\models\PaymentInstrument;
use app\models\Provider;
use app\models\ProviderStatus;
use app\models\User;
use Mpdf\Config\ConfigVariables;
use Mpdf\Config\FontVariables;
use Mpdf\Mpdf;
use Yii;
use yii\filters\VerbFilter;
use yii\web\ForbiddenHttpException;
use yii\web\NotFoundHttpException;
use yii\web\Response;
use yii\web\UploadedFile;
use yii\widgets\ActiveForm;

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

    /**
     * Updates an existing BuyRequest model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $active = 'demands_associated';
        if($model->buy_request_type_id==BuyRequestType::$INTERNACIIONAL_ID){
            $model->setScenario(BuyRequest::SCENARIO_GENERATE_LICITACION);
            $model->destiny_id=Destiny::$HABANA_ID;
            $model->payment_instrument_id=PaymentInstrument::$CC_A__LA_VISTA;
        }

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            if(!$model->buyRequestProviders){
                foreach (Provider::related($model->arrayValidatedList()) as $provider){
                    $m=new BuyRequestProvider();
                    $m->buy_request_id=$model->id;
                    $m->provider_id=$provider->id;
                    $m->provider_status_id=ProviderStatus::$SOLICITUD_ENVIADA_ID;
                    $m->save();
                }
            }
            $active= 'propuestas';
            return $this->render('update', [
                'model' => $model,
                'active'=>$active
            ]);

            return $this->redirect(['view', 'id' => $model->id]);
        }
        if(Yii::$app->user->can('buyrequest/viewassociateddemands')){
            $active = 'demands_associated';

        }elseif (Yii::$app->user->can('buyrequest/viewproducts')){
            $active = 'products';
        }

        if(Yii::$app->request->isPost){
            $active= 'propuestas';
        }
        if(Yii::$app->request->get('provider')){
            $active= 'propuestas';
        }
        return $this->render('update', [
            'model' => $model,
            'active'=>$active
        ]);
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
        $model->gol_approved=true;
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
    public function actionExport($id,$format){
        $model = null;
        // return the pdf output as per the destination setting
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;

        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
        $model = $this->findModel($id);
        switch ($format){
            case 'pdf':
                $this->pdfSolicitudCompra($model);
                break;
            case 'xls':
                $this->xlsSolicitudCompra($model);
                break;
            default:
                throw  new ForbiddenHttpException('Formato incorrecto');
                break;
        }


    }
    private function pdfSolicitudCompra($model){
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
       $mpdf->AddPage();
        $mpdf->WriteHTML($this->renderPartial('/buy-request/_pdf_solicitud_compra_productos',['model'=>$model]),2);
        $mpdf->Output();
    }
    private function xlsSolicitudCompra(){

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
            Yii::$app->session->setFlash('success','Órden asignada al comprador '.$model->buyerAssigned->full_name.'.');
        }
        elseif ($rol=='et'){

            $model->dt_specialist_asigned=(int)($user);
            $model->save(false);
            Yii::$app->session->setFlash('success','Órden asignada al especialista técnico '.$model->dtSpecialistAssigned->full_name.'.');
        }

        return ['success'=>true];
    }
    public function actionAssignbuyer(){

    }
    public function actionAssignet(){

    }
    public function actionUploadOffert(){

    }
    public function actionSaveOfert(){
        $model = new Offert();

        if (Yii::$app->request->isPost) {
            $model->oferta = UploadedFile::getInstance($model, 'oferta');
            if($model->oferta){
                $file= $model->upload();
                if($file){
                    $model->url_file = $file;
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


        }else{
            var_dump($model->getErrors());
        }
    }
    public function actionValidateOfert(){
        $model = new Offert();

        if (Yii::$app->request->isAjax && $model->load(Yii::$app->request->post())) {
            Yii::$app->response->format = Response::FORMAT_JSON;
            return ActiveForm::validate($model);
            Yii::$app->end();
        }
    }
    public function actionEvaluateOffert($id){
        $model= Offert::findOne($id);
        if (Yii::$app->request->isPost) {
            $model->evaluacion = UploadedFile::getInstance($model, 'evaluacion');
            if($model->evaluacion){
                $file= $model->uploadEvaluation();
                if($file){
                    $model->url_evaluation = $file;
                }
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
        $model = $this->findModel($id);

        if (Yii::$app->request->isPost) {
            $url = $model->loadInitialExpedientFilesUrl();
        }

        if ($model->load(Yii::$app->request->post()) ) {
                foreach ($model->ganadores as $ganadore){
                    $winner = BuyRequestProvider::findOne($ganadore);
                    $winner->winner=true;
                    $winner->save();

                }
                $model->buy_request_status_id=BuyRequestStatus::$EVALUANDO_OFERTAS;
                $model->save(false);
                $model->generateFiledTree($url);
                Yii::$app->session->setFlash('success','Hemos presentado el expediente correctamente. Se ha generado el árbol de documentos necesarios para la aprobación.');
                return $this->redirect(['/buy-request/update', 'id' => $model->id]);

        }else{
            Yii::$app->session->setFlash('danger','Ocurrió un error procesando los datos. Inténtelo de nuevo más tarde.');
            return $this->redirect(['/buy-request/update', 'id' => $model->id]);
        }
    }
    public function actionViewDocuments(){

    }


}
