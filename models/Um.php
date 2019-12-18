<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "um".
 *
 * @property int $id
 * @property string $label
 *
 * @property ValidatedListItem[] $validatedListItems
 */
class Um extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'um';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['label'], 'string'],
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
     * @return \yii\db\ActiveQuery
     */
    public function getValidatedListItems()
    {
        return $this->hasMany(ValidatedListItem::className(), ['um_id' => 'id']);
    }
    public static function combo(){
        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }
}
