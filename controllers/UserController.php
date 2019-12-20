<?php

namespace app\controllers;

use app\models\Rbac;
use Yii;
use app\models\User;
use app\models\UserSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * UserController implements the CRUD actions for User model.
 */
class UserController extends MainController
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
     * Lists all User models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new UserSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single User model.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
      return  $this->redirect(['update','id'=>$id]);
    }

    /**
     * Creates a new User model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new User();
        $model->setScenario(User::SCENARIO_CREATE_USER);
        $model->created_at= date('Y-m-d');
        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            $model->created_at= date('Y-m-d');
            $model->active=true;
            $model->password = Yii::$app->getSecurity()->generatePasswordHash($model->password);
            Rbac::changeRole($model->username,$model->rol);
            $model->save(false);
            Yii::$app->traza->saveLog('Agregar Usuario', "Fue añadido el usuario {$model->username} al sistema.");
            Yii::$app->session->setFlash('success','Usuario creado correctamente.');
            return $this->redirect(['index']);
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }
    public function actionLogs($id){
        $user = $this->findModel($id);
        return $this->render('logs',['model'=>$user]);

    }

    /**
     * Updates an existing User model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $model->rol= Rbac::getRole($model->username);
        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            Rbac::changeRole($model->id,$model->rol);
            Yii::$app->traza->saveLog('Actualizar Usuario', "Actualizados los datos de {$model->username}.");
            return $this->redirect(['index']);
        }
        return $this->render('update', [
            'model' => $model,
        ]);
    }

    /**
     * Deletes an existing User model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDisable($id)
    {
        if($id==2){
            Yii::$app->session->setFlash('danger','Lo sentimos el usuario principal no puede ser desactivado');
            return $this->redirect(['index']);
        }
        try{
            $user = $this->findModel($id);

            $user->active = !$user->active;
            $user->save();
            if($user->active){
                Yii::$app->session->setFlash('success',"Usuario activado");
                Yii::$app->traza->saveLog('Usuario activado', "El usuario {$user->username} fue activado.");
            }else{
                Yii::$app->session->setFlash('success',"Usuario desactivado");
                Yii::$app->traza->saveLog('Usuario desactivado', "El usuario {$user->username} fue desactivado.");
            }

        }catch (\Exception $exception){
           // Yii::$app->session->setFlash('danger',"No podemos eliminar este elemento. Está siendo utilizado.");
        }
        return $this->redirect(['index']);
    }


    /**
     * Finds the User model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return User the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = User::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
