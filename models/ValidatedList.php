<?php

namespace app\models;

use Yii;

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
            'label' => 'Label',
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
        return $this->hasMany(ValidatedListItem::className(), ['validated_list_id' => 'id']);
    }
}
