<?php

namespace app\controllers;

use app\models\BuyRequestStatus;
use app\models\DemandItem;
use app\models\DemandStatus;
use Mpdf\Tag\U;
use Yii;
use app\models\BuyRequest;
use app\models\BuyRequestSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use Mpdf\Mpdf;
use Mpdf\Config\ConfigVariables;
use Mpdf\Config\FontVariables;
use yii\web\Response;

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
        if (in_array($action->id ,[ 'assign-user'])) {
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
        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        }
        if(Yii::$app->user->can('buyrequest/viewassociateddemands')){
            $active = 'demands_associated';

        }elseif (Yii::$app->user->can('buyrequest/viewproducts')){
            $active = 'products';
        }
        return $this->render('update', [
            'model' => $model,
            'active'=>$active
        ]);
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
    public function actionExport($id=false){
        $model = null;
        // return the pdf output as per the destination setting
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;

        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
        $model = $this->findModel($id);

        $mpdf = new Mpdf();
        //return $this->renderPartial('/buy-request/export',['model'=>$model]);
        $mpdf->WriteHTML($this->renderPartial('/buy-request/export'),2);
        $mpdf->Output();
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
            $model->save();
            Yii::$app->session->setFlash('success','Órden asignada al comprador '.$model->buyerAssigned->full_name.'.');
        }
        elseif ($rol=='et'){

            $model->dt_specialist_asigned=(int)($user);
            $model->save();
            Yii::$app->session->setFlash('success','Órden asignada al especialista técnico '.$model->dtSpecialistAssigned->full_name.'.');
        }

        return ['success'=>true];
    }
    public function actionAssignbuyer(){

    }
    public function actionAssignet(){

    }


}
