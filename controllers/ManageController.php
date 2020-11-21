<?php

namespace app\controllers;


use app\models\Settings;
use app\models\User;
use Faker\Provider\Base;
use Yii;


use yii\base\ErrorException;
use yii\base\Exception;
use yii\data\ArrayDataProvider;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use app\models\Rbac;


class ManageController extends MainController
{




    public function actionRbac()
    {

        $roles=Rbac::getAllRoles();
        $model=new ArrayDataProvider([
            'allModels'=>$roles,
            'sort'=>[
                'attributes' => ['name', 'description'],
            ],
            'pagination' => [
                'pageSize' => 10,
            ],
        ]);
        return $this->render('rbac',['model'=>$model->getModels()]);

    }


    /**
     * Displays a single BillingInfo model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id)
    {


        $model=$this->findModel($id);
        $perms=Rbac::findPermsByRole($id);
        $users=Rbac::getUserByRole($id);
        return $this->render('viewRole',
            ['model'=>$model,'perms'=>$perms,'users'=>$users]);

    }

    public function actionCreateRole()
    {
        $model= new Rbac();
        $model->type='Role';
        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            $this->addRole($model->name,$model->description);
            Yii::$app->traza->saveLog('Rol creado','El Rol '.$model->name.' ha sido creado.');
            return $this->redirect(['view', 'id' => $model->name]);
        } else {
            return $this->render('createRole', [
                'model' => $model,
            ]);
        }

    }


    private function addRole($rolename,$desc){
        $auth = Yii::$app->authManager;
        $controlador=$auth->getRole('roles');

        $author = $auth->createRole($rolename);
        $author->description=$desc;
        $auth->add($author);
        $auth->addChild($controlador,$author);

    }

    public function actionUpdateRole($id)
    {

        $model=Rbac::loadRbac($id);
        if(Yii::$app->request->post()){
            if($model->loadParams(Yii::$app->request->post()['Rbac']) && $model->validate()) {
                $auth=Yii::$app->authManager;
                $role=$auth->getRole($model->name);
                $role->description=$model->description;
                //  $auth->add($role);
                return $this->redirect(['view', 'id' => $model->name]);
            } else {
                return $this->render('updateRole', [
                    'model' => $model,
                ]);
            }

        }else{
            return $this->render('updateRole', [
                'model' => $model,
            ]);
        }

    }

    public function actionUpdatePerm($role){
        $model=$this->findModel($role);

        $key=$this->getAllRoutes();
        $auth=Yii::$app->authManager;

        for($i=0;$i<count($key);$i++){
            if(substr($key[$i],-1,1)=='*'){
                if(!$auth->getRole(strtolower($key[$i]))){
                    Rbac::createAction(strtolower($key[$i]),$key[$i]);
                }
            }else{
                if(!$auth->getPermission(strtolower($key[$i]))){
                    $pos= strpos(strtolower($key[$i]),'/');
                    $role= substr(strtolower($key[$i]),0,$pos).'/*';
                    Rbac::createPerm(strtolower($key[$i]),$key[$i]);
                    Rbac::asignPermRole(strtolower($key[$i]),$role);
                }
            }
            $key[$i]=strtolower($key[$i]);
        }

        $perms=$auth->getPermissions();
        foreach($perms as $p){
            if(in_array($p->name,$key)!=1){
                $oldPerm=$auth->getPermission($p->name);
                $auth->remove($oldPerm);
            }
        }
        $roles=$auth->getChildren('actions');

        foreach($roles as $p){


            if(in_array($p->name,$key)!=1)
            {

                $oldPerm=$auth->getRole($p->name);
                $auth->remove($oldPerm);
            }

        }

        $task=[];

        for ($i=0;$i<count($key);$i++){
                array_push($task,['name'=>strtolower($key[$i]),'description'=>$key[$i]]);
        };


        return $this->render('updatePerm',['role'=>$model,'task'=>$task]);

    }


    public function actionModifyRol($action,$auth,$role){
        switch ($action){
            case 'delete':
                echo json_encode(Rbac::unasignPermRole($auth,$role));
                break;
            case 'add':
                echo json_encode(Rbac::asignPermRole($auth,$role));
                break;
        }

    }

    public function actionDelete($id)
    {
        $models = User::find()->innerJoinWith('authAssignament')->where(['item_name'=>$id])->all();
        if($models){
            Yii::$app->session->setFlash('danger','El rol no puede ser eliminado porque está asignado a al menos un usuario.');
            return $this->redirect('rbac');
        }
        if(Rbac::remove($id))
        {

            Yii::$app->session->setFlash('success','Rol eliminado correctamente.');
            Yii::$app->traza->saveLog('Rol eilminado','El Rol '.$id.' ha sido eliminado');
            return $this->redirect(['manage/rbac']);
        }

        else{
            throw new ErrorException('Can not delete the Rol');
        }
    }


    protected function findModel($id)
    {
        if ($model = Rbac::findOne($id)) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

    
}
