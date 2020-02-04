<?php

namespace app\controllers;

use app\models\DemandItem;
use app\models\DemandItemSearch;
use app\models\DemandStatus;
use app\models\Rbac;
use app\models\User;
use app\models\ValidatedListItemSearch;
use Yii;
use app\models\Demand;
use app\models\DemandSearch;
use yii\web\Controller;
use yii\web\ForbiddenHttpException;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\Response;

/**
 * DemandController implements the CRUD actions for Demand model.
 */
class DemandController extends MainController
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
        if (in_array($action->id ,[ 'reject','clasify'])) {
            $this->enableCsrfValidation = false;
        }

        return parent::beforeAction($action);
    }

    /**
     * Lists all Demand models.
     * @return mixed
     */
    public function actionIndex()
    {
        switch (Rbac::getRole()){
            case Rbac::$UEB:
                return $this->_uebIndex();
                break;
            case Rbac::$ESP_TECNICO:
                return $this->_dtIndex();
                break;

            default:
                throw new ForbiddenHttpException("Esta sección no esta preparada para usuarios con su rol");
        }
    }
    private function _uebIndex(){
        $searchModel = new DemandSearch();

        $dataProvider = $searchModel->searchUeb(Yii::$app->request->queryParams);

        return $this->render('_ueb_index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }
    public function _dtIndex(){
        $searchModel = new DemandSearch();

        $dataProvider = $searchModel->searchDT(Yii::$app->request->queryParams);

        return $this->render('_dt_index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }
    public function actionApprove($id){
        $model = $this->findModel($id);
        $model->demand_status_id=DemandStatus::ACEPTADA_ID;
        $model->approved_by=Yii::$app->user->identity->id;
        $model->approved_date=date('Y-m-d');
        $model->save(false);
        Yii::$app->traza->saveLog('Demanda aceptada','La Demanda '.$model->demand_code. ' ha sido aceptada');
        Yii::$app->session->setFlash('success','Demanda aceptada');
        return $this->redirect('index');
        //todo: Enviar email a la UEB para notificar.

    }
    public function actionReject(){
        $this->enableCsrfValidation=false;
        Yii::$app->response->format = Response::FORMAT_JSON;

        $raw_data = Yii::$app->request->getRawBody();
        $cc= json_decode($raw_data )->demand;
        $reason= json_decode($raw_data )->reason;


        $model = $this->findModel($cc);
        $model->demand_status_id=DemandStatus::RECHAZADA_ID;
        $model->rejected_reason=$reason;
        $model->save(false);
        Yii::$app->traza->saveLog('Demanda rechazada','La Demanda '.$model->id. ' ha sido rechazada');
        Yii::$app->session->setFlash('success','Demanda rechazada');
        return ['success'=>true];
        //todo: Enviar email a la UEB para notificar.

    }

    /**
     * Displays a single Demand model.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        $searchModel = new DemandItemSearch();
        $searchModel->demand_id=$id;
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);
        $active ='requirements';
        $session = Yii::$app->session->getFlash('active');
        if($session){
            $active=$session;
        }

        return $this->render('view', [
            'model' => $this->findModel($id),
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
            'active'=>$active
        ]);
    }

    /**
     * Creates a new Demand model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Demand();
        $model->created_by=Yii::$app->user->identity->id;
        $model->created_date=date('Y-m-d');
        $model->demand_status_id=DemandStatus::BORRADOR_ID;

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            Yii::$app->traza->saveLog('Demanda creada','Se ha creado una demanda con ID'.$model->id);
            return $this->redirect(['demand-products', 'id' => $model->id]);
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }
    public function actionSend($id){
        $model = $this->findModel($id);
        $model->demand_status_id=DemandStatus::ENVIADA_ID;
        $model->sending_date=date('Y-m-d H:i:s');
        if(!$model->demand_code){
            $model->demand_code=$model->setDemandCode();
        }
        if($model->validate()){
            $model->save();
            Yii::$app->traza->saveLog('Demanda enviada','Se ha enviado la demanda '.$model->demand_code);
            Yii::$app->session->setFlash('success',"La demanda {$model->demand_code} ha sido enviada.");
        }else{
            Yii::$app->session->setFlash('danger','Error al procesar su solicitud. Inténtelo de nuevo más tarde.');
        }

        return $this->redirect('index');
    }

    /**
     * Updates an existing Demand model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $model->organism=$model->client->organism_id;


        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['demand-products', 'id' => $model->id]);
        }

        return $this->render('update', [
            'model' => $model,
        ]);
    }
    public function actionDemandProducts($id){
        $model = $this->findModel($id);

        $demandItem= new DemandItem();
        $demandItem->demand_id=$model->id;

        return $this->render('demand_products',['model'=>$model,'demandItem'=>$demandItem]);

    }

    /**
     * Deletes an existing Demand model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }
    public function actionClasify(){
        Yii::$app->response->format = Response::FORMAT_JSON;
        $raw_data = json_decode(Yii::$app->request->getRawBody());
        $items= $raw_data->items;
        switch ($raw_data->action){
            case 'internal_distribution':
                DemandItem::updateAll([
                    'internal_distribution'=>true,
                ],[
                    'id'=>$items
                ]);
                break;
        }
        Yii::$app->session->setFlash('active','items');
        return [
            'success'=>true,
            'items'=>$items
        ];

    }

    /**
     * Finds the Demand model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Demand the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Demand::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
