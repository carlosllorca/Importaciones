<?php

namespace tests\unit\models;

use app\models\Demand;
use app\models\DemandItem;
use app\models\DemandStatus;
use yii\db\Exception;

class DemandTest extends \Codeception\Test\Unit
{
    private $model;



    public function testAprobarDemanda()
    {
        $demanda = Demand::findOne(30);
        expect($demanda->demand_status_id!=DemandStatus::ACEPTADA_ID);
        $demanda->demand_status_id=DemandStatus::ACEPTADA_ID;
        $demanda->save();
        $demanda = Demand::findOne(30);
        expect($demanda->demand_status_id==DemandStatus::ACEPTADA_ID);

    }
    public function testClasificarItemComoDistribucionInterna()
    {
        $item = DemandItem::findOne(136);
       $item->internal_distribution=true;
       $item->save();
       $item = DemandItem::findOne(136);
        expect($item->internal_distribution);
    }



}
