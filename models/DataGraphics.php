<?php


namespace app\models;


use yii\base\Model;
use Yii;

class DataGraphics extends Model
{
    private function getConnector(){
        $connection = Yii::$app->getDb();
        $query = $connection->createCommand(" SET TIMEZONE='America/Havana';")->execute();
        return $connection;
    }
    public static function demandasActivasXUEB()
    {
        $connection= self::getConnector();
        $query1 = $connection->createCommand("select * from view_demandas_activas_x_ueb")->queryAll();
        $uebList = [];
        $demandas = [];
        foreach ($query1 as $q) {
            array_push($uebList, $q['ueb']);
            array_push($demandas, ['y' => $q['demandas'], 'name' => $q['ueb'], 'drilldown' => $q['ueb']]);
        }
        return [$uebList, $demandas];
    }

    public static function demandasActivasXEstado()
    {
        $connection= self::getConnector();
        $query = $connection->createCommand("select * from view_demandas_activas_x_estado")->queryAll();
        $estados = [];
        foreach ($query as $q) {
            array_push($estados, [
                'y' => $q['total'],
                'name' => $q['estado'],
                'color' => $q['color']
            ]);
        }
        return $estados;
    }

    public static function demandasActivasXUEBXESTADO()
    {
        $connection= self::getConnector();
        $query = $connection->createCommand("select * from view_demandas_activas_x_ueb_x_estado")->queryAll();
        $current = '';
        $finalFormed = [];
        $item = [];
        foreach ($query as $q) {
            if ($q['ueb'] != $current) {
                if ($current != '') {
                    array_push($finalFormed, $item);
                }
                $current = $q['ueb'];
                $item = [
                    'name' => $q['ueb'],
                    'id' => $q['ueb'],
                    'data' => [
                        [$q['estado'], $q['total']]
                    ]
                ];
            } else {
                array_push($item['data'], [$q['estado'], $q['total']]);
            }
        }
        if ($current) {
            array_push($finalFormed, $item);
        }
        return $finalFormed;
    }

    /**
     * Solicitude activas por tipo y estado - Jefe de compras
     * Limitado a los tipos de ordenes que puede ver el usuario.
     * @return array[]
     * @throws \yii\db\Exception
     */
    public static function solicitudesActivasxTipoYEstado()
    {

        $connection= self::getConnector();
        $query = $connection->createCommand("select * from view_buy_request_by_type_and_status where buy_request_type_id in (".self::strUserCanView().") ")->queryAll();
        $tiposOrdenesActivas = [];
        $estadosActivos = [];

        foreach ($query as $q) {
            if (!in_array($q['estado'], $estadosActivos)) {
                array_push($estadosActivos, $q['estado']);
            }
            if (!in_array($q['tipo'], $tiposOrdenesActivas)) {
                array_push($tiposOrdenesActivas, $q['tipo']);
            }
        }

        $series = [];
        foreach ($estadosActivos as $est) {
            $serie = [
                'name' => $est,
                'data' => []
            ];
            foreach ($tiposOrdenesActivas as $tip) {
                $val = 0;
                foreach ($query as $q) {
                    if ($q['estado'] == $est && $q['tipo'] == $tip) {
                        $val = $q['cantidad'];
                    }
                }
                array_push($serie['data'], $val);
            }
            array_push($series, $serie);
        }
        return [$tiposOrdenesActivas, $series];
    }

    public static function barBuyRequestByDOPBSSpecialistAndType()
    {
        $connection= self::getConnector();
        $query = $connection->createCommand("select * from view_buy_request_active_x_tipe_x_esp_dopbs")->queryAll();
        $especialistasActivos = [];
        $tiposOrdenesActivas = [];
        $series = [];
        foreach ($query as $q) {
            if (!in_array($q['esp_dopbs'], $especialistasActivos)) {
                array_push($especialistasActivos, $q['esp_dopbs']);
            }
            if (!in_array($q['tipo'], $tiposOrdenesActivas)) {
                array_push($tiposOrdenesActivas, $q['tipo']);
            }
        }

        foreach ($tiposOrdenesActivas as $to) {
            $serie = [
                'name' => $to,
                'data' => []
            ];
            foreach ($especialistasActivos as $ea) {
                $val = 0;
                foreach ($query as $q) {
                    if ($q['esp_dopbs'] == $ea && $q['tipo'] == $to) {
                        $val = $q['cantidad'];
                    }
                }
                array_push($serie['data'], $val);
            }
            array_push($series, $serie);
        }


        return [$especialistasActivos, $series];
    }

    public static function barBuyRequestByBuyerAndStatus($buyer = false)
    {
        $connection= self::getConnector();
        $wherePart = "buy_request_type_id in (".self::strUserCanView().")";
        if ($buyer) {
            $query = $connection->createCommand("select * from view_buy_request_active_x_status_x_esp_compras where id_user=" . $buyer . " and ".$wherePart)->queryAll();
        } else {
            $query = $connection->createCommand("select * from view_buy_request_active_x_status_x_esp_compras where ".$wherePart)->queryAll();
        }

        $especialistasActivos = [];
        $estadosActivos = [];
        $series = [];
        foreach ($query as $q) {
            if (!in_array($q['especialista'], $especialistasActivos)) {
                array_push($especialistasActivos, $q['especialista']);
            }
            if (!in_array($q['estado'], $estadosActivos)) {
                array_push($estadosActivos, $q['estado']);
            }
        }

        foreach ($estadosActivos as $to) {
            $serie = [
                'name' => $to,
                'data' => []
            ];
            foreach ($especialistasActivos as $ea) {
                $val = 0;
                foreach ($query as $q) {
                    if ($q['especialista'] == $ea && $q['estado'] == $to) {
                        $val = $q['cantidad'];
                    }
                }
                array_push($serie['data'], $val);
            }
            array_push($series, $serie);
        }


        return [$especialistasActivos, $series];
    }

    public static function barBuyRequestByDTSpecialistAndStatus($specialist = false)
    {
        $connection= self::getConnector();
        if ($specialist) {
            $query = $connection->createCommand("select * from view_buy_request_active_x_status_x_esp_dopbs where id_user=" . $specialist . ";")->queryAll();
        } else {
            $query = $connection->createCommand("select * from view_buy_request_active_x_status_x_esp_dopbs")->queryAll();
        }

        $especialistasActivos = [];
        $estadosActivos = [];
        $series = [];
        foreach ($query as $q) {
            if (!in_array($q['esp_dopbs'], $especialistasActivos)) {
                array_push($especialistasActivos, $q['esp_dopbs']);
            }
            if (!in_array($q['estado'], $estadosActivos)) {
                array_push($estadosActivos, $q['estado']);
            }
        }

        foreach ($estadosActivos as $to) {
            $serie = [
                'name' => $to,
                'data' => []
            ];
            foreach ($especialistasActivos as $ea) {
                $val = 0;
                foreach ($query as $q) {
                    if ($q['esp_dopbs'] == $ea && $q['estado'] == $to) {
                        $val = $q['cantidad'];
                    }
                }
                array_push($serie['data'], $val);
            }
            array_push($series, $serie);
        }


        return [$especialistasActivos, $series];
    }

    public static function edadMaximaDemandaPendiente()
    {
        $connection= self::getConnector();
        $query = $connection->createCommand("select * from view_edad_maxima_demanda_pendiente")->queryOne();
        $edad = [0];
        if ($query) {
            $edad = [(int)$query['dias']];
            if ($edad[0] == 0)
                $edad = [1];
        }
        return [$edad];
    }

    public static function gaugeJDOPBS()
    {
        $connection= self::getConnector();
        $query = $connection->createCommand("select * from view_old_jdopbs")->queryOne();
        $edad = [0];
        if ($query) {
            $edad = [(int)$query['dias']];
            if ($edad[0] == 0)
                $edad = [1];
        }
        return [$edad];

    }

    public static function gaugeJCompras()
    {
        $connection= self::getConnector();
        $wherePart = "buy_request_type_id in (".self::strUserCanView().")";
        $query = $connection->createCommand("select * from view_old_jcompras where ".$wherePart)->queryOne();
        $edad = [0];
        if ($query) {
            $edad = [(int)$query['dias']];
            if ($edad[0] == 0)
                $edad = [1];
        }
        return [$edad];

    }

    public static function gaugeCInternacional($comprador = false)
    {
        $connection= self::getConnector();
        $wherePart = "buy_request_type_id in (".self::strUserCanView().")";

        if ($comprador) {
            $query = $connection->createCommand("select * from view_buy_request_bidding_time where buyer_assigned=" . $comprador. ' and '.$wherePart)->queryAll();
        } else {
            $query = $connection->createCommand("select * from view_buy_request_bidding_time where ".$wherePart)->queryAll();
        }

        $series = [];

        if ($query) {
            foreach ($query as $q) {
                $porciento = (int)$q['porciento'];
                if ($porciento > 110) {
                    $porciento = 110;
                }
                array_push($series, [
                    'name' => $q['code'],
                    'data' => [$porciento],
                    'tooltip' => [
                        'valueSuffix' => '% cumplido'
                    ]
                ]);
            }
        }
        return $series;

    }

    public static function gaugeEspTecnico($especialista = false)
    {
        $connection= self::getConnector();
        if ($especialista) {
            $query = $connection->createCommand("select * from view_offert_pending_evaluations where especialista=" . $especialista)->queryAll();
        } else {
            $query = $connection->createCommand("select * from view_offert_pending_evaluations")->queryAll();
        }
        $series = [];
        if ($query) {
            foreach ($query as $q) {
                array_push($series, [
                    'name' => $q['buy_request'],
                    'data' => [(int)$q['dias']],
                    'tooltip' => [
                        'valueSuffix' => ' días pendiente de evaluación'
                    ]
                ]);
            }
        }
        return $series;
    }

    public static function solicitudesConHitosActivosXTiempo($comprador = false)
    {
        $connection= self::getConnector();
        $wherePart = "buy_request_type_id in (".self::strUserCanView().")";
        if ($comprador) {
            $query = $connection->createCommand("select * from view_stages_actives_and_expired where buyer_assigned=" . $comprador.' and '.$wherePart)->queryAll();
        } else {
            $query = $connection->createCommand("select * from view_stages_actives_and_expired where ".$wherePart)->queryAll();
        }
        $categories = [];
        $series = [
            [
                'name' => 'Dias planificados',
                'color' => '#f66b0d',
                'data' => [],
                'pointPadding' => 0.3,
                'pointPlacement' => -0.2
            ],
            [
                'name' => 'Dias transcurridos',
                'color' => 'rgb(124, 181, 236)',
                'data' => [],
                'pointPadding' => 0.35,
                'pointPlacement' => -0.2
            ]
        ];

        if ($query) {
            foreach ($query as $q) {
                array_push($categories, [$q['code'] . "<br>" . $q['label'] . ""]);
                array_push($series[0]['data'], (int)$q['schedule_days']);
                array_push($series[1]['data'], (int)$q['real_days']);
            }
        }
        return [$categories, $series];
    }

    public static function documentsPendingByUser($user)
    {
        $connection= self::getConnector();
        $query = $connection->createCommand("select * from view_documents_pending_by_user where view_documents_pending_by_user.id_user=" . $user)->queryAll();
        $documentType = [];
        $code = [];
        $series = [];
        foreach ($query as $q) {
            if (!in_array($q['documento'], $documentType)) {
                array_push($documentType, $q['documento']);
            }
            if (!in_array($q['code'], $code)) {
                array_push($code, $q['code']);
            }
        }

        foreach ($documentType as $to) {
            $serie = [
                'name' => $to,
                'data' => []
            ];
            foreach ($code as $ea) {
                $val = 0;
                foreach ($query as $q) {
                    if ($q['documento'] == $to && $q['code'] == $ea) {
                        $val = $q['cantidad'];
                    }
                }
                array_push($serie['data'], $val);
            }
            array_push($series, $serie);
        }


        return [$code, $series];
    }

    public static function pieDocumentsPendingOrderType($user)
    {
        $connection= self::getConnector();

        $query = $connection->createCommand("select code, tipo_solicitud from view_documents_pending_by_user 
            where view_documents_pending_by_user.id_user=".$user." group by code, tipo_solicitud"
        )->queryAll();
        $serie = [
            'name' => 'Cantidad',
            'colorByPoint' => true,
            'data' => []
        ];
        $temp = [];
        foreach ($query as $q){
            if(isset($temp[$q['tipo_solicitud']])){
                $temp[$q['tipo_solicitud']]['y']=$temp[$q['tipo_solicitud']]['y']++;
            }else{
                $temp[$q['tipo_solicitud']]=
                    [   'name'=>$q['tipo_solicitud'],
                        'y'=>1
                    ];
            }
        }
        foreach ($temp as $q) {
            array_push($serie['data'], $q);
        };
        return [$serie];
    }
    public  static function linearComparativeBuyRequest($buyReuestId){
        $model = BuyRequest::findOne($buyReuestId);
        if($model->buy_request_type_id==BuyRequestType::$INTERNACIIONAL_ID){
            $series =[
                [
                    'name'=>'Tiempo aprobado',
                    'data'=> [3,3,3,14,7,50]
                ]
            ];

            $steepsName =
                [
                    'Aprobación de la dirección logística',
                    'Aprobación de la dirección técnica',
                    'Aprobación de la dirección  de compras',
                    'Licitación',
                    'Seleccion de ganadores y creación del expediente y envío a direcciones funcionales',
                    'Aprobación de la compra'
                ];

            $ave = self::getAverageBuyRequestTypeInternacional();

        }else{
            $series =[
                [
                    'name'=>'Tiempo aprobado',
                    'data'=> [3,3,3,7,50]
                ]
            ];

            $steepsName =
                [
                    'Aprobación de la dirección logística',
                    'Aprobación de la dirección técnica',
                    'Aprobación de la dirección  de compras',
                    'Seleccion de ganadores y creación del expediente y envío a direcciones funcionales',
                    'Aprobación de la compra'
                ];

            $ave = self::getAverageBuyRequestTypeNacional($model->buy_request_type_id);
        }


        if($ave){
            array_push($series,
                [
                    'name'=>'Promedio histórico',
                    'data'=>$ave
                ]
            );
        }
        $connection= self::getConnector();
        if($model->buy_request_type_id==BuyRequestType::$INTERNACIIONAL_ID){
            $query = $connection->createCommand("select * from view_internacional_buy_steep where code='".$model->code."'")->queryOne();
        }else{
            $query = $connection->createCommand("select * from view_nacional_buy_steep where code='".$model->code."'")->queryOne();
        }

        if($query){
            $values = [];
            foreach ($query as $item) {
                if($item!=$model->code)
                    if($item===null)
                        array_push($values,$item);
                    else{
                        array_push($values,(int)$item);
                    }
            }
            array_push($series,
                [
                    'name'=>$model->code,
                    'data'=>$values
                ]);
        }
        return [$steepsName,$series];
    }
    private function getAverageBuyRequestTypeInternacional(){
        $connection= self::getConnector();
        $query = $connection->createCommand("select * from view_avg_internacional")->queryOne();

        if($query){
            $response = [];
            foreach ($query as $value){

                array_push($response,(int)$value);
            }
            return $response;
        }else{
            return false;
        }


    }
    public static function masDemandados($validatedListId){
        $connection = self::getConnector();
        $query = $connection->createCommand("select * from view_productos_mas_demandados where validated_list_id=".$validatedListId)->queryAll();
        return $query;
    }
    private function getAverageBuyRequestTypeNacional($typ){
        $connection= self::getConnector();
        $query = $connection->createCommand("select * from view_avg_nacional where buy_request_type_id=".$typ)->queryOne();

        if($query){
            $response = [];
            foreach ($query as $value){

                array_push($response,(int)$value);
            }
            return $response;
        }else{
            return false;
        }


    }
    /*
     * Devuelve string de ids de tipos de ordenes que puede ver el usuario autenticado.
     */
    private function strUserCanView(){
        $data = User::userLogged()->arrayCanView();
        if(count($data)==0){
            $data=[-1];
        }
        return implode(', ',$data);

    }




}
