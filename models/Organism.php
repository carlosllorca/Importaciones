<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "organism".
 *
 * @property int $id
 * @property string $short_name
 * @property string $name
 *
 * @property Client[] $clients
 */
class Organism extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'organism';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['short_name', 'name'], 'required'],
            [['short_name'], 'string', 'max' => 10],
            [['name'], 'string', 'max' => 250],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'short_name' => 'Short Name',
            'name' => 'Name',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getClients()
    {
        return $this->hasMany(Client::className(), ['organism_id' => 'id']);
    }
}
