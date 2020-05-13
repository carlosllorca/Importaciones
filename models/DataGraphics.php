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
    public static function solicitudesActivasxTipoYEstado(){

        $connection = Yii::$app->getDb();
        $query = $connection->createCommand("select * from view_buy_request_by_type_and_status")->queryAll();
        $tiposOrdenesActivas=[];
        $estadosActivos=[];
        foreach ($query as $q){
            if(!in_array($q['estado'],$estadosActivos)){
                array_push($estadosActivos,$q['estado']);
            }
            if(!in_array($q['tipo'],$tiposOrdenesActivas)){
                array_push($tiposOrdenesActivas,$q['tipo']);
            }
        }

        $series = [];
        foreach ($estadosActivos as $est){
            $serie = [
                'name'=>$est,
                'data'=>[]
            ];
            foreach ($tiposOrdenesActivas as $tip){
                $val = 0;
                foreach ($query as $q){
                    if($q['estado']==$est&&$q['tipo']==$tip){
                        $val = $q['cantidad'];
                    }
                }
                array_push($serie['data'],$val);
            }
            array_push($series,$serie);
        }
        return [$tiposOrdenesActivas,$series];
    }
    public static function barBuyRequestByDOPBSSpecialistAndType(){
        $connection = Yii::$app->getDb();
        $query = $connection->createCommand("select * from view_buy_request_active_x_tipe_x_esp_dopbs")->queryAll();
        $especialistasActivos =[];
        $tiposOrdenesActivas = [];
        $series = [];
        foreach ($query as $q){
            if(!in_array($q['esp_dopbs'],$especialistasActivos)){
                array_push($especialistasActivos,$q['esp_dopbs']);
            }
            if(!in_array($q['tipo'],$tiposOrdenesActivas)){
                array_push($tiposOrdenesActivas,$q['tipo']);
            }
        }

        foreach ($tiposOrdenesActivas as $to){
            $serie = [
                'name'=>$to,
                'data'=>[]
            ];
            foreach ($especialistasActivos as $ea){
                $val = 0;
                foreach ($query as $q){
                    if($q['esp_dopbs']==$ea&&$q['tipo']==$to){
                        $val = $q['cantidad'];
                    }
                }
                array_push($serie['data'],$val);
            }
            array_push($series,$serie);
        }


        return [$especialistasActivos,$series];
    }
    public static function barBuyRequestByBuyerAndStatus(){
        $connection = Yii::$app->getDb();
        $query = $connection->createCommand("select * from view_buy_request_active_x_status_x_esp_compras")->queryAll();
        $especialistasActivos =[];
        $estadosActivos = [];
        $series = [];
        foreach ($query as $q){
            if(!in_array($q['especialista'],$especialistasActivos)){
                array_push($especialistasActivos,$q['especialista']);
            }
            if(!in_array($q['estado'],$estadosActivos)){
                array_push($estadosActivos,$q['estado']);
            }
        }

        foreach ($estadosActivos as $to){
            $serie = [
                'name'=>$to,
                'data'=>[]
            ];
            foreach ($especialistasActivos as $ea){
                $val = 0;
                foreach ($query as $q){
                    if($q['especialista']==$ea&&$q['estado']==$to){
                        $val = $q['cantidad'];
                    }
                }
                array_push($serie['data'],$val);
            }
            array_push($series,$serie);
        }


        return [$especialistasActivos,$series];
    }
    public static function edadMaximaDemandaPendiente(){
        $connection = Yii::$app->getDb();
        $query = $connection->createCommand("select * from view_edad_maxima_demanda_pendiente")->queryOne();
        $edad =[0];
        if($query){
            $edad = [(int)$query['dias']];
            if($edad[0]==0)
                $edad=[1];
        }
        return [$edad];
    }
    public static function gaugeJDOPBS(){
        $connection = Yii::$app->getDb();
        $query = $connection->createCommand("select * from view_old_jdopbs")->queryOne();
        $edad =[0];
        if($query){
            $edad = [(int)$query['dias']];
            if($edad[0]==0)
                $edad=[1];
        }
        return [$edad];

    }
    public static function gaugeJCompras(){
        $connection = Yii::$app->getDb();
        $query = $connection->createCommand("select * from view_old_jcompras")->queryOne();
        $edad =[0];
        if($query){
            $edad = [(int)$query['dias']];
            if($edad[0]==0)
                $edad=[1];
        }
        return [$edad];

    }


}
