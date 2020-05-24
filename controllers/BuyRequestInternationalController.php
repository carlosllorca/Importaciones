<?php

namespace app\controllers;

use Yii;
use app\models\BuyRequestInternational;
use app\models\BuyRequestInternationalSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * BuyRequestInternationalController implements the CRUD actions for BuyRequestInternational model.
 */
class BuyRequestInternationalController extends MainController
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
    public function actionValidateCreate(){

    }


    protected function findModel($id)
    {
        if (($model = BuyRequestInternational::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
