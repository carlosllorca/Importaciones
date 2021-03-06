<?php

namespace app\controllers;

use app\models\BuyRequest;
use app\models\BuyRequestStatus;
use app\models\BuyRequestType;
use app\models\DataGraphics;
use app\models\DemandItem;
use app\models\DemandItemSearch;
use app\models\DemandStatus;
use app\models\DeploymentPart;
use app\models\PurchaseReason;
use app\models\Rbac;
use app\models\SellerRequirement;
use app\models\User;
use app\models\ValidatedListItemSearch;
use app\models\WarrantyTime;
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
            case Rbac::$LOGISTICA_ID:
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
    public function actionApprove($id,$return=false){
        $model = $this->findModel($id);
        $model->demand_status_id=DemandStatus::ACEPTADA_ID;
        $model->approved_by=Yii::$app->user->identity->id;
        $model->approved_date=date('Y-m-d');
        $model->save(false);
        Yii::$app->traza->saveLog('Demanda aceptada','La Demanda '.$model->demand_code. ' ha sido aceptada');
        Yii::$app->session->setFlash('success',"Se ha aprobado la demanda ".$model->demand_code.".");
        try{


            Yii::$app->mailer->compose('demandApproved', ['demand'=>$model])
                ->setFrom([Yii::$app->params['senderEmail']=>Yii::$app->params['senderName']])
                ->setTo([$model->createdBy->email=>$model->createdBy->full_name])
                // ->setBcc('inmaj@codeberrysolutions.com')
                ->setSubject("Se ha aprobado la demanda ".$model->demand_code.".")
                ->send();
        }catch (\Exception $e){
            Yii::$app->session->setFlash('warning','Ocurrió un problema en el envio de correo.');
        }
        if($return){
            return $this->redirect($return);
        }

        return $this->redirect('index');


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
        Yii::$app->traza->saveLog('Demanda rechazada.','La Demanda '.$model->id. ' ha sido rechazada');
        try{


            Yii::$app->mailer->compose('demandRejected', ['demand'=>$model])
                ->setFrom([Yii::$app->params['senderEmail']=>Yii::$app->params['senderName']])
                ->setTo([$model->createdBy->email=>$model->createdBy->full_name])
                // ->setBcc('inmaj@codeberrysolutions.com')
                ->setSubject("Se ha rechazado la demanda ".$model->demand_code.".")
                ->send();
        }catch (\Exception $e){
            Yii::$app->session->setFlash('warning','Ocurrió un problema en el envio de correo.');
        }
        Yii::$app->session->setFlash('success','Demanda rechazada.');
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
        $model->purchase_reason_id=PurchaseReason::$COMPRAR_ID;
        $model->deployment_part_id=DeploymentPart::UN_PLAZO;
        $model->created_date=date('Y-m-d');
        $model->demand_status_id=DemandStatus::BORRADOR_ID;
        $model->waranty_time_id=WarrantyTime::UN_ANNO_ID;
        $model->seller_requirement_id=SellerRequirement::NINGUNA_ID;

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
            Yii::$app->traza->saveLog('Item cancelado',"El item ".$model->validatedListItem->product_name .
                ' ('.$model->quantity.') fue rechazado.');
            try{
                Yii::$app->mailer->compose('demandItemRejected', ['item'=>$model])
                    ->setFrom([Yii::$app->params['senderEmail']=>Yii::$app->params['senderName']])
                    ->setTo([$model->demand->createdBy->email=>$model->demand->createdBy->full_name])
                    // ->setBcc('inmaj@codeberrysolutions.com')
                    ->setSubject("Se ha cancelado un producto de la demanda ".$model->demand->demand_code.".")
                    ->send();
            }catch (\Exception $e){
                Yii::$app->session->setFlash('warning','Ocurrió un problema en el envio de correo.');
            }
            return ['success'=>true];
        }else{
            return ['success'=>false,'msg'=>json_encode($model->getErrors())];
        }


    }
    public function actionSend($id){
        $model = $this->findModel($id);
        if(!$model->demandItems){
            Yii::$app->session->setFlash('danger','Debe especificar al menos un producto a demandar.');
            return  $this->redirect(['demand-products','id'=>$id]);
        }
        $model->demand_status_id=DemandStatus::ENVIADA_ID;
        $model->sending_date=date('Y-m-d H:i:s');
        if(!$model->demand_code){
            $model->demand_code=$model->setDemandCode();
        }
        if($model->validate()){
            $model->save();
            Yii::$app->traza->saveLog('Demanda enviada','Se ha enviado la demanda '.$model->demand_code);
            try{
                $to=[];
                $users = User::getActiveUsersByRol(Rbac::$LOGISTICA_ID);
                foreach ($users as $user){
                    $to[$user->email]=$user->full_name;
                }
                Yii::$app->mailer->compose('demandArrived', ['demand'=>$model])
                    ->setFrom([Yii::$app->params['senderEmail']=>Yii::$app->params['senderName']])
                    ->setTo($to)
                    // ->setBcc('inmaj@codeberrysolutions.com')
                    ->setSubject("Se ha registrado una nueva demanda.")
                    ->send();
            }catch (\Exception $e){
                Yii::$app->session->setFlash('warning','Ocurrió un problema en el envio de correo.');
            }

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
        $demandItems=[];
        $masDemandados = DataGraphics::masDemandados($model->validated_list_id);

        foreach ($model->demandItems as $demandItem){
           $demandItems[$demandItem->validated_list_item_id]=[
               'cantidad'=>$demandItem->quantity,
               'precio'=>$demandItem->price,
               'importe'=>Yii::$app->formatter->asCurrency($demandItem->quantity*$demandItem->price)
           ];
        }
        return $this->render('demand_products',['model'=>$model,'arrayItems'=>$demandItems,'masDemandados'=>$masDemandados]);

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
                try{
                    $users = User::getActiveUsersByRol(Rbac::$JEFE_LOGÍSTICA);
                    $to =[];
                    foreach ($users as $user){
                        $to[$user->email]=$user->full_name;
                    }
                    Yii::$app->traza->saveLog('solicitud de compra creada','Se ha creado la solicitud de compra '.$buyRequest->code);
                    Yii::$app->mailer->compose('buyRequestCreated', ['buyRequest'=>$buyRequest])
                        ->setFrom([Yii::$app->params['senderEmail']=>Yii::$app->params['senderName']])
                        ->setTo($to)
                        // ->setBcc('inmaj@codeberrysolutions.com')
                        ->setSubject("Se ha generado una nueva solicitud de compra con código ".$buyRequest->code.".")
                        ->send();
                }catch (\Exception $e){
                    Yii::$app->session->setFlash('warning','Ocurrió un problema en el envio de correo.');
                }
                break;
            case 'internacional_exist':
            case 'nacional_exist':
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
                try{
                    $users = User::getActiveUsersByRol(Rbac::$JEFE_LOGÍSTICA);
                    $to =[];
                    foreach ($users as $user){
                        $to[$user->email]=$user->full_name;
                    }
                    Yii::$app->traza->saveLog('solicitud de compra creada','Se ha creado la solicitud de compra '.$buyRequest->code);
                    Yii::$app->mailer->compose('buyRequestCreated', ['buyRequest'=>$buyRequest])
                        ->setFrom([Yii::$app->params['senderEmail']=>Yii::$app->params['senderName']])
                        ->setTo($to)
                        // ->setBcc('inmaj@codeberrysolutions.com')
                        ->setSubject("Se ha generado una nueva solicitud de compra con código ".$buyRequest->code.".")
                        ->send();
                }catch (\Exception $e){
                    Yii::$app->session->setFlash('warning','Ocurrió un problema en el envio de correo.');
                }
                $request_number=$buyRequest->code;
                break;
            default:
                throw new Exception("Bad request.");

        }
        Yii::$app->session->setFlash('active','items');
        $demand = Demand::findOne($demand_id);
        if($demand->demand_status_id==DemandStatus::ENVIADA_ID){
          $demand->demand_status_id=DemandStatus::ACEPTADA_ID;
          $demand->save();
              //todo:Enviar email notificando
            Yii::$app->traza->saveLog('Demanda aceptada','La Demanda '.$demand->demand_code. ' ha sido aceptada');
            Yii::$app->session->setFlash('success','Demanda aceptada');
        }
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
