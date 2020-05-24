<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;
/**
 * This is the model class for table "certification_validated_list_item".
 *
 * @property int $id
 * @property int $certification_id
 * @property int $validated_list_item_id
 *
 * @property Certification $certification
 * @property ValidatedListItem $validatedListItem
 */
class CertificationValidatedListItem extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'certification_validated_list_item';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['certification_id', 'validated_list_item_id'], 'required'],
            [['certification_id', 'validated_list_item_id'], 'default', 'value' => null],
            [['certification_id', 'validated_list_item_id'], 'integer'],
            [['certification_id'], 'exist', 'skipOnError' => true, 'targetClass' => Certification::className(), 'targetAttribute' => ['certification_id' => 'id']],
            [['validated_list_item_id'], 'exist', 'skipOnError' => true, 'targetClass' => ValidatedListItem::className(), 'targetAttribute' => ['validated_list_item_id' => 'id']],
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
            'certification_id' => 'Certification ID',
            'validated_list_item_id' => 'Validated List Item ID',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCertification()
    {
        return $this->hasOne(Certification::className(), ['id' => 'certification_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getValidatedListItem()
    {
        return $this->hasOne(ValidatedListItem::className(), ['id' => 'validated_list_item_id']);
    }
}
