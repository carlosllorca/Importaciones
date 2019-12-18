<?php

namespace app\models;

use Yii;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "certification".
 *
 * @property int $id
 * @property string $label
 * @property int $certification_type_id
 *
 * @property CertificationType $certificationType
 * @property CertificationValidatedListItem[] $certificationValidatedListItems
 */
class Certification extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'certification';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label', 'certification_type_id'], 'required'],
            [['label'], 'string'],

            [['certification_type_id'], 'integer'],
            [['certification_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => CertificationType::className(), 'targetAttribute' => ['certification_type_id' => 'id']],
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
            'certification_type_id' => 'Tipo de certificación',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCertificationType()
    {
        return $this->hasOne(CertificationType::className(), ['id' => 'certification_type_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCertificationValidatedListItems()
    {
        return $this->hasMany(CertificationValidatedListItem::className(), ['certification_id' => 'id']);
    }
    public static function combo(){
        return ArrayHelper::map(self::find()->orderBy('label')->all(),'id','label');
    }
}
