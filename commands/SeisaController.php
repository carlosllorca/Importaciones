<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace app\commands;
use app\models\User;
use Yii;
use app\models\BuyRequestStatus;
use app\models\RequestStage;
use yii\console\Controller;
use yii\console\ExitCode;

/**
 * This command echoes the first argument that you have entered.
 *
 * This command is provided as an example for you to learn how to create console commands.
 *
 * @author Qiang Xue <qiang.xue@gmail.com>
 * @since 2.0
 */
class SeisaController extends Controller
{
    /**
     * This command echoes what you have entered as the message.
     * @param string $message the message to be echoed.
     * @return int Exit code
     */
    public function actionIndex($message = 'hello world')
    {
        echo $message . "\n";

        return ExitCode::OK;
    }

    /**
     * Envía un email al especialista asignado el día que comienza el hito.
     */
    public function actionStartToday(){
        //;
        $start = date('Y-m-d');

        $requestStages = RequestStage::find()
            ->innerJoinWith('buyRequest')
            ->where(['not',['buy_request.buy_request_status_id'=>BuyRequestStatus::$CERRADA]])
            ->andWhere(['real_end'=>null])
            ->andWhere(['date_start'=>$start])
            ->all();

        foreach ($requestStages as $requestStage){
            echo $requestStage->buyRequest->code." - ". $requestStage->stage->label."\n";
            try{
                Yii::$app->mailer->compose('stageStartToday', ['buyRequestStage'=>$requestStage])
                    ->setFrom([Yii::$app->params['senderEmail']=>Yii::$app->params['senderName']])
                    ->setTo($requestStage->buyRequest->buyerAssigned->email)
                    ->setSubject("Ha iniciado un nuevo hito para la solicitud ".$requestStage->buyRequest->code.".")
                    ->send();
            }catch (\Exception $e){
                echo $e;
                echo "Error enviando el correo electrónico.";
            }
        }

    }


    /**
     * Notifica sobre hitos que ya deberían haber concluido;
     */
    public function actionStagesExpired(){
        $today = date('Y-m-d');
        $requestStages = RequestStage::find()
            ->innerJoinWith('buyRequest')
            ->where(['not',['buy_request.buy_request_status_id'=>BuyRequestStatus::$CERRADA]])
            ->andWhere(['real_end'=>null])
            ->andWhere(['<','date_end',$today])
            ->all();
        $sellers =[];
        foreach ($requestStages as $requestStage){
            if(isset($sellers[$requestStage->buyRequest->buyer_assigned])){
               array_push( $sellers[$requestStage->buyRequest->buyer_assigned],$requestStage);
            }else{
                $sellers[$requestStage->buyRequest->buyer_assigned] = [$requestStage];
            }

        }
        if(count($sellers)){
            foreach ($sellers as $seller){
                try{
                    $buyer = $seller[0]->buyRequest->buyerAssigned;
                    Yii::$app->mailer->compose('stagesExpired', ['user'=>$buyer,'requestStage'=>$seller])
                        ->setFrom([Yii::$app->params['senderEmail']=>Yii::$app->params['senderName']])
                        ->setTo($buyer->email)
                        ->setSubject("Debe actualizar los hitos en la  plataforma.")
                        ->send();
                }catch (\Exception $e){
                    echo $e;
                }

            }

        }

    }

}
