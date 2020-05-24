<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "validated_list_item".
 *
 * @property int $id
 * @property string $seisa_code
 * @property string $product_name
 * @property string $tecnic_description
 * @property float $price

 * @property int $um_id
 * @property int|null $validated_list_id
 *
 * @property CertificationValidatedListItem[] $certificationValidatedListItems
 * @property DemandItem[] $demandItems
 * @property ValidatedList $validatedList
 * @property Um $um
 */
class ValidatedListItem extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public $quantity;
    public static function tableName()
    {
        return 'validated_list_item';
    }
    public $certificados;

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['product_name', 'tecnic_description', 'price',  'um_id'], 'required'],
            [['tecnic_description'], 'string'],
            [['price'], 'number'],
            [['certificados'], 'safe'],
            [[ 'um_id', 'subfamily_id'], 'default', 'value' => null],
            [[ 'um_id', 'subfamily_id'], 'integer'],
            [['seisa_code'], 'string', 'max' => 50],
            [['product_name'], 'string', 'max' => 200],
            [['seisa_code'], 'unique'],
            [['validated_list_id'], 'exist', 'skipOnError' => true, 'targetClass' => ValidatedList::className(), 'targetAttribute' => ['subfamily_id' => 'id']],
            [['um_id'], 'exist', 'skipOnError' => true, 'targetClass' => Um::className(), 'targetAttribute' => ['um_id' => 'id']],
        ];
    }
    /**
     * Setea la información de la última modificación de la tupla.
     * @return array|array[]
     */
    public function behaviors()
    {
        return [
            [
                'class' => TimestampBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['created_at','updated_at'],
                    ActiveRecord::EVENT_BEFORE_UPDATE => ['updated_at'],

                ],
                'value' => date('Y-m-d H:i:s'),
            ],
        ];
    }
    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'seisa_code' => 'Código SEISA',
            'product_name' => 'Nombre del producto',
            'tecnic_description' => 'Descripción técnica',
            'price' => 'Precio',
            'um_id' => 'UM',
            'subfamily_id' => 'Subfamilia',
            'certificados' => 'Certificación a exigir',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCertificationValidatedListItems()
    {
        return $this->hasMany(CertificationValidatedListItem::className(), ['validated_list_item_id' => 'id']);
    }
    public function certificados(){
        $certificados = [];
        foreach ($this->certificationValidatedListItems as $certificationValidatedListItem){
            array_push($certificados,$certificationValidatedListItem->certification_id);
        }
        return $certificados;
    }
    public function certificadosStr(){
        $certificados = [];
        foreach ($this->certificationValidatedListItems as $certificationValidatedListItem){
            array_push($certificados,$certificationValidatedListItem->certification->label);
        }
        return implode(', ',$certificados);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDemandItems()
    {
        return $this->hasMany(DemandItem::className(), ['validated_list_item_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getValidatedList()
    {
        return $this->hasOne(ValidatedList::className(), ['id' => 'validated_list_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUm()
    {
        return $this->hasOne(Um::className(), ['id' => 'um_id']);
    }
    public static function combo($vl){
        return ArrayHelper::map(ValidatedListItem::find()->where(['validated_list_id'=>$vl])->all(),'id','product_name');
    }

    /**
     * Combo solo con los productos de la demanda
     * @param integer $demand_id
     * @return array
     */
    public static function comboDemand($demand_id){

        return ArrayHelper::map(ValidatedListItem::find()->innerJoinWith('demandItems')
            ->where(['demand_item.demand_id'=>$demand_id])->all(),'id','product_name');
    }
}
