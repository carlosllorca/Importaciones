<?php

namespace app\models;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;
use Yii;
use yii\behaviors\TimestampBehavior;
/**
 * This is the model class for table "document_type".
 *
 * @property int $id
 * @property string $label
 * @property string $responsable
 * @property bool $required
 * @property bool $active
 * @property int $buy_request_type_id
 * @property int $order_doc
 *
 * @property BuyRequestDocument[] $buyRequestDocuments
 * @property DocumentTypePermission[] $documentTypePermissions
 * @property BuyRequestType $buyRequestType
 */
class DocumentType extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    const PLIEGO_ID=1;
    const PREFORMA_ID=2;
    const PREFORMA_NACIONAL_ID=15;
    const FUNDAMENTACION_COMPRA_ID=3;
    public static function tableName()
    {
        return 'document_type';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['label','responsable','buy_request_type_id','order_doc'], 'required'],
            [['required','active'], 'boolean'],
            [['label'], 'string', 'max' => 150],
            [['responsable'], 'string', 'max' => 100],
            [['buy_request_type_id','order_doc'], 'integer'],
            [['buy_request_type_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequestType::className(), 'targetAttribute' => ['buy_request_type_id' => 'id']],
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
            'label' => 'Nombre',
            'required' => 'Requerido',
            'active' => 'Activo',
            'order_doc' => 'Orden',
            'buy_request_type_id' => 'Tipo de solicitud asociada',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestDocuments()
    {
        return $this->hasMany(BuyRequestDocument::className(), ['document_type_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDocumentTypePermissions()
    {
        return $this->hasMany(DocumentTypePermission::className(), ['document_type_id' => 'id']);
    }
    /**
     * Gets query for [[BuyRequestType]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestType()
    {
        return $this->hasOne(BuyRequestType::className(), ['id' => 'buy_request_type_id']);
    }
    public static function combo($differentTo=[]){
        return ArrayHelper::map(self::find()->where(['active'=>true])
            ->innerJoinWith('buyRequestType')
            ->andWhere(['not',['document_type.id'=>$differentTo]])
            ->orderBy('label')->all(),'id','label',function($model){return $model->buyRequestType->label; });
    }
    public function userLoggedCanView(){
        $model = DocumentTypePermission::findOne(['document_type_id'=>$this->id,'user_id'=>User::userLogged()->id]);
        if($model&&$model->allow_view){
            return true;
        }
        return false;
    }
    public function userLoggedCanUpdate(){
        $model = DocumentTypePermission::findOne(['document_type_id'=>$this->id,'user_id'=>User::userLogged()->id]);
        if($model&&$model->allow_update){
            return true;
        }
        return false;
    }

}
