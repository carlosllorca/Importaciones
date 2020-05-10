<?php

namespace app\models;

use Yii;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "subfamily".
 *
 * @property int $id
 * @property string $label
 * @property int $validated_list_id
 *
 * @property ValidatedList $validatedList
 * @property ValidatedListItem[] $validatedListItems
 */
class Subfamily extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'subfamily';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label', 'validated_list_id'], 'required'],
            [['validated_list_id'], 'default', 'value' => null],
            [['validated_list_id'], 'integer'],
            [['label'], 'string', 'max' => 150],
            [['validated_list_id'], 'exist', 'skipOnError' => true, 'targetClass' => ValidatedList::className(), 'targetAttribute' => ['validated_list_id' => 'id']],
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
            'validated_list_id' => 'Validated List ID',
        ];
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
    public function getValidatedListItems()
    {
        return $this->hasMany(ValidatedListItem::className(), ['subfamily_id' => 'id']);
    }
    public static function combo($vl){
        return ArrayHelper::map(self::find()->where(['validated_list_id'=>$vl])->all(),'id','label');
    }
}
