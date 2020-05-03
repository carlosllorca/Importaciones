<?php

namespace app\models;

use kartik\grid\RadioColumnAsset;
use Yii;
use yii\base\Exception;
use yii\base\Model;
use yii\helpers\ArrayHelper;
use yii\web\NotFoundHttpException;

/**
 * LoginForm is the model behind the login form.
 */
class Rbac extends Model
{
    public $name;
    public $description;
    public $type;
    public $isNewRecord=true;

    public static $ROOT='root';
    public static $UEB='ueb';
    public static $ESP_TECNICO='especialista_tecnico';
    public static $COMPRADOR_NACIONAL='comprador_nacional';
    public static $COMPRADOR_INTERNACIONAL='comprador_internacional';
    public static $JEFE_LOGÍSTICA='Jefe_logistica';
    public static $LOGISTICA_ID='especialista_logistica';
    public static $JEFE_COMPRAS='jefe_compras';
    public static $JEFE_TECNCIO='ep_dt';

    public static $COMITE='miembro_comite';
    /**
     * @return array the validation rules.
     */
    /**
     * {@inheritdoc}
     */

    public function rules()
    {
        return [
            [['name', 'description',], 'required'],
            ['name','isUnique'],

        ];
    }
    public function isUnique($attribute){
        $auth=Yii::$app->authManager;
        if($this->isNewRecord){
            $role=$auth->getRole($this->name);
            if($role){
                $this->addError($attribute,$this->type.' already exists!');
            }
        }

    }
    public static function loadRbac($model){
        $auth = Yii::$app->authManager;
        $role= $auth->getRole($model);
        if($role){
            $r=new Rbac();
            $r->name=$role->name;
            $r->description=$role->description;
            $r->isNewRecord=false;
            return $r;
        }else{
            throw new Exception('Not found');
        }



    }
    public static function createAction($rolename,$desc){
        $auth = Yii::$app->authManager;

        if($auth->getRole($rolename)){

            return false;
        }
        $controlador=$auth->getRole('actions');
        $author = $auth->createRole($rolename);
        $author->description=$desc;
        $auth->add($author);
        $auth->addChild($controlador,$author);
    }
    public function attributeLabels()
    {
        return [
            'id' => Yii::t('app', 'ID'),
            'name' => Yii::t('app', 'Nombre'),
            'description' => Yii::t('app', 'Descripción'),
            'type' => Yii::t('app', 'Tipo'),
        ];
    }


    public static function getUserByRole($role){
        $auth=Yii::$app->authManager;
        $model=User::find()->all();
        $users=[];
        foreach($model as $m){
            if($auth->checkAccess($m->username,$role)){
                array_push($users,$m->username);
            }
        }
        return $users;
    }
    private function userCan($role,$user){
        $auth=Yii::$app->authManager;
        if($auth->checkAccess($user,$role))
            return true;
        else
            return false;
    }

    public function loadParams($data){
        if($this->isNewRecord==true){
            $this->name=$data['name'];
        }

        $this->description=$data['description'];
        return true;
    }
    public static function comboRoles(){
        return ArrayHelper::map(Rbac::getAllRoles(),'name','description');
    }

    public static function getAllRoles(){
        $auth = Yii::$app->authManager;
        $role=$auth->getChildren('roles');
        return $role;
    }
    public static function findPermsByRole($role){
        $auth = Yii::$app->authManager;
        $rol=$auth->getRole($role);
        return $auth->getChildren($role);
    }
    public static function getAllTask(){
        $auth = Yii::$app->authManager;

        //return $task;
    }
    public static function findOne($name,$type='Role'){
        $auth = Yii::$app->authManager;
        if($type=='Role'){
            $val=$auth->getRole($name);
           // break;

        }else{
            $val=$auth->getPermission($name);
        }
        if($val) {
            return $val;
        }else{
            return false;
        }
    }
    public static function remove($role){
        $auth = Yii::$app->authManager;
        $role=$auth->getRole($role);
        if($auth->remove($role)){
            return true;
        }else{
            return false;
        }
    }
    public static function createPerm($name,$desc){
        $auth = Yii::$app->authManager;
        if($auth->getPermission($name)){
            return "Permission exist!";
        }
        $author = $auth->createPermission($name);
        $author->description=$desc;
        if($auth->add($author))
            return true;
        else
            return "General Error!";
    }
    public static function unasignPermRole($perm,$role){
        $auth = Yii::$app->authManager;
        $entityRole=$auth->getRole($role);
        $entityPerm=$auth->getPermission($perm);
        if(!$entityPerm){
            $entityPerm=$auth->getRole($perm);
        }
        if (!$entityPerm){
            return false;
        }
        if($auth->removeChild($entityRole,$entityPerm)){
           return true;
        }else{
            return false;
        };

    }
    public static function asignPermRole($perm,$rol){
        $auth = Yii::$app->authManager;

        $entityRole=$auth->getRole($rol);
        $entityPerm=$auth->getPermission($perm);
        if(!$entityPerm){
            $entityPerm=$auth->getRole($perm);
        }

        if(!$entityRole){


            return false;
        }

        if(!$entityPerm){

            return false;
        }
        if($auth->hasChild($entityRole,$entityPerm)){

            return false;
        }

        $auth->addChild($entityRole,$entityPerm);

        return true;

    }
    public static function changeRole($userId,$rolName){
        $auth = Yii::$app->authManager;
        $rol=$auth->getRole($rolName);
        if($rol){
            $user=$auth->revokeAll($userId);
            $auth->assign($rol,$userId);
            return true;
        }else{
            return false;
        }
    }
    public static function getRole($userId=null){
        if(!$userId){
            if(Yii::$app->user->isGuest){
                return false;
            }
            $userId=Yii::$app->user->id;
        }
        $auth = Yii::$app->authManager;
         $role=$auth->getRolesByUser($userId);
        if($role)
        return array_keys($role)[0];
        else
            return false;
    }
    public static function roleList(){
        $roles = self::getAllRoles();
        $r = [];
        foreach ($roles as $role){
                $r[$role->name]=$role->description;
        }
        return $r;

    }

}
