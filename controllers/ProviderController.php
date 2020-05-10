<?php

namespace app\controllers;

use app\models\ProviderValidatedList;
use Yii;
use app\models\Provider;
use app\models\ProviderSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * ProviderController implements the CRUD actions for Provider model.
 */
class ProviderController extends MainController
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
     * Lists all Provider models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new ProviderSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Provider model.
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
     * Creates a new Provider model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Provider();
        $model->active=true;

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            Yii::$app->session->setFlash('success',"Proveedor {$model->name} creado satisfactoriamente.");
            $insertions = [];
            foreach ($model->validated_list_associated as $id){
                array_push($insertions,
                    [
                        $model->id,
                        $id
                    ]);
            }
            Yii::$app->db->createCommand()->batchInsert('provider_validated_list',
                ['provider_id', 'validated_list_id'], $insertions)
                ->execute();
            return $this->redirect(['index']);
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }

    /**
     * Updates an existing Provider model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $model->loadValidatedList();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            ProviderValidatedList::deleteAll(['provider_id'=>$model->id]);
            Yii::$app->session->setFlash('success',"Proveedor {$model->name} actualizado satisfactoriamente.");
            $insertions = [];
            foreach ($model->validated_list_associated as $id){
                array_push($insertions,
                    [
                        $model->id,
                        $id
                    ]);
            }
            Yii::$app->db->createCommand()->batchInsert('provider_validated_list',
                ['provider_id', 'validated_list_id'], $insertions)
                ->execute();
            return $this->redirect(['index']);
        }

        return $this->render('update', [
            'model' => $model,
        ]);
    }

    /**
     * Deletes an existing Provider model.
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
     * Finds the Provider model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Provider the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Provider::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
