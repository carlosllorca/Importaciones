<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "provider".
 *
 * @property int $id
 * @property string $name
 * @property int $country_id
 * @property int $buy_request_type_id
 * @property string $address
 * @property bool $active
 * @property string $contact_name
 * @property string $contact_email
 * @property string $observation
 *
 * @property Country $country
 * @property ProviderValidatedList[] $providerValidatedLists
 * @property BuyRequestProvider[] $buyRequestProviders
 * @property BuyRequestType $buyRequestType
 */
class Provider extends \yii\db\ActiveRecord
{
    public $validated_list_associated;
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'provider';
    }


    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name', 'country_id', 'address', 'contact_name', 'contact_email','buy_request_type_id'], 'required'],
            [['name', 'address', 'contact_name', 'contact_email','observation'], 'string'],
            ['validated_list_associated','almostOne'],
            [['country_id'], 'default', 'value' => null],
            [['country_id'], 'integer'],
            [['active'], 'boolean'],
            [['country_id'], 'exist', 'skipOnError' => true, 'targetClass' => Country::className(), 'targetAttribute' => ['country_id' => 'id']],
            [['buy_request_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestType::className(), 'targetAttribute' => ['buy_request_type_id' => 'id']],
        ];
    }
    public function almostOne($attribute){
        if(!$this->$attribute){
            $this->addError($attribute,'Seleccione al menos un elemento.');
        }
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Nombre',
            'country_id' => 'País',
            'address' => 'Dirección',
            'active' => 'Activo',
            'validated_list_associated'=>'Listados validados asociados',
            'contact_name' => 'Persona de contacto',
            'contact_email' => 'Email de contacto',
            'observation' => 'Observaciones',
            'buy_request_type_id' => 'Tipo de solicitud',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCountry()
    {
        return $this->hasOne(Country::className(), ['id' => 'country_id']);
    }
    /**
     * Gets query for [[BuyRequestType]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestType()
    {
        return $this->hasOne(BuyRequestType::className(), ['id' => 'buy_request_type_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProviderValidatedLists()
    {
        return $this->hasMany(ProviderValidatedList::className(), ['provider_id' => 'id']);
    }
    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestProviders()
    {
        return $this->hasMany(BuyRequestProvider::className(), ['provider_id' => 'id']);
    }
    public static function combo(){
        return ArrayHelper::map(self::find()->orderBy('name')->all(),'id','name');
    }

    /**
     * Devuelve los providers asociados a los listados validados de la orden de compra.
     * @param $validatedLists
     * @return Provider[]|array|\yii\db\ActiveRecord[]
     */
    public static function related($validatedLists,$buyRequestType){

        $models = self::find()->innerJoinWith('providerValidatedLists')
            ->andWhere(['buy_request_type_id'=>$buyRequestType])
        ->andWhere(['provider_validated_list.validated_list_id'=>$validatedLists])
            ->andWhere(['active'=>true])
            ->groupBy('provider.id')->all();

        return $models;
    }

    /**
     * Aplica a la propiedad validated_list_associated array con los id de los listados validados asociados
     * @return void
     */
    public function loadValidatedList(){
        $r = [];
        foreach ($this->providerValidatedLists as $list){
            array_push($r,$list->validated_list_id);
        }
        $this->validated_list_associated=$r;
    }

}
