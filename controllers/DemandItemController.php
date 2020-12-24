<?php

namespace app\controllers;

use app\models\Demand;
use app\models\ValidatedListItem;
use Yii;
use app\models\DemandItem;
use app\models\DemandItemSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\Response;

/**
 * DemandItemController implements the CRUD actions for DemandItem model.
 */
class DemandItemController extends MainController
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
     * @inheritdoc
     */
    public function beforeAction($action)
    {
        if (in_array($action->id ,[ 'add-item'])) {
            $this->enableCsrfValidation = false;
        }

        return parent::beforeAction($action);
    }
    public function actionAddItem(){
        Yii::$app->response->format = Response::FORMAT_JSON;
        $raw_data = json_decode(Yii::$app->request->getRawBody());
        $cantidad =(int) $raw_data->quantity;
        $producto =(int) $raw_data->item;
        if($cantidad<0){
            Yii::$app->response->statusCode=501;
            return  ['success'=>false,'error'=>'La cantidad no puede ser menor que 0'];
        }

        $demand = Demand::findOne($raw_data->demand);
        $modelDemndItem = $demand->addOrUpdateDemandItem($producto,$cantidad);
        if($modelDemndItem){
            return ['success'=>true,
                'import'=>Yii::$app->formatter->asCurrency($modelDemndItem->quantity*$modelDemndItem->price),
                'totalProducts'=>count($demand->demandItems),
                'totalAmount'=>Yii::$app->formatter->asCurrency($demand->totalAmount())
            ];
        }
        return ['success'=>true,'import'=>Yii::$app->formatter->asCurrency(0),
            'totalProducts'=>count($demand->demandItems),
            'totalAmount'=>Yii::$app->formatter->asCurrency($demand->totalAmount())];

    }


    /**
     * Finds the DemandItem model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return DemandItem the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = DemandItem::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
