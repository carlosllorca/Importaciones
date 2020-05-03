<?php
/**
 * Created by PhpStorm.
 * User: carlos
 * Date: 12/04/16
 * Time: 21:15
 */
namespace app\commands;
use yii\console\Controller;
use Yii;
class RbacController extends Controller
{
    public $auth;

    public function actionNewPerm($name,$desc=false)
    {
        $auth = Yii::$app->authManager;
        $perm = $auth->createPermission($name);
        if($desc){
            $perm->description=$desc;
        }
        $auth->add($perm);
        echo "Permiso creado correctamente \n";
    }

    /**
     * Permisos
     */
    public function actionDelPerm($perm){
        $auth = Yii::$app->authManager;
        $perm=$auth->getPermission($perm);
        if($perm){
            $auth->remove($perm);
            echo "Permiso eliminado \n";

        }else{
            echo "Permiso no encontrado \n";
        }
    }
    public function actionGetPerms(){
        $auth = Yii::$app->authManager;
        $perm=$auth->getPermissions();
        foreach($perm as $p){
            echo $p->name."\n";
        };
    }
    public function actionRolePerm($roleName){
        $auth = Yii::$app->authManager;
        $role=$auth->getChildren($roleName);
        if($role)
            foreach($role as $p){
                echo $p->name."\n";
            }
        else
            echo "Rol desconocido!\n";

    }
    public function actionRoles(){
        $auth = Yii::$app->authManager;

        $role=$auth->getChildren('roles');
        if($role)
            foreach($role as $p){
                echo $p->description."\n";
            }
        else
            echo "No hay roles!\n";

    }

    public function actionUserRole($rol){
        $auth=Yii::$app->authManager;
        $role=$auth->getRolesByUser($rol);
        if($role)
            foreach($role as $p){
                echo $p->description."\n";
            }
        else
            echo "No hay roles!\n";
    }

    /**
     * Roles
     */
    public function actionNewRole($name,$desc=false){
        $auth = Yii::$app->authManager;
        $author = $auth->createRole($name);
        if($desc){
            $author->description=$desc;
        }
        $auth->add($author);
        $rol=$auth->getRole('roles');
        $auth->addChild($rol,$author);
    }
    public function actionDelRole($name){
        $auth = Yii::$app->authManager;
        $rol=$auth->getRole($name);
        if($rol){
            $auth->remove($rol);
            echo "Rol eliminado \n";

        }else{
            echo "Rol no encontrado \n";
        }
    }
    public function actionCan(){
        $auth = Yii::$app->authManager;
        echo  $perm=$auth->checkAccess('cllorca','pepe');
        /*foreach($perm as $p){
            echo $p->name."\n";
        };*/
    }
    public function actionGivePerm($rol,$perm,$type='perm'){
        $auth = Yii::$app->authManager;
        $entityRole=$auth->getRole($rol);
        if($type=='perm'){
            $entityPerm=$auth->getPermission($perm);
        }else{
            $entityPerm=$auth->getRole($perm);
        }

        if(!$entityRole){

            echo  "Rol no encontrado \n";
            return false;
        }

        if(!$entityPerm){
            echo  "Permiso no encontrado \n";
            return false;
        }

        $auth->addChild($entityRole,$entityPerm);
        echo "Permiso asignado correctamente \n";
        return true;
    }
    public function actionUnasignAll($role){
        $auth = Yii::$app->authManager;
        $entityRole=$auth->getRole($role);
    }

    public function actionUnasignPerm($rol,$perm,$type='perm'){
        $auth = Yii::$app->authManager;
        $entityRole=$auth->getRole($rol);
        if($type=='perm'){
            $entityPerm=$auth->getPermission($perm);
        }else{
            $entityPerm=$auth->getRole($perm);
        }

        if(!$entityRole){

            echo  "Rol no encontrado \n";
            return false;
        }

        if(!$entityPerm){
            echo  "Permiso no encontrado \n";
            return false;
        }

        $auth->removeChild($entityRole,$entityPerm);
        echo "Permiso removido correctamente \n";
        return true;
    }
    public function actionChangeRole($userId,$rolName){
        $auth = Yii::$app->authManager;
        $rol=$auth->getRole($rolName);
        if($rol){
            $user=$auth->revokeAll($userId);
            $auth->assign($rol,$userId);
        }else{
            echo "Rol invalido \n";
        }
    }
    public function actionReset(){
        $auth = Yii::$app->authManager;
        $auth->removeAll();
        $roles=$auth->createRole('roles');
        $auth->add($roles);
        $roles=$auth->createRole('actions');
        $auth->add($roles);
    }


}