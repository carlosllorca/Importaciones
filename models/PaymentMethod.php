<?php

namespace app\models;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;
use Yii;
use yii\behaviors\TimestampBehavior;
/**
 * This is the model class for table "payment_method".
 *
 * @property int $id
 * @property string $label
 * @property string $description
 * @property boolean $active
 *
 * @property Demand[] $demands
 */
class PaymentMethod extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    const OTRO_ID=5;
    public static function tableName()
    {
        return 'payment_method';
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
    public function rules()
    {
        return [
            [['label','active'], 'required'],
            [['label'], 'string', 'max' => 150],
            [['description'], 'string'],
            [['active'], 'boolean'],
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
            'description' => 'Descripción',
            'active' => 'Activo',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDemands()
    {
        return $this->hasMany(Demand::className(), ['payment_method_id' => 'id']);
    }
    public static function combo(){
        return ArrayHelper::map(self::find()->where(['active'=>true])->orderBy('label')->all(),'id','label');
    }
    public static function extraData(){
        /**
         * @var $model TypeProject
         */

        $a =  ArrayHelper::map(self::find()->all(),'id',function($model){return ['item'=>$model->id,'label'=>$model->label,'description'=>nl2br($model->description)];});

        return $a;
    }
}
