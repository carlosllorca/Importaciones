<?php


namespace app\models;


use yii\base\Model;
use Yii;

class DataInforms extends Model
{
    private function getConnector(){
        $connection = Yii::$app->getDb();
        $query = $connection->createCommand(" SET TIMEZONE='America/Havana';")->execute();
        return $connection;
    }
    public static function demandsProductsMoreDemands(){
        $connector = self::getConnector();
        $query = $connector->createCommand("select * from inform_productos_mas_solicitado_anual limit 50")->queryAll();
        return $query;
    }
    public static function demandsProductsMoreDemandsTrimestre(){
        $connector = self::getConnector();
        $query = $connector->createCommand("select * from inform_productos_mas_solicitado_trimestre limit 50")->queryAll();
        return $query;
    }
    public static function demandsPending(){
        $connector = self::getConnector();
        $query = $connector->createCommand("select * from inform_pending_demand")->queryAll();
        return $query;
    }
    public static function demandsRejected(){
        $connector = self::getConnector();
        $query = $connector->createCommand("select * from inform_demandas_rechazadas")->queryAll();
        return $query;
    }
    public static function solicitudesActivas(){
        $connector = self::getConnector();
        $query = $connector->createCommand("select * from inform_solicitudes_activas")->queryAll();
        return $query;
    }
    public static function solicitudesInternacionalesFueraFecha(){
        $connector = self::getConnector();
        $query = $connector->createCommand("select * from inform_contratacion_internacional_fuera_fecha")->queryAll();
        return $query;
    }
    public static function solicitudesNacionalesesFueraFecha(){
        $connector = self::getConnector();
        $query = $connector->createCommand("select * from inform_contratacion_nacional_fuera_fecha")->queryAll();
        return $query;
    }





}
