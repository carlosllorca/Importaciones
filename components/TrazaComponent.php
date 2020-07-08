<?php
namespace app\components;
use app\models\Log;
use Yii;
use yii\db\Exception;

/**
 * Class TrazaComponent
 * @property \app\models\User $user
 */
class TrazaComponent extends \yii\base\Component
{
    private $user;
    function init(){
        $this->user = Yii::$app->user->identity;
    }
    public function saveLog($action,$msg){
        $model = new Log();
        $model->user_id= $this->user->id;
        $model->action_moment=date('Y-m-d H:i:s');
        $model->ip=Yii::$app->request->userIP;
        $model->action=$action;
        $model->description=$msg;
        if($model->validate())
        return $model->save();

    }

    /**
     * Obtiene los logs del usuario. Si $userId=false se obtienen los logs del usuario autenticado
     * @param integer $userId
     * @return Log[]|array|\yii\db\ActiveRecord[]
     */
    public function getUserLogs($userId = false){
        if($userId==false){
            $userId = $this->user->id;
        }
        $models = Log::find()->where(['user_id'=>$userId])->all();
        return $models;
    }

}
