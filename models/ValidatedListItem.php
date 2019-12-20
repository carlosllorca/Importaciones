<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "validated_list_item".
 *
 * @property int $id
 * @property string $seisa_code
 * @property string $product_name
 * @property string $tecnic_description
 * @property float $price

 * @property int $um_id
 * @property int|null $subfamily_id
 *
 * @property CertificationValidatedListItem[] $certificationValidatedListItems
 * @property DemandItem[] $demandItems
 * @property Subfamily $subfamily
 * @property Um $um
 */
class ValidatedListItem extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
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
            [['seisa_code', 'product_name', 'tecnic_description', 'price',  'um_id','subfamily_id'], 'required'],
            [['tecnic_description'], 'string'],
            [['price'], 'number'],
            [['certificados'], 'safe'],
            [[ 'um_id', 'subfamily_id'], 'default', 'value' => null],
            [[ 'um_id', 'subfamily_id'], 'integer'],
            [['seisa_code'], 'string', 'max' => 50],
            [['product_name'], 'string', 'max' => 200],
            [['seisa_code'], 'unique'],
            [['subfamily_id'], 'exist', 'skipOnError' => true, 'targetClass' => Subfamily::className(), 'targetAttribute' => ['subfamily_id' => 'id']],
            [['um_id'], 'exist', 'skipOnError' => true, 'targetClass' => Um::className(), 'targetAttribute' => ['um_id' => 'id']],
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
    public function getSubfamily()
    {
        return $this->hasOne(Subfamily::className(), ['id' => 'subfamily_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUm()
    {
        return $this->hasOne(Um::className(), ['id' => 'um_id']);
    }
}
