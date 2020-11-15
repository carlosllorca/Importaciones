<?php


namespace app\models;


use yii\base\Model;
use Yii;

class DataInforms extends Model
{
    private function getConnector()
    {
        $connection = Yii::$app->getDb();
        $query = $connection->createCommand(" SET TIMEZONE='America/Havana';")->execute();
        return $connection;
    }

    public static function demandsProductsMoreDemands($date_start, $date_end)
    {
        $connector = self::getConnector();
        $query = $connector->createCommand(" SELECT validated_list_item.id,
    validated_list_item.product_name,
    count(validated_list_item.id) AS demandas_solicitadas,
    sum(demand_item.quantity) AS cantidad,
    validated_list_item.price AS precio,
    ((sum(demand_item.quantity))::double precision * validated_list_item.price) AS importe,
    um.label AS um
   FROM (((validated_list_item
     JOIN demand_item ON ((demand_item.validated_list_item_id = validated_list_item.id)))
     JOIN demand ON ((demand_item.demand_id = demand.id)))
     JOIN um ON ((validated_list_item.um_id = um.id)))
  WHERE ((demand.sending_date >= '" . $date_start . "') AND (demand.sending_date <= '" . $date_end . "') AND (demand.demand_status_id <> 1))
  GROUP BY validated_list_item.id, validated_list_item.product_name, um.label
  ORDER BY (count(validated_list_item.id)) DESC")->queryAll();
        return $query;
    }

    public static function demandsProductsMoreDemandsTrimestre()
    {
        $connector = self::getConnector();
        $query = $connector->createCommand("select * from inform_productos_mas_solicitado_trimestre limit 50")->queryAll();
        return $query;
    }

    public static function demandsPending($dateStart,$dateEnd)
    {
        $connector = self::getConnector();
        $query = $connector->createCommand(" SELECT province_ueb.label AS ueb_name,
    demand.demand_code,
    demand.sending_date,
    client.name AS client_name,
    organism.short_name,
    demand_status.label AS status,
    date_part('day'::text, (now() - (demand.sending_date)::timestamp with time zone)) AS dias
   FROM ((((demand
     JOIN client ON ((demand.client_id = client.id)))
     JOIN province_ueb ON ((client.province_ueb = province_ueb.id)))
     JOIN demand_status ON ((demand.demand_status_id = demand_status.id)))
     JOIN organism ON ((client.organism_id = organism.id)))
  WHERE (((demand.demand_status_id = 2) OR (demand.demand_status_id = 3)) AND (demand.sending_date <= (now() - '1 mon'::interval)))
  and demand.sending_date between '".$dateStart."' and '".$dateEnd."'
  ORDER BY province_ueb.label")->queryAll();
        return $query;
    }

    public static function demandsRejected($dateStart, $dateEnd)
    {
        $connector = self::getConnector($dateStart, $dateEnd);
        $query = $connector->createCommand(" SELECT province_ueb.label AS ueb_name,
    demand.demand_code,
    demand.sending_date,
    client.name AS client_name,
    organism.short_name,
    demand.rejected_reason
   FROM ((((demand
     JOIN client ON ((demand.client_id = client.id)))
     JOIN province_ueb ON ((client.province_ueb = province_ueb.id)))
     JOIN demand_status ON ((demand.demand_status_id = demand_status.id)))
     JOIN organism ON ((client.organism_id = organism.id)))
  WHERE (demand.demand_status_id = 4)
  and demand.sending_date between '".$dateStart."' and '".$dateEnd."'
  ORDER BY province_ueb.label")->queryAll();
        return $query;
    }

    public static function solicitudesActivas($dateStart, $dateEnd)
    {
        $connector = self::getConnector();
        $query = $connector->createCommand(" SELECT buy_request.code,
    buy_request.created,
    buy_request_type.label AS tipo,
    demand.demand_code AS demanda,
    client.name AS cliente,
    organism.name AS organismo,
    province_ueb.label AS ueb,
    buy_request_status.label AS estado
   FROM (((((((buy_request
     JOIN buy_request_type ON ((buy_request.buy_request_type_id = buy_request_type.id)))
     JOIN buy_request_status ON ((buy_request.buy_request_status_id = buy_request_status.id)))
     JOIN demand_item ON ((demand_item.buy_request_id = buy_request.id)))
     JOIN demand ON ((demand_item.demand_id = demand.id)))
     JOIN client ON ((demand.client_id = client.id)))
     JOIN organism ON ((client.organism_id = organism.id)))
     JOIN province_ueb ON ((client.province_ueb = province_ueb.id)))
  WHERE ((buy_request.buy_request_status_id <> 1) AND (buy_request.buy_request_status_id <> 3) AND (buy_request.buy_request_status_id <> 7))
  and created between '".$dateStart."' and '".$dateEnd."'
  ORDER BY buy_request_type.label, buy_request.code")->queryAll();
        return $query;
    }

    public static function solicitudesInternacionalesFueraFecha($dateStart,$dateEnd)
    {
        $connector = self::getConnector();
        $query = $connector->createCommand(" SELECT buy_request.code,
    buy_request.created,
    view_internacional_buy_steep.t_aproved,
    view_internacional_buy_steep.t_dt_approved,
    view_internacional_buy_steep.t_buy_approved,
    view_internacional_buy_steep.t_licitation,
    view_internacional_buy_steep.t_winner_selected,
    view_internacional_buy_steep.t_execution_start,
    buy_request_status.label AS estado
   FROM ((view_internacional_buy_steep
     JOIN buy_request ON (((buy_request.code)::text = (view_internacional_buy_steep.code)::text)))
     JOIN buy_request_status ON ((buy_request.buy_request_status_id = buy_request_status.id)))
  WHERE buy_request.created between '".$dateStart."' and '".$dateEnd."' and ((view_internacional_buy_steep.t_aproved > (3)::double precision) OR 
  (view_internacional_buy_steep.t_dt_approved > (3)::double precision) OR 
  (view_internacional_buy_steep.t_buy_approved > (3)::double precision) OR (view_internacional_buy_steep.t_licitation > (14)::double precision) OR 
  (view_internacional_buy_steep.t_winner_selected > (7)::double precision) OR (view_internacional_buy_steep.t_execution_start > (50)::double precision))"
        )->queryAll();
        return $query;
    }

    public static function solicitudesNacionalesesFueraFecha($dateStart,$dateEnd)
    {
        $connector = self::getConnector();
        $query = $connector->createCommand(" SELECT buy_request.code,
    buy_request.created,
    buy_request_type.label AS tipo,
    view_nacional_buy_steep.t_aproved,
    view_nacional_buy_steep.t_dt_approved,
    view_nacional_buy_steep.t_buy_approved,
    view_nacional_buy_steep.t_winner_selected,
    view_nacional_buy_steep.t_execution_start,
    buy_request_status.label AS estado
   FROM (((view_nacional_buy_steep
     JOIN buy_request ON (((buy_request.code)::text = (view_nacional_buy_steep.code)::text)))
     JOIN buy_request_type ON ((buy_request.buy_request_type_id = buy_request_type.id)))
     JOIN buy_request_status ON ((buy_request.buy_request_status_id = buy_request_status.id)))
  WHERE buy_request.created between '".$dateStart."' and '".$dateEnd."' and ((view_nacional_buy_steep.t_aproved > (3)::double precision) OR (view_nacional_buy_steep.t_dt_approved > (3)::double precision) OR (view_nacional_buy_steep.t_buy_approved > (3)::double precision) OR (view_nacional_buy_steep.t_winner_selected > (3)::double precision) OR (view_nacional_buy_steep.t_execution_start > (50)::double precision))
  ORDER BY buy_request_type.label, buy_request.code")->queryAll();
        return $query;
    }

    public static function ventasUltimoAnno($dateStart,$dateEnd)
    {
        $connector = self::getConnector();
        $query = $connector->createCommand(" SELECT to_char((buy_request.approved_date)::timestamp with time zone, 'MM-YY'::text) AS fecha,
    sum((demand_item.price * (demand_item.quantity)::double precision)) AS amount
   FROM (buy_request
     JOIN demand_item ON ((demand_item.buy_request_id = buy_request.id)))
  WHERE (buy_request.buy_request_status_id = 7) and buy_request.created between '".$dateStart."' and '".$dateEnd."' group by fecha" )->queryAll();
        return $query;
    }

    public static function solicitudesEnTransportacion($dateStart,$dateEnd)
    {
        $connector = self::getConnector();
        $query = $connector->createCommand(" SELECT buy_request.code,
    buy_request.created,
    buy_request_type.label AS tipo,
    request_stage.date_start,
    request_stage.date_end,
    stage.label AS hito
   FROM (((buy_request
     JOIN request_stage ON ((request_stage.buy_request_id = buy_request.id)))
     JOIN stage ON ((request_stage.stage_id = stage.id)))
     JOIN buy_request_type ON (((buy_request.buy_request_type_id = buy_request_type.id) AND (stage.buy_request_type_id = buy_request_type.id))))
  WHERE request_stage.active and created between '".$dateStart."' and '".$dateEnd."'")->queryAll();
        return $query;
    }

    public static function solicitudesEnTransportacionVencidas($dateStart,$dateEnd)
    {
        $connector = self::getConnector();
        $query = $connector->createCommand(" SELECT buy_request.code,
    buy_request.created,
    buy_request_type.label AS tipo,
    request_stage.date_start,
    request_stage.date_end,
    stage.label AS hito,
    request_stage.details
   FROM (((buy_request
     JOIN request_stage ON ((request_stage.buy_request_id = buy_request.id)))
     JOIN stage ON ((request_stage.stage_id = stage.id)))
     JOIN buy_request_type ON (((buy_request.buy_request_type_id = buy_request_type.id) AND (stage.buy_request_type_id = buy_request_type.id))))
  WHERE (request_stage.active AND (request_stage.date_end > now())) and created between '".$dateStart."' and '".$dateEnd."'")->queryAll();
        return $query;
    }


}
