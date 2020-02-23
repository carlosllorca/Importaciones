<?php

namespace app\controllers;

use app\models\BuyRequest;
use app\models\BuyRequestStatus;
use app\models\BuyRequestType;
use app\models\DemandItem;
use app\models\DemandItemSearch;
use app\models\DemandStatus;
use app\models\Rbac;
use app\models\User;
use app\models\ValidatedListItemSearch;
use Yii;
use app\models\Demand;
use app\models\DemandSearch;
use yii\db\Exception;
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
        if (in_array($action->id ,[ 'reject','clasify','divide','cancel-item'])) {
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
            case Rbac::$JEFE_LOGÍSTICA:
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
        $dataProvider->sort=false;
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
    public function actionCancelItem(){
        $this->enableCsrfValidation=false;
        Yii::$app->session->setFlash('active','items');
        Yii::$app->response->format = Response::FORMAT_JSON;
        $raw_data = Yii::$app->request->getRawBody();
        $msg= json_decode($raw_data )->msg;
        $item= json_decode($raw_data )->item;
        $model = DemandItem::findOne($item);
        $model->cancelled = true;
        $model->cancelled_msg=$msg;
        if($model->validate()){
            $model->save();
            return ['success'=>true];
        }else{
            return ['success'=>false,'msg'=>json_encode($model->getErrors())];
        }


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
    public function actionDivide(){
        Yii::$app->response->format = Response::FORMAT_JSON;
        Yii::$app->session->setFlash('active','items');
        $raw_data = json_decode(Yii::$app->request->getRawBody());
        $item=DemandItem::findOne($raw_data->items);
        $part= (int)$raw_data->part;
        if($part<1){
            return ['success'=>false,'error'=>'La unidad mínima de división es 1.'];
        }elseif ($item->quantity<=1){
            return ['success'=>false,'error'=>'El producto no puede ser dividido en más partes.'];
        }elseif ($item->quantity<=$part){
            return ['success'=>false,'error'=>'La cantidad solicitada debe ser menor que la cantidad original.'];
        }else{
            $newItem = new DemandItem();
            $newItem->demand_id= $item->demand_id;
            $newItem->validated_list_item_id=$item->validated_list_item_id;
            $newItem->price=$item->price;
            $newItem->quantity=$part;
            $newItem->save();
            $item->quantity = $item->quantity-$newItem->quantity;
            $item->save();
        }


        return ['success'=>true];
    }
    public function actionDeleteItem($id){
        $model = DemandItem::findOne($id);
        $demandId=$model->demand_id;
        try{

            $model->delete();
            Yii::$app->session->setFlash('Elemento eliminado correctamente');

        }catch (\Exception $e){
            Yii::$app->session->setFlash('danger','No ha sido posible eliminar el elemento.');
        }
        return $this->redirect(['/demand/demand-products','id'=>$demandId]);
    }
    public function actionClasify(){
        Yii::$app->response->format = Response::FORMAT_JSON;
        $raw_data = json_decode(Yii::$app->request->getRawBody());
        $demand_id=$raw_data->demand;
        $items= $raw_data->items;
        $request_number=null;
        switch ($raw_data->action){
            case 'internal_distribution':
                DemandItem::updateAll([
                    'internal_distribution'=>true,
                ],[
                    'id'=>$items
                ]);
                break;
            case 'nacional_request':
                $buyRequest = new BuyRequest();
                $buyRequest->buy_request_type_id= BuyRequestType::$NACIONAL_ID;
                $buyRequest->buy_request_status_id=BuyRequestStatus::$BORRADOR_ID;
                $buyRequest->created_by=User::userLogged()->id;
                $buyRequest->created=date('Y-m-d');
                try {
                    $buyRequest->setCode();
                } catch (ForbiddenHttpException $e) {
                    throw new Exception($e->getMessage());
                }
                $buyRequest->save();
                DemandItem::updateAll([
                    'buy_request_id'=>$buyRequest->id,
                ],[
                    'id'=>$items
                ]);
                $request_number=$buyRequest->code;
                break;
            case 'nacional_exist':
                $request=$raw_data->solicitud;
                DemandItem::updateAll([
                    'buy_request_id'=>$request,
                ],[
                    'id'=>$items
                ]);

                break;
            case 'internacional_exist':
                $request=$raw_data->solicitud;
                DemandItem::updateAll([
                    'buy_request_id'=>$request,
                ],[
                    'id'=>$items
                ]);

                break;
            case 'internacional_request':
                $buyRequest = new BuyRequest();
                $buyRequest->buy_request_type_id= BuyRequestType::$INTERNACIIONAL_ID;
                $buyRequest->buy_request_status_id=BuyRequestStatus::$BORRADOR_ID;
                $buyRequest->created_by=User::userLogged()->id;
                $buyRequest->created=date('Y-m-d');
                try {
                    $buyRequest->setCode();
                } catch (ForbiddenHttpException $e) {
                    throw new Exception($e->getMessage());
                }
                $buyRequest->save();
                DemandItem::updateAll([
                    'buy_request_id'=>$buyRequest->id,
                ],[
                    'id'=>$items
                ]);
                $request_number=$buyRequest->code;
                break;
            default:
                throw new Exception("Bad request.");

        }
        Yii::$app->session->setFlash('active','items');
        $demand = Demand::findOne($demand_id);
        if(count($demand->sinClasificar())==0){
            $demand->demand_status_id=DemandStatus::TRAMITADA_ID;
            $demand->save();
        }
        return [
            'success'=>true,
            'items'=>$items,
            'request_number'=>$request_number
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
