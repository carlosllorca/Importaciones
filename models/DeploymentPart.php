<?php

namespace app\models;

use Yii;
use yii\helpers\ArrayHelper;
/**
 * This is the model class for table "deployment_part".
 *
 * @property int $id
 * @property string $label
 *
 * @property Demand[] $demands
 */
class DeploymentPart extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    const UN_PLAZO=1;
    const OTRO_ID=5;
    public static function tableName()
    {
        return 'deployment_part';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['label'], 'string', 'max' => 150],
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
    public function getDemands()
    {
        return $this->hasMany(Demand::className(), ['deployment_part_id' => 'id']);
    }
    public static function combo(){
        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }
}
