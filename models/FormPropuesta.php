<?php

namespace app\models;

use kartik\file\FileInput;
use Yii;
use yii\base\Model;

/**
 * LoginForm is the model behind the login form.
 *
 * @property integer $provider This property is read-only.
 * @property BuyRequest $buyRequest This property is read-only.
 * @property integer $buy_request_id This property is read-only.
 * @property date $expiration_date This property is read-only.
 * @property FileInput $oferta This property is read-only.
 *
 */
class FormPropuesta extends Model
{
    public $provider;
    public $buyRequest;
    public $buy_request_id;
    public $expiration_date;
    public $oferta;
    public $url_file;
    public static $SCENARIO_UPLOAD='upload';
    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        return [

            [['provider','buy_request_id','expiration_date'], 'required'],
            ['url_file','safe'],
            [[ 'oferta'], 'required', 'on'=>self::$SCENARIO_UPLOAD],
            [['oferta'], 'file', 'skipOnEmpty' => true, 'extensions' => 'xls,xlsx,pdf,jpg,bmp','maxSize' => 2048*1024 ],

        ];
    }
    public function attributeLabels()
    {
        return [
            'provider'=>'Proveedor',
            'oferta'=>'Oferta',
            'expiration_date'=>'Fecha de expiración'
        ];
    }
    /*
     * Subir fichero
     */
    public function upload()
    {
        $name = Yii::$app->security->generateRandomString().'.'.$this->oferta->extension;
        $this->oferta->saveAs('offerts/' .$name);
        return '/offerts/' .$name;
    }

    /**
     * @return BuyRequest
     */
    public function buyRequest()
    {
        return BuyRequest::findOne($this->buy_request_id);
    }


}
