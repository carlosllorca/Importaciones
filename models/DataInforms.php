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





}
