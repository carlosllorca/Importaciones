<?php

namespace app\controllers;

use app\models\CertificationValidatedListItem;
use app\models\ValidatedList;
use Yii;
use app\models\ValidatedListItem;
use app\models\ValidatedListItemSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * ValidatedListItemController implements the CRUD actions for ValidatedListItem model.
 */
class ValidatedListItemController extends Controller
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
     * Lists all ValidatedListItem models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new ValidatedListItemSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single ValidatedListItem model.
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
     * Creates a new ValidatedListItem model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate($vl)
    {
        $model = new ValidatedListItem();
        $vl = ValidatedList::findOne($vl);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            if($model->certificados){
                foreach ($model->certificados as $id){
                    $certificado =new CertificationValidatedListItem();
                    $certificado->certification_id=$id;
                    $certificado->validated_list_item_id=$model->id;
                    $certificado->save();
                }
            }
            return $this->redirect(['validated-list-item/update', 'id' => $model->vl]);
        }

        return $this->render('create', [
            'model' => $model,
            'vl'=>$vl
        ]);
    }

    /**
     * Updates an existing ValidatedListItem model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $model->certificados = $model->certificados();


        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            CertificationValidatedListItem::deleteAll(['validated_list_item_id'=>$model->id]);
            if($model->certificados){
                foreach ($model->certificados as $id){
                    $certificado =new CertificationValidatedListItem();
                    $certificado->certification_id=$id;
                    $certificado->validated_list_item_id=$model->id;
                    $certificado->save();
                }
            }
            return $this->redirect(['validated-list/update', 'id' => $model->subfamily->validated_list_id]);
        }

        return $this->render('update', [
            'model' => $model,
            'vl'=>$model->subfamily->validated_list_id
        ]);
    }

    /**
     * Deletes an existing ValidatedListItem model.
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
     * Finds the ValidatedListItem model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return ValidatedListItem the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = ValidatedListItem::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
