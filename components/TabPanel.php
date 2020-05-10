<?php


namespace app\components;
use yii\base\Widget;
use yii\helpers\Html;

class TabPanel extends Widget
{
    public $items;

    public function init() {
        // your logic here
        parent::init();

    }
    public function run(){

        return $this->render('tabpanel', ['items' => $this->items]);
    }

}