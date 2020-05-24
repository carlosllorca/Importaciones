<?php

namespace app\controllers;

use app\models\Organism;
use app\models\Rbac;
use Yii;
use app\models\Client;
use app\models\ClientSearch;
use yii\rbac\Role;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * ClientController implements the CRUD actions for Client model.
 */
class ClientController extends MainController
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
     * Lists all Client models.
     * @return mixed
     */
    public function actionIndex()
    {
        switch (Rbac::getRole()){
            case Rbac::$UEB:
                return $this->uebIndex();
                break;
            default:
                return$this->normalIndex();
        }
    }
    private function uebIndex(){
        $searchModel = new ClientSearch();
        $searchModel->province_ueb=Yii::$app->user->identity->province_ueb;
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);
        return $this->render('_uebIndex', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }
    public function actionCombo(){
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;

        if (isset($_POST['depdrop_parents'])) {
            $ids = $_POST['depdrop_parents'];
            $cat_id = empty($ids[0]) ? null : $ids[0];
            $subcat_id = empty($ids[1]) ? null : $ids[1];
            if ($cat_id != null) {
                $models = Client::find()->where(['organism_id'=>$cat_id]);

                if(Rbac::getRole()==Rbac::$UEB){
                    $models->andWhere(['province_ueb'=>Yii::$app->user->identity->province_ueb]);
                }
                $models = $models->all();

                $out=[];
                foreach ($models as $client){
                    array_push($out,[
                       'id'=>$client->id,
                       'name'=>$client->name
                    ]);
                }
                /**
                 * the getProdList function will query the database based on the
                 * cat_id and sub_cat_id and return an array like below:
                 *  [
                 *      'out'=>[
                 *          ['id'=>'<prod-id-1>', 'name'=>'<prod-name1>'],
                 *          ['id'=>'<prod_id_2>', 'name'=>'<prod-name2>']
                 *       ],
                 *       'selected'=>'<prod-id-1>'
                 *  ]
                 */

                return ['output'=>$out, 'selected'=>''];
            }
        }
        return ['output'=>'', 'selected'=>''];
    }
    private function normalIndex(){
        $searchModel = new ClientSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);
        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Client model.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        return $this->redirect('index');
    }

    /**
     * Creates a new Client model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Client();
        if(Rbac::getRole()==Rbac::$UEB){
            $model->province_ueb=Yii::$app->user->identity->province_ueb;
        }

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }

    /**
     * Updates an existing Client model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        }

        return $this->render('update', [
            'model' => $model,
        ]);
    }

    /**
     * Deletes an existing Client model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        try{
            $this->findModel($id)->delete();
        }catch (\Exception $e){
            Yii::$app->session->setFlash('danger','No podemos elimianr este cliente. Está siendo utilizado.');
        }


        return $this->redirect(['index']);
    }

    /**
     * Finds the Client model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Client the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Client::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
