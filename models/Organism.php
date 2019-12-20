<?php

namespace app\models;

use Yii;
use yii\helpers\ArrayHelper;

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
            [['short_name'], 'string', 'max' => 20],
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
            'short_name' => 'Iniciales',
            'name' => 'Nombre',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getClients()
    {
        return $this->hasMany(Client::className(), ['organism_id' => 'id']);
    }
    public static function combo(){
        if(Rbac::getRole()==Rbac::$UEB){
            return self::comboUEB();
        }
        return ArrayHelper::map(self::find()->orderBy('short_name')->all(),'id','short_name');
    }
    public static function comboUEB(){
        return ArrayHelper::map(self::find()->innerJoinWith('clients')->where(['client.province_ueb'=>Yii::$app->user->identity->province_ueb])->orderBy('short_name')->all(),'id','short_name');
    }
}
