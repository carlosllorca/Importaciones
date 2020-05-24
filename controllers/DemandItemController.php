<?php

namespace app\controllers;

use app\models\Demand;
use app\models\ValidatedListItem;
use Yii;
use app\models\DemandItem;
use app\models\DemandItemSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * DemandItemController implements the CRUD actions for DemandItem model.
 */
class DemandItemController extends Controller
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
     * Lists all DemandItem models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new DemandItemSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single DemandItem model.
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
     * Creates a new DemandItem model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate($vl)
    {
        $demand= Demand::findOne($vl);
        $model = new DemandItem();
        $model->demand_id=$demand->id;
        $model->price=0;
        if ($model->load(Yii::$app->request->post()) ) {
            $model->price = $model->validatedListItem->price;
            if($model->validate()&&$model->save()){
                return $this->redirect(['demand/demand-products', 'id' => $model->demand_id]);
            }
        }

        return $this->render('create', [
            'model' => $model,
            'vl'=>$demand->validated_list_id
        ]);
    }
    public function actionProductDetails($product){
        $model = ValidatedListItem::findOne($product);
        return $this->renderPartial('productDetails',['mdodel'=>$model]);
    }

    /**
     * Updates an existing DemandItem model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);


        if ($model->load(Yii::$app->request->post())) {
            $model->price = $model->validatedListItem->price;
            if($model->validate()&&$model->save()){
                return $this->redirect(['demand/demand-products', 'id' => $model->demand_id]);
            }

        }

        return $this->render('update', [
            'model' => $model,
        ]);
    }

    /**
     * Deletes an existing DemandItem model.
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
     * Finds the DemandItem model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return DemandItem the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = DemandItem::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
