<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;
/**
 * This is the model class for table "validated_list".
 *
 * @property int $id
 * @property string $label
 *
 * @property Demand[] $demands
 * @property ProviderValidatedList[] $providerValidatedLists
 * @property ValidatedListItem[] $validatedListItems
 */
class ValidatedList extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'validated_list';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['label'], 'string', 'max' => 250],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'label' => 'Nombre',
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
     * @return \yii\db\ActiveQuery
     */
    public function getDemands()
    {
        return $this->hasMany(Demand::className(), ['validated_list_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProviderValidatedLists()
    {
        return $this->hasMany(ProviderValidatedList::className(), ['validated_list_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getValidatedListItems()
    {
        return $this->hasMany(Subfamily::className(), ['validated_list_id' => 'id']);
    }
    public static function combo(){
        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }

}
