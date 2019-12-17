<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "certification_type".
 *
 * @property int $id
 * @property string $label
 *
 * @property Certification[] $certifications
 */
class CertificationType extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'certification_type';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label'], 'required'],
            [['label'], 'string', 'max' => 50],
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
    public function getCertifications()
    {
        return $this->hasMany(Certification::className(), ['certification_type_id' => 'id']);
    }
}
