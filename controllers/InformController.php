<?php

namespace app\controllers;
use app\models\DataInforms;
use app\models\User;
use Mpdf\Mpdf;
use Yii;

/**
 * Agrupa los informes que se pueden generar desde la solución SIGCL-SEISA
 */
class InformController extends MainController
{
    public function actionIndex(){
        return $this->render('inform');
    }
    public function actionDemandasProductosMasSolicitados(){
            $data = DataInforms::demandsProductsMoreDemands();
            $mpdf = $this->generateBasicInform();
            $mpdf->WriteHTML($this->renderPartial('demandas_productos_mas_solicitados', ['data' => $data]), 2);
            $username = User::userLogged()->full_name;
            $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
            $mpdf->Output();
            Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
            Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }
    public function actionDemandasProductosMasSolicitadosTrimestre(){
        $data = DataInforms::demandsProductsMoreDemandsTrimestre();
        $mpdf = $this->generateBasicInform();
        $mpdf->WriteHTML($this->renderPartial('demandas_productos_mas_solicitados_trimestre', ['data' => $data]), 2);
        $username = User::userLogged()->full_name;
        $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
        $mpdf->Output();
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }
    public function actionDemandasPendientes(){
        $data = DataInforms::demandsPending();
        $mpdf = $this->generateBasicInform();
        $mpdf->WriteHTML($this->renderPartial('demandas_pendientes', ['data' => $data]), 2);
        $username = User::userLogged()->full_name;
        $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
        $mpdf->Output();
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }
    public function actionDemandasRechazadas(){
        $data = DataInforms::demandsRejected();
        $mpdf = $this->generateBasicInform();
        $mpdf->WriteHTML($this->renderPartial('demandas_rechazadas', ['data' => $data]), 2);
        $username = User::userLogged()->full_name;
        $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
        $mpdf->Output();
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }
    public function actionSolicitudesActivas(){
        $data = DataInforms::solicitudesActivas();
        $mpdf = $this->generateBasicInform(true);
        $mpdf->WriteHTML($this->renderPartial('solicitudes_activas', ['data' => $data]), 2);
        $username = User::userLogged()->full_name;
        $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
        $mpdf->Output();
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }

    /**
     * @param $name
     * @param bool $landscape
     * @return Mpdf
     * @throws \Mpdf\MpdfException
     */
    private function generateBasicInform($landscape=false){

        $mpdf = new Mpdf([
            'format'=>'letter',
            'orientation' => $landscape?'L':'P'
        ]);
        $fondo = file_get_contents('../web/css/certificados.css'); // external css
        $mpdf->WriteHTML($fondo, 1);
        $mpdf->SetDisplayMode('fullwidth');
        return $mpdf;
    }


}
