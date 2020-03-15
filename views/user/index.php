<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
/* @var $this yii\web\View */
/* @var $searchModel app\models\UserSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Usuarios del sistema';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="buy-request-status-index">
    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><?=$this->title?></h4>
            <p class="card-category">Se muestran los usuarios que tienen acceso al sistema.</p>
        </div>
        <div class="card-body" style="padding: 15px">
            <div class="p-3">
                <p>
                    <?= Html::a('Nuevo', ['create'], ['class' => 'btn btn-success']) ?>
                </p>

                <?php Pjax::begin(); ?>
                <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

                <?= GridView::widget([
                    'dataProvider' => $dataProvider,
                    'filterModel' => $searchModel,
                    'columns' => [
                        ['class' => 'yii\grid\SerialColumn'],
                        'username',
                        'full_name',
                        'email:email',

                        'created_at:date',
                        'last_login:datetime',
//                        [
//                                'attribute' => 'rol',
//                                'filter' => \app\models\Rbac::comboRoles(),
//                                'value' => function($model){
//                                    /**
//                                     * @var $model \app\models\User
//                                     */
//                                    return $model->role?$model->role->description:null;
//                                }
//                        ],
                        'active:boolean',

                        [
                                'class' => 'rce\material\grid\ActionColumn',
                                'template' => '{update} {disable}',
                                'buttons'=>[
                                        'disable'=>function($url,$model){
                                                /**
                                                 * @var $model \app\models\User
                                                 */

                                                if(Yii::$app->user->can('user/disable')){
                                                    if($model->active){
                                                        $msg = "¿Confirma que desea desactivar este usuario?";
                                                        return Html::a(
                                                            "<i class='material-icons'>person_outline</i><div class='ripple-container'></div>",[$url],
                                                            [
                                                                'data-confirm'=>$msg,
                                                                'class'=>'btn btn-primary btn-simple btn-xs',
                                                                'title'=>'Desactivar usuario'
                                                            ]);
                                                    }else{
                                                        $msg = "¿Confirma que desea activar este usuario?";
                                                        return Html::a(
                                                            "<i class='material-icons'>person</i><div class='ripple-container'></div>",[$url],
                                                            [
                                                                'data-confirm'=>$msg,
                                                                'class'=>'btn btn-primary btn-simple btn-xs',
                                                                'title'=>'activar usuario'
                                                            ]);
                                                    }
                                                }

                                        }
                                ]

                        ],
                    ],
                ]); ?>
                <?php Pjax::end(); ?>
            </div>
        </div>
    </div>
</div>
