<?php

namespace app\controllers;

use app\models\DemandItem;
use app\models\DemandStatus;
use app\models\Rbac;
use app\models\ValidatedListItemSearch;
use Yii;
use app\models\Demand;
use app\models\DemandSearch;
use yii\web\Controller;
use yii\web\ForbiddenHttpException;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

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
     * Lists all Demand models.
     * @return mixed
     */
    public function actionIndex()
    {
        switch (Rbac::getRole()){
            case Rbac::$UEB:
                return $this->_uebIndex();
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

    /**
     * Displays a single Demand model.
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
        $model->save();
        Yii::$app->traza->saveLog('Demanda enviada','Se ha enviado la demanda con ID'.$model->id);
        Yii::$app->session->setFlash('success',"Su demanda ha sido enviada");
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
