
<?php

/**
 * Created by PhpStorm.
 * User: carlos
 * Date: 15/04/16
 * Time: 20:29
 */
$this->title = 'Actualizar permisos';
$this->params['breadcrumbs'][] = ['label' => 'Control de acceso', 'url' => ['rbac']];
$this->params['breadcrumbs'][] = ['label' => $role->description, 'url' => ['view','id'=>$role->name]];
$this->params['breadcrumbs'][] = $this->title;

//$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Account Management'), 'url' => ['site/settings']];
//$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Access Control'), 'url' => ['index']];
//$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Manage '.$role->name.' Role'), 'url' => ['view','id'=>$role->name]];
//$this->params['breadcrumbs'][] = $this->title;
function success($task,$children){
    $name=[];
    foreach($children as $ch){
        array_push($name,$ch->name);
    }
    if(in_array($task['name'],$name))
        return "text-success";
    return "text-danger";
}
function generateId($val){
    $val=str_replace(['/','-','*'],'',$val);
    return $val;
}
function action($task,$children,$role){
    if(success($task,$children)!='text-success'){
        $route=Yii::$app->urlManager->createUrl(['updateRole','action'=>'add']);

        echo '<button  name="'.$task['name'].'" onClick="addRol(this)" id="add-'.generateId($task['name']).'"><span class="fa fa-remove"></span></button>';
        echo '<button class="hidden"  name="'.$task['name'].'" onClick="deleteRol(this)" id="del-'.generateId($task['name']).'"><span class="fa fa-check""></span></button>';

    }

    else {
        $route=Yii::$app->urlManager->createUrl(['updateRole','action'=>'delete','auth'=>$task['name'],'role'=>$role->name]);

        if(substr_compare($task['name'], "manage", 0, 6, true) != 0 /*&& $role->name != $_GET['role']*/){
            echo '<button   class="hidden" name="'.$task['name'].'" onClick="addRol(this)" id="add-'.generateId($task['name']).'"><span class="fa fa-remove"></span></button>';
            echo '<button  name="'.$task['name'].'" onClick="deleteRol(this)" id="del-'.generateId($task['name']).'"><span class="fa fa-check""></span></button>';
        }
        else{
            $authManager = Yii::$app->authManager;
            $checkUsr = $authManager->getRolesByUser(Yii::$app->user->id);
            if(!in_array($role,$checkUsr)){
                echo '<button   class="hidden" name="'.$task['name'].'" onClick="addRol(this)" id="add-'.generateId($task['name']).'"><span class="fa fa-remove"></span></button>';
                echo '<button  name="'.$task['name'].'" onClick="deleteRol(this)" id="del-'.generateId($task['name']).'"><span class="fa fa-check""></span></button>';
            }
        }
    }


}
$auth=Yii::$app->authManager;
$children=$auth->getChildren($role->name);

?>


<div class="card">
    <div class="card-header card-header-primary">
        <h4 class="card-title"><?=$this->title?></h4>
        <p>Nombre del rol: <?=$role->description?></p>

    </div>
    <div class="card-body" style="padding: 15px">
        <input type="text" id="roleName" hidden value="<?=$role->name;?>">
        <p class="text-muted"><b>Consejo: </b>Autoriza o deniega accesos al rol <?=$role->description;?>.</p>
        <p class="text-muted"><b>Consejo: </b>Filas en verde significa que el rol <?=$role->name;?> tiene acceso.</p>
        <p class="text-muted"><b>Tips: </b>Si usted marca un permiso terminado en * Se autorizará todas las rutas que comiencen igual.</p>
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <th>
                   <b style="font-weight: bold; text-transform: uppercase">Acción</b>
                </th>
                <th>
                    <b style="font-weight: bold; text-transform: uppercase">Autorizar / Revocar</b>
                </th>
            </tr>
            </thead>
            <tbody>
            <?php
            foreach($task as $t){
                ?>
                <tr id="div-<?=generateId($t['name']);?>" class="<?=success($t,$children);?>">
                    <td>
                        <?=$t['description'];?>
                    </td>
                    <td style="text-align: center; width: 50px"><?php action($t,$children,$role)?></td>
                </tr>
                <?php
            }
            ?>
            </tbody>
        </table>

    </div>
</div>
<?php
$this->registerJsFile('@web/js/updatePerm.js', ['depends' => [\yii\web\JqueryAsset::className()]]);
?>




