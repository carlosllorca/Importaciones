<?php

namespace app\controllers;

use app\models\CertificationValidatedListItem;
use app\models\Rbac;
use app\models\RequestAddItemForm;
use app\models\User;
use app\models\ValidatedList;
use Yii;
use app\models\ValidatedListItem;
use app\models\ValidatedListItemSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * ValidatedListItemController implements the CRUD actions for ValidatedListItem model.
 */
class ValidatedListItemController extends MainController
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
    public function actionModalDetail($item){
        $model = $this->findModel($item);


        return $this->renderAjax('modal-detail',['model'=>$model]);

    }
    public function actionRequestAdd($vl,$demand){
        $model = new RequestAddItemForm();
        $mVl = ValidatedList::findOne($vl);
        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            try{
                $users = User::getActiveUsersByRol(Rbac::$LOGISTICA_ID);
                $to =[];
                foreach ($users as $user){
                    $to[$user->email]=$user->full_name;
                }

                Yii::$app->mailer->compose('requestAddProduct', ['product'=>$model,'user'=>User::userLogged(),'mVl'=>$mVl])
                    ->setFrom([Yii::$app->params['senderEmail']=>Yii::$app->params['senderName']])
                    ->setTo($to)
                    ->setSubject("Nueva propuesta de producto a añadir al listado validado ".$mVl->label.".")
                    ->send();
                Yii::$app->session->setFlash('success',"Hemos recibido su notificación le responderemos lo antes posible.");
                return $this->redirect(['demand/demand-products','id'=>$demand]);
            }catch (\Exception $e){
                Yii::$app->session->setFlash('warning','Ocurrió un problema en el envio de correo.');
                return $this->redirect(['demand/demand-products','id'=>$demand]);
            }


        }
        return $this->renderAjax('requestAddItem',['model'=>$model]);
    }


    public function actionCreate($vl)
    {
        $model = new ValidatedListItem(['validated_list_id' => $vl]);
        $vl = ValidatedList::findOne($vl);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            if($model->certificados){
                foreach ($model->certificados as $id){
                    $certificado =new CertificationValidatedListItem();
                    $certificado->certification_id=$id;
                    $certificado->validated_list_item_id=$model->id;
                    $certificado->save();
                }
            }
            return $this->redirect(['validated-list/update', 'id' => $vl->id]);
        }

        return $this->render('create', [
            'model' => $model,
            'vl'=>$vl
        ]);
    }

    /**
     * Updates an existing ValidatedListItem model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $model->certificados = $model->certificados();


        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            CertificationValidatedListItem::deleteAll(['validated_list_item_id'=>$model->id]);
            if($model->certificados){
                foreach ($model->certificados as $id){
                    $certificado =new CertificationValidatedListItem();
                    $certificado->certification_id=$id;
                    $certificado->validated_list_item_id=$model->id;
                    $certificado->save();
                }
            }
            return $this->redirect(['validated-list/update', 'id' => $model->validated_list_id]);
        }

        return $this->render('update', [
            'model' => $model,
            'vl'=>$model->validated_list_id
        ]);
    }

    /**
     * Deletes an existing ValidatedListItem model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        try{
            $model = $this->findModel($id);
            $vl = $model->validated_list_id;
            $model->delete();
        }catch (\Exception $exception){
            Yii::$app->session->setFlash('danger',"No podemos eliminar este elemento. Está siendo utilizado.");
        }


        return $this->redirect(['validated-list/update','id'=>$vl]);

    }

    /**
     * Finds the ValidatedListItem model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return ValidatedListItem the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = ValidatedListItem::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
