<?php

namespace app\models;

use Yii;
use yii\base\Model;

/**
 * LoginForm is the model behind the login form.
 *
 * @property User|null $user This property is read-only.
 *
 */
class InformForm extends Model
{
    static $PRODUCTOS_MAS_DEMANDADOS_ID=1;
    STATIC $DEMANDAS_PENDIENTES_CON_MAS_1_MES= 2;
    static $DEMANDAS_RECHAZADAS_ID= 3;
    static $SOLICITUDES_ACTIVAS_ID= 4;
    static $SOLICITUDES_CONTRATACION_FUERA_FECHA_ID= 5;
    static $VALOR_ORDENES_COMPLETADAS_ID= 6;
    static $TIEMPO_MEDIO_DE_RESPUESTA_PROVEEDORES_ID= 7;
    static $ORDENES_TRANSPORTACION_ACTIVAS_X_HITO_ID= 8;
    static $ORDENES_TRANSPORTACION_CON_HITOS_VENCIDOS_ID= 9;
    static $informList = [
        'Demandas' =>
            [
                1 => 'Productos más demandados.',
                2 => 'Demandas pendientes con más de un mes.',
                3 => 'Demandas rechazadas.'
            ],

        'Contratación' =>
                [
                    4=>'Órdenes activas',
                    5 => 'Órdenes de compra con hitos fuera de fecha.',
                    6 => 'Valor de las órdenes de compra completadas distribuidas por meses.',
                   // 7 => 'Tiempo medio de respuesta de proveedores a solicitud de ofertas.',
                ]
        ,
        'Transportación'=>
                [
                    8 => 'Órdenes activas por hito de transportación en que se encuentran.',
                    9=> 'Órdenes de compra con hitos de transportación vencidos.',

                ]



    ];
    public $inform;
    public $date_start;
    public $date_end;


    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        return [
            // username and password are both required
            [['inform', 'date_start', 'date_end'], 'required'],
            [['date_start', 'date_end'], 'validateDateRange']

        ];
    }

    public function validateDateRange()
    {
        $dateStart = strtotime(str_replace('/','-',$this->date_start));
        $dateEnd = strtotime(str_replace('/','-',$this->date_end));
        if ($dateStart > $dateEnd) {
           return  $this->addError('date_start', 'La fecha de inicio no puede ser mayor que la fecha de fin.');
        }


    }
    public function castDateToDB($date){
        $array = explode("/", $date);
        return $array[2].'-'.$array[1].'-'.$array[0];
    }

    /**
     * @return array customized attribute labels
     */
    public function attributeLabels()
    {
        return [
            'inform' => 'Informe',
            'date_start' => 'Inicio',
            'date_end' => 'Fín',

        ];
    }


}
