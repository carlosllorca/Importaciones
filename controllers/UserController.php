<?php

namespace app\controllers;

use app\models\ChangePasswordForm;
use app\models\DocumentTypePermission;
use app\models\Rbac;
use app\models\UserCanView;
use Yii;
use app\models\User;
use app\models\UserSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\Response;
use yii\widgets\ActiveForm;

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
            if ($model->user_can_view) {
                $insertions = [];
                foreach ($model->user_can_view as $id) {
                    array_push($insertions,
                        [
                            $model->id,
                            $id
                        ]);
                }
                Yii::$app->db->createCommand()->batchInsert('user_can_view',
                    ['user_id', 'buy_request_type_id'], $insertions)
                    ->execute();
            }
            Yii::$app->traza->saveLog('Agregar Usuario', "Fue añadido el usuario {$model->username} al sistema.");
            Yii::$app->session->setFlash('success','Usuario creado correctamente.');
            return $this->redirect(['index']);
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }
    public function actionMyAccount(){
        $model = User::userLogged();
        $model->rol= Rbac::getRole($model->username);
        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            Yii::$app->session->setFlash('success','Datos modificados correctamente.');
            Yii::$app->traza->saveLog('Actualizar Usuario', "Actualizados los datos de {$model->username}.");
            return $this->redirect('/site/index');
        }
        return $this->render('updateMyProfile',['model'=>$model]);
    }
    public function actionChangePassword(){
        $model = new ChangePasswordForm([
            'idUser' => Yii::$app->user->id
        ]);
        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
               $user = User::userLogged();
               $user->password = Yii::$app->security->generatePasswordHash($model->password);
               $user->save(false);
            Yii::$app->session->setFlash('success','Contraseña cambiada exitosamente.');
            Yii::$app->traza->saveLog('Contraseña cambiada', "Cambiada la contraseña de {$user->username}.");
            return $this->redirect('/user/my-account');

        }
        return $this->renderAjax('changePassword',['model'=>$model]);
    }
    public function actionValidatePassword(){
        $model = new ChangePasswordForm([
            'idUser' => Yii::$app->user->id
        ]);
        if (Yii::$app->request->isAjax && $model->load(Yii::$app->request->post())) {

            Yii::$app->response->format = Response::FORMAT_JSON;
            return ActiveForm::validate($model);
            Yii::$app->end();
        }
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
        $model->user_can_view=$model->arrayCanView();
        $current = $model->rol= Rbac::getRole($model->username);
        $newPerm  =new DocumentTypePermission();
        $newPerm->user_id=$id;
        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            UserCanView::deleteAll(['user_id' => $model->id]);
            if ($model->user_can_view) {
                $insertions = [];
                foreach ($model->user_can_view as $id) {
                    array_push($insertions,
                        [
                            $model->id,
                            $id
                        ]);
                }
               $result =  Yii::$app->db->createCommand()->batchInsert('user_can_view',
                    ['user_id', 'buy_request_type_id'], $insertions)
                    ->execute();
            }
            if($current!=$model->rol){
                Rbac::changeRole($model->username,$model->rol);
                $model->save(false);
            }
            Yii::$app->traza->saveLog('Actualizar Usuario', "Actualizados los datos de {$model->username}.");
            return $this->redirect(['index']);
        }
        return $this->render('update', [
            'model' => $model,
            'newPerm'=>$newPerm
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
            $user->rol='unknown';
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
    public function actionAddFileAccess(){
            $model = new DocumentTypePermission();
             if ($model->load(Yii::$app->request->post())) {
                 $docType = $model->document_type_id;
                 foreach ($docType as $item){

                     $nm= new DocumentTypePermission();
                     $nm->user_id=$model->user_id;
                     $nm->document_type_id=$item;
                     $nm->allow_view=$model->allow_view;
                     $nm->allow_update=$model->allow_update;
                     $nm->save(false);
                 }
                 return $this->redirect(['update','id'=>$model->user_id]);
             }
    }
    public function actionDeleteDocumentAccess($id){
        $model = DocumentTypePermission::findOne($id);
        $user =$model->user_id;
        try{
            $model->delete();
            Yii::$app->session->setFlash('success','Elemento eliminado.');
        }catch (\Exception $e){
            Yii::$app->session->setFlash('danger','No fue posible eliminar este elemento. Inténtelo de nuevo más tarde.');
        }
        return $this->redirect(['update','id'=>$user]);
    }
    public function actionUpdateDocumentAccess($id){
        $model = DocumentTypePermission::findOne($id);
        if ($model->load(Yii::$app->request->post())&&$model->validate()) {
            $model->save();
            Yii::$app->session->setFlash('success','Permiso actualizado');
            return $this->redirect(['update','id'=>$model->user_id]);
        }
        return $this->renderAjax("_updatePermDocForm",['model'=>$model]);
    }
}
