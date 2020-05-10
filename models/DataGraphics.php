<?php


namespace app\models;


use yii\base\Model;
use Yii;
class DataGraphics extends Model
{
    public static function demandasActivasXUEB(){
        $connection = Yii::$app->getDb();
        $query1 = $connection->createCommand("select * from view_demandas_activas_x_ueb")->queryAll();
        $uebList=[];
        $demandas=[];
        foreach ($query1 as $q) {
            array_push($uebList, $q['ueb']);
            array_push($demandas, ['y' => $q['demandas'], 'name' => $q['ueb'], 'drilldown' => $q['ueb']]);
        }
        return[$uebList,$demandas];
    }
    public static function demandasActivasXEstado(){
        $connection = Yii::$app->getDb();
        $query = $connection->createCommand("select * from view_demandas_activas_x_estado")->queryAll();
        $estados=[];
        foreach ($query as $q) {
            array_push($estados, [
                'y' => $q['total'],
                'name' => $q['estado'],
                'color' => $q['color']
            ]);
        }
        return $estados;
    }
    public static function demandasActivasXUEBXESTADO(){
        $connection = Yii::$app->getDb();
        $query = $connection->createCommand("select * from view_demandas_activas_x_ueb_x_estado")->queryAll();
        $current = '';
        $finalFormed = [];
        $item = [];
        foreach ($query as $q) {
            if($q['ueb']!=$current){
                if($current!=''){
                    array_push($finalFormed,$item);
                }
                $current=$q['ueb'];
                $item=[
                    'name'=>$q['ueb'],
                    'id'=>$q['ueb'],
                    'data'=>[
                        [$q['estado'],$q['total']]
                    ]
                ];
            }else{
                array_push($item['data'],[$q['estado'],$q['total']]);
            }
        }
        if($current){
            array_push($finalFormed,$item);
        }
        return $finalFormed;
    }

}