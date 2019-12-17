<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "request_stage".
 *
 * @property int $id
 * @property int $offert_id
 * @property string $date_created
 * @property string $date_start
 * @property string $date_end
 * @property string|null $real_end
 * @property int $stage_id
 *
 * @property Offert $offert
 * @property Stage $stage
 */
class RequestStage extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'request_stage';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['offert_id', 'date_created', 'date_start', 'date_end', 'stage_id'], 'required'],
            [['offert_id', 'stage_id'], 'default', 'value' => null],
            [['offert_id', 'stage_id'], 'integer'],
            [['date_created', 'date_start', 'date_end', 'real_end'], 'safe'],
            [['offert_id'], 'exist', 'skipOnError' => true, 'targetClass' => Offert::className(), 'targetAttribute' => ['offert_id' => 'id']],
            [['stage_id'], 'exist', 'skipOnError' => true, 'targetClass' => Stage::className(), 'targetAttribute' => ['stage_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'offert_id' => 'Offert ID',
            'date_created' => 'Date Created',
            'date_start' => 'Date Start',
            'date_end' => 'Date End',
            'real_end' => 'Real End',
            'stage_id' => 'Stage ID',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOffert()
    {
        return $this->hasOne(Offert::className(), ['id' => 'offert_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getStage()
    {
        return $this->hasOne(Stage::className(), ['id' => 'stage_id']);
    }
}
