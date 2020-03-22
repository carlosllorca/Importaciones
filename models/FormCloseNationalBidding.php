<?php

namespace app\models;

use kartik\file\FileInput;
use Yii;
use yii\base\Model;
use yii\web\UploadedFile;

/**
 * LoginForm is the model behind the login form.
 *
 * @property integer $ganadores This property is read-only.

 *
 */
class FormCloseNationalBidding extends Model
{
    public $ganadores;
    public $buy_request_id;
    public $blank_contract;
    const SCENARIO_SELECT_WINNERS = 'select_winners';
    static  $seller_fields  =[

        DocumentType::PREFORMA_NACIONAL_ID=>'blank_contract',

    ];

    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        return [

            [['ganadores'], 'required','message'=>'Seleccione un ganador.'],
            [['blank_contract'], 'required','on'=>self::SCENARIO_SELECT_WINNERS],
            [['buy_request_id'], 'required'],
            [['blank_contract'], 'file', 'skipOnEmpty' => true, 'extensions' => 'pdf,doc,docx','maxSize' => 2048*1024 ],



        ];
    }
    public function attributeLabels()
    {
        return [
            'provider'=>'Proveedor',
            'oferta'=>'Oferta',
            'blank_contract'=>'Preforma de contrato'
        ];
    }
    /*
    * Subir fichero
    */
    public function upload($file)
    {
        $name = Yii::$app->security->generateRandomString().'.'.$this->$file->extension;
        $this->$file->saveAs('request_files/' .$name);
        return '/request_files/' .$name;
    }

    /**
     * @return BuyRequest
     */
    public function buyRequest()
    {
        return BuyRequest::findOne($this->buy_request_id);
    }
    public function loadInitialExpedientFilesUrl(){
        $a = ['blank_contract'];
        $url=[];
        foreach ($a as $i){
            $this->$i = UploadedFile::getInstance($this, $i);
            if($this->$i){
                $file= $this->upload($i);
                if($file){
                    $url[$i]= $file;
                }
            }else{
                $url[$i]=false;
            }
        }
        return $url;

    }

    /**
     * Generar el árbol de documentos necesarios del expediente.
     */
    public function generateFiledTree($fileUploaded){
        $fields = DocumentType::find()->where(['active'=>true])->andWhere(['buy_request_type_id'=>BuyRequestType::$NACIONAL_ID])->all();
        foreach ($fields as $field){
            $doc = new BuyRequestDocument();
            $doc->document_type_id=$field->id;
            $doc->buy_request_id=$this->buyRequest()->id;
            $doc->document_status_id=DocumentStatus::$PENDIENTE_ID;
            if(isset(self::$seller_fields[$field->id])&&$fileUploaded[self::$seller_fields[$field->id]]){
                $doc->url_to_file=$fileUploaded[self::$seller_fields[$field->id]];
                $doc->last_updated_by=User::userLogged()->id;
                $doc->document_status_id=DocumentStatus::$APROBADO_ID;
                $doc->last_update=date('Y-m-d');
            }
            $doc->save(false);
        }




    }


}
