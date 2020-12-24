<?php

namespace app\controllers;

use app\models\BuyRequest;
use app\models\BuyRequest711;
use app\models\BuyRequest711Search;
use app\models\BuyRequestStatus;
use app\models\BuyRequestType;
use Yii;
use yii\filters\VerbFilter;
use yii\web\NotFoundHttpException;
use yii\web\Response;

/**
 * BuyRequest711Controller implements the CRUD actions for BuyRequest711 model.
 */
class BuyRequest711Controller extends MainController
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
        if (in_array($action->id, ['separate'])) {
            $this->enableCsrfValidation = false;
        }

        return parent::beforeAction($action);
    }

    /**
     * Lists all BuyRequest711 models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new BuyRequest711Search();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single BuyRequest711 model.
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
     * Creates a new BuyRequest711 model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate($request)
    {
        $model = new BuyRequest711();
        $model->buy_request_id = $request;
        $model->other_operation = 0;
        $model->plan = date('Y');

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            $model->buyRequest->buy_request_type_id = BuyRequestType::$TYPE_711;
            $model->buyRequest->code = $model->newCode();
            $model->buyRequest->save(false);
            Yii::$app->session->setFlash('success', 'Orden de compra convertida a 711');
            return $this->redirect(['/buy-request/update', 'id' => $model->buy_request_id, 'section' => '711']);
        }

        return $this->renderAjax('create', [
            'model' => $model,
        ]);
    }

    /**
     * Presentar el 711
     */
    public function actionPresentar($id)
    {
        $model = $this->findModel($id);

        $model->generateFiledTree();
        $model->buyRequest->buy_request_status_id = BuyRequestStatus::$EVALUANDO_OFERTAS;
        $model->buyRequest->approve_start=date('Y-m-d');
        $model->buyRequest->save(false);
        Yii::$app->session->setFlash('success','711 presentado correctamente.');
        return $this->redirect(['/buy-request/update', 'id' => $model->buy_request_id, 'section' => 'documentos']);


    }

    /**
     * Updates an existing BuyRequest711 model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            Yii::$app->session->setFlash('success', 'Lo datos de la orden fueron modificados correctamente.');
            return $this->redirect(['/buy-request/update', 'id' => $model->buy_request_id, 'section' => '711']);
        }

        return $this->renderAjax('update', [
            'model' => $model,
        ]);
    }

    public function actionSeparate()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $raw_data = json_decode(Yii::$app->request->getRawBody());
        $items = [];
        foreach ($raw_data->items as $item) {
            array_push($items, (int)$item);
        }
        $action = $raw_data->action;
        switch ($action) {
            case 'separarte_to_new':
                $request = BuyRequest::findOne($raw_data->demand);
                $newRequest = new BuyRequest([
                    'code' => $request->buyRequest711->newCode(),
                    'buy_request_type_id' => BuyRequestType::$TYPE_711,
                    'buy_request_status_id' => $request->buy_request_status_id,
                    'created' => $request->created,
                    'created_by' => $request->created_by,
                    'approved_date' => $request->approved_date,
                    'approved_by' => $request->approved_by,
                    'buyer_assigned' => $request->buyer_assigned,
                    'buy_approved_by' => $request->buy_approved_by,
                    'buy_approved_date' => $request->approved_date,
                    'dt_specialist_assigned' => $request->dt_specialist_assigned,
                    'dt_approved_date' => $request->dt_approved_date

                ]);
                $newRequest->save(false);
                $newRequest711 = new BuyRequest711([

                    'buy_request_id' => $newRequest->id,
                    'final_destiny_id' => $request->buyRequest711->final_destiny_id,
                    'plan' => $request->buyRequest711->plan,
                    'general_description' => $request->buyRequest711->general_description,
                    'other_operation' => $request->buyRequest711->other_operation,
                    'deployment_place' => $request->buyRequest711->deployment_place
                ]);
                $newRequest711->save(false);
                foreach ($request->demandItems as $demandItem) {
                    if (in_array($demandItem->validated_list_item_id, $items)) {
                        $demandItem->buy_request_id = $newRequest->id;
                        $demandItem->save(false);
                    }
                }
                return [
                    'success' => true,
                    'request_number' => $newRequest->code

                ];

                break;
            case 'insert_into_exist':
                break;
        }

    }

    /**
     * Deletes an existing BuyRequest711 model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        try{
            $this->findModel($id)->delete();
            Yii::$app->session->setFlash('success','Registro eliminado satisfactoriamente.');
        }catch (\Exception $exception){
            Yii::$app->session->setFlash('danger',"No podemos eliminar este elemento. Está siendo utilizado.");
        }


        return $this->redirect(['index']);
    }

    /**
     * Finds the BuyRequest711 model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return BuyRequest711 the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = BuyRequest711::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
