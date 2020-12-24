<?php

namespace app\controllers;
use app\models\DataInforms;
use app\models\InformForm;
use app\models\User;
use Mpdf\Mpdf;
use Yii;

/**
 * Agrupa los informes que se pueden generar desde la solución SIGCL-SEISA
 */
class InformController extends MainController
{
    public function actionIndex(){
        $y = date('Y');
        $model = new InformForm([
            'date_start' => '01/01/'.date('Y'),
            'date_end' => '31/12/'.date('Y'),
        ]);
        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            switch ($model->inform){
                case InformForm::$PRODUCTOS_MAS_DEMANDADOS_ID:
                    return $this->demandasProductosMasSolicitados($model);
                case InformForm::$DEMANDAS_PENDIENTES_CON_MAS_1_MES:
                    return $this->demandasPendientes($model);
                case InformForm::$DEMANDAS_RECHAZADAS_ID:
                    return $this->demandasRechazadas($model);
                case InformForm::$SOLICITUDES_ACTIVAS_ID:
                    return $this->solicitudesActivas($model);
                case InformForm::$SOLICITUDES_CONTRATACION_FUERA_FECHA_ID:
                    return $this->solicitudesFueraFecha($model);
                case InformForm::$VALOR_ORDENES_COMPLETADAS_ID:
                    return $this->ventas($model);
                case InformForm::$ORDENES_TRANSPORTACION_ACTIVAS_X_HITO_ID:
                    return $this->solicitudesEnTransportacion($model);
                case InformForm::$ORDENES_TRANSPORTACION_CON_HITOS_VENCIDOS_ID:
                    return $this->solicitudesEnTransportacionVencidas($model);



            }
        }
        return $this->render('inform',['model'=>$model]);
    }

    /**
     * @param InformForm $model
     * @throws \Mpdf\MpdfException
     */
    private function demandasProductosMasSolicitados($model){
            $data = DataInforms::demandsProductsMoreDemands($model->castDateToDB($model->date_start),$model->castDateToDB($model->date_end));
            $mpdf = $this->generateBasicInform();
            $mpdf->WriteHTML($this->renderPartial('demandas_productos_mas_solicitados', ['data' => $data,'model'=>$model]), 2);
            $username = User::userLogged()->full_name;
            $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
            $mpdf->SetTitle("Productos más demandados.");
            $mpdf->Output();
            Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
            Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }
    /**
     * @param InformForm $model
     * @throws \Mpdf\MpdfException
     */
    private function demandasPendientes($model){
        $data = DataInforms::demandsPending($model->castDateToDB($model->date_start),$model->castDateToDB($model->date_end));
        $mpdf = $this->generateBasicInform();
        $mpdf->WriteHTML($this->renderPartial('demandas_pendientes', ['data' => $data,'model'=>$model]), 2);
        $username = User::userLogged()->full_name;
        $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
        $mpdf->SetTitle("Demandas pendientes con más de 1 mes.");
        $mpdf->Output();
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }
    /**
     * @param InformForm $model
     * @throws \Mpdf\MpdfException
     */
    private function demandasRechazadas($model){
        $data = DataInforms::demandsRejected($model->castDateToDB($model->date_start),$model->castDateToDB($model->date_end));
        $mpdf = $this->generateBasicInform(true);
        $mpdf->WriteHTML($this->renderPartial('demandas_rechazadas', ['data' => $data,'model'=>$model]), 2);
        $username = User::userLogged()->full_name;
        $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
        $mpdf->SetTitle('Demandas rechazadas');
        $mpdf->Output();
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }

    /**
     * @param InformForm $model
     * @throws \Mpdf\MpdfException
     */
    private function solicitudesActivas($model){
        $data = DataInforms::solicitudesActivas($model->castDateToDB($model->date_start),$model->castDateToDB($model->date_end));
        $mpdf = $this->generateBasicInform(true);
        $mpdf->WriteHTML($this->renderPartial('solicitudes_activas', ['data' => $data,'model'=>$model]), 2);
        $username = User::userLogged()->full_name;
        $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
        $mpdf->SetTitle('Órdenes de compra activas.');
        $mpdf->Output();
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }
    /**
     * @param InformForm $model
     * @throws \Mpdf\MpdfException
     */
    private function solicitudesFueraFecha($model){
        $internacionales = DataInforms::solicitudesInternacionalesFueraFecha($model->castDateToDB($model->date_start),$model->castDateToDB($model->date_end));
        $nacionales = DataInforms::solicitudesNacionalesesFueraFecha($model->castDateToDB($model->date_start),$model->castDateToDB($model->date_end));
        $mpdf = $this->generateBasicInform(true);
        $mpdf->WriteHTML($this->renderPartial('solicitudes_internacionales_fuera_fecha', ['internacionales' => $internacionales,'nacionales'=>$nacionales,'model'=>$model]), 2);
        $username = User::userLogged()->full_name;
        $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
        $mpdf->SetTitle('Órdenes de compra con hitos fuera de fecha');
        $mpdf->Output();
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }
    /**
     * @param InformForm $model
     * @throws \Mpdf\MpdfException
     */
    private function ventas($model){
        $data = DataInforms::ventasUltimoAnno($model->castDateToDB($model->date_start),$model->castDateToDB($model->date_end));
        $mpdf = $this->generateBasicInform();
        $mpdf->WriteHTML($this->renderPartial('ventas_ultimo_anno', ['data' => $data,'model'=>$model]), 2);
        $username = User::userLogged()->full_name;
        $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
        $mpdf->SetTitle('Ventas por trimestre');
        $mpdf->Output();
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }
    /**
     * @param InformForm $model
     * @throws \Mpdf\MpdfException
     */
    private function solicitudesEnTransportacion($model){
        $data = DataInforms::solicitudesEnTransportacion($model->castDateToDB($model->date_start),$model->castDateToDB($model->date_end));
        $mpdf = $this->generateBasicInform(true);
        $mpdf->WriteHTML($this->renderPartial('solicitudes_en_transportacion', ['data' => $data,'model'=>$model]), 2);
        $username = User::userLogged()->full_name;
        $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
        $mpdf->SetTitle('Órdenes de compra en transportación');
        $mpdf->Output();
        Yii::$app->response->format = \yii\web\Response::FORMAT_RAW;
        Yii::$app->response->headers->add('Content-Type', 'application/pdf');
    }
    private function solicitudesEnTransportacionVencidas($model){
        $data = DataInforms::solicitudesEnTransportacionVencidas($model->castDateToDB($model->date_start),$model->castDateToDB($model->date_end));
        $mpdf = $this->generateBasicInform(true);
        $mpdf->WriteHTML($this->renderPartial('solicitudes_en_transportacion_vencidas', ['data' => $data,'model'=>$model]), 2);
        $username = User::userLogged()->full_name;
        $mpdf->SetHTMLFooter("<p style='padding: 10px;text-align: center;font-size: 12px'><b>Generado por: </b>".$username."  <b>Fecha: </b>".date('d-m-Y H:i:s')."</p>");
        $mpdf->SetTitle('Órdenes de compra en transportación fuera de fecha');
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
