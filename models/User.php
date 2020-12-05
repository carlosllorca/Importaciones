<?php

namespace app\models;

use Yii;
use yii\db\ActiveQuery;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;
use yii\web\IdentityInterface;
use yii\behaviors\TimestampBehavior;
/**
 * This is the model class for table "user".
 *
 * @property int $id
 * @property string $username
 * @property string $full_name
 * @property string $email
 * @property string $password
 * @property string $confirm_password
 * @property string $cargo
 * @property string $phone_number
 * @property string $digital_signature_url
 * @property string $created_at
 * @property string|null $last_login
 * @property boolean $active
 * @property int|null $province_ueb
 *
 * @property BuyRequest[] $buyRequests
 * @property BuyRequestDocument[] $buyRequestDocuments
 * @property DocumentTypePermission[] $documentTypePermissions
 * @property Demand[] $demands
 * @property Demand[] $demandsApproved
 * @property Log[] $logs
 * @property Offert[] $offerts
 * @property Offert[] $offerts0
 * @property UserCanView[] $userCanViews
 * @property ProvinceUeb $provinceUeb
 * @property AuthItem $role
 * @property AuthAssignment $authAssignament
 * @property int $updated_at [timestamp]
 */
class User extends \yii\db\ActiveRecord implements IdentityInterface
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'user';
    }
    public $confirm_password;
    public $rol;
    public $user_can_view;
    const SCENARIO_CREATE_USER = 'createUser';


    /**
     * {@inheritdoc}
     */

    public function rules()
    {
        return [
            [['username', 'full_name', 'email', 'password', 'created_at','province_ueb','cargo'], 'required'],
            [['created_at', 'last_login'], 'safe'],
            [['province_ueb'], 'default', 'value' => null],
            [['province_ueb'], 'integer'],
            [['email'], 'email'],
            [['password','confirm_password'], 'passwordsMatch','on'=>self::SCENARIO_CREATE_USER],
            [['rol'], 'required'],
            ['user_can_view','safe'],
            [['active'], 'boolean'],
            [['username'], 'string', 'max' => 25],
            [['phone_number'], 'string', 'max' => 20],
            [['phone_number'], 'string', 'max' => 20],
            [['full_name','cargo'], 'string', 'max' => 80],
            [['full_name','cargo','digital_signature_url'], 'string', 'max' => 80],

            [['email'], 'string', 'max' => 50],
            [['province_ueb'], 'ralationUEBWithTypeUser'],
            [['password'], 'string', 'max' => 100,'min'=>8,'tooShort'=>'La contraseña debe tener como mínimo 8 caracteres'],
            [['confirm_password'], 'string', 'max' => 100,'min'=>8,'tooShort'=>'La contraseña debe tener como mínimo 8 caracteres','on'=>self::SCENARIO_CREATE_USER],
            [['province_ueb'], 'exist', 'skipOnError' => true, 'targetClass' => ProvinceUeb::className(), 'targetAttribute' => ['province_ueb' => 'id']],
        ];
    }


    public function ralationUEBWithTypeUser($attribute){
        if($this->rol==Rbac::$UEB&&$this->province_ueb==ProvinceUeb::$SEDE_CENTRAL_id){
            $this->addError($attribute, 'Los Especialistas de UEB no pueden pertenecer a la Sede central.');
        }
        if($this->rol!=Rbac::$UEB&&$this->province_ueb!=ProvinceUeb::$SEDE_CENTRAL_id){
            $this->addError($attribute, 'Solo los usuario con rol de Especialista UEB pueden pertenecer a UEB diferentes de Sede central.');
        }

    }
    public function passwordsMatch($attribute, $params)
    {
        if ($this->password != $this->confirm_password) {
            $this->addError($attribute, 'Las contraseñas no coinciden.');
        }
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
            'username' => 'Nombre de usuario',
            'full_name' => 'Nombre completo',
            'email' => 'Correo electrónico',
            'password' => 'Contraseña',
            'confirm_password' => 'Confirmar Contraseña',
            'user_can_view'=>'Tipos de ordenes que gestiona',
            'created_at' => 'Creado',
            'last_login' => 'Último acceso',
            'digital_signature' => 'Firma digital',
            'province_ueb' => 'UEB',
            'phone_number' => 'Teléfono',
            'active' => 'Activo',
        ];
    }

    /**
     * @return ActiveQuery
     */
    public function getBuyRequests()
    {
        return $this->hasMany(BuyRequest::className(), ['created_by' => 'id']);
    }


    /**
     * @return ActiveQuery
     */
    public function getBuyRequestDocuments()
    {
        return $this->hasMany(BuyRequestDocument::className(), ['last_updated_by' => 'id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getDemands()
    {
        return $this->hasMany(Demand::className(), ['created_by' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDocumentTypePermissions()
    {
        return $this->hasMany(DocumentTypePermission::className(), ['user_id' => 'id']);
    }
    /**
     * @return DocumentTypePermission[]
     */
    public function activesDocumentTypePermission()
    {
        $array = [];
        foreach ($this->documentTypePermissions as $documentTypePermission){
            if($documentTypePermission->documentType->active){
                array_push($array,$documentTypePermission);
            }

        }
        return $array;
    }
    public function arrayDocumentType()
    {
        $array = [];
        foreach ($this->documentTypePermissions as $documentTypePermission){
            array_push($array,$documentTypePermission->document_type_id);
        }
        return $array;
    }
    public function arrayCanView()
    {
        $array = [];
        foreach ($this->userCanViews as $userCanView){
            array_push($array,$userCanView->buy_request_type_id);
        }
        return $array;
    }
    public static function userCanViewOrder($buyRequestType,$user=false){
        if($user==false){
            $user=self::userLogged();
        }
        return in_array($buyRequestType,$user->arrayCanView());
    }

    /**
     * @return ActiveQuery
     */
    public function getLogs()
    {
        return $this->hasMany(Log::className(), ['user_id' => 'id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getOfferts()
    {
        return $this->hasMany(Offert::className(), ['upload_by' => 'id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getOfferts0()
    {
        return $this->hasMany(Offert::className(), ['evaluated_by' => 'id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getProvinceUeb()
    {
        return $this->hasOne(ProvinceUeb::className(), ['id' => 'province_ueb']);
    }
    /**
     * @return ActiveQuery
     */
    public function getAuthAssignament()
    {
        return $this->hasOne(AuthAssignment::className(), ['user_id' => 'username']);

    }
    /**
     * @return ActiveQuery
     */
    public function getDemandsApproved()
    {
        return $this->hasMany(Demand::className(), ['approved_by' => 'id']);
    }
    /**
     * @return AuthItem
     */
    public function getRole()
    {

        return $this->authAssignament?$this->authAssignament->itemName:false;

    }


    /**
     * Identity Interfeace clases
     */
    /**
     * @param int|string $id
     * @return User|IdentityInterface|null
     */
    public static function findIdentity($id)
    {
        return static::findOne(['username' => $id]);
    }

    /**
     * @return int|string
     */
    public function getId()
    {
        return $this->username;
    }

    /**
     * @param $username
     * @return User|null
     */
    public static function findByUsername($username)
    {
        return static::findOne(['username' => $username]);
    }

    /**
     * @param $password
     * @return bool
     */
    public function validatePassword($password)
    {
        if (Yii::$app->getSecurity()->validatePassword($password, $this->password)) {
            return true;
        }
        return false;
    }
    /**
     * Finds an identity by the given token.
     *
     * @param string $token the token to be looked for
     * @return IdentityInterface|null the identity object that matches the given token.
     */
    public static function findIdentityByAccessToken($token, $type = null)
    {
        return static::findOne(['access_token' => $token]);
    }
    /**
     * @param string $authKey
     * @return boolean if auth key is valid for current user
     */
    public function validateAuthKey($authKey)
    {
        return $this->getAuthKey() === $authKey;
    }

    //no usadas

    public function getAuthKey()
    {
        return null;
    }
    public static function combo($rol,$orderType=false){
        $query= self::find()->innerJoinWith('authAssignament')
            ->where(['auth_assignment.item_name'=>$rol])

            ->andWhere(['user.active'=>true]);
        if($orderType){
            $query= $query->innerJoinWith('userCanViews')->andWhere(['user_can_view.buy_request_type_id'=>$orderType]);
        }

        return ArrayHelper::map($query->all(),'id','full_name');

    }

    /**
     *
     * Devuelve el usuario autenticado o false si este no lo está.
     * @return User|false
     */
    static function userLogged(){
        if(Yii::$app->user->isGuest){
            return false;
        }else{
            return User::findOne(Yii::$app->user->identity->id);
        }

    }
    /**
     * Combo autores de las Solicitudes de compra
     */
    static  function comboAuthorBuyRequest(){
        return ArrayHelper::map(self::find()->innerJoinWith('buyRequests')->all(),'id','full_name');
    }

    /**
     * @param $rolename
     * @return User[]
     */
    static function getActiveUsersByRol($rolename){
        $users = User::findAll(['active'=>true]);
        $active  =[];
        foreach ($users as $user){
            if($user->getRole()->name==$rolename){
                array_push($active,$user);
            }
        }
        return $active;
    }
    /**
     * Gets query for [[UserCanViews]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUserCanViews()
    {
        return $this->hasMany(UserCanView::className(), ['user_id' => 'id']);
    }
    public function allowNomenclador(){
        if(Yii::$app->user->isGuest)
            return false;

        $nomencladores = ['certificationtype','certification','buycondition','destiny','finaldestiny','providerstatus','demandstatus',
            'buyrequeststatus','documentstatus','stage','paymentinstrument','paymentmethod','purchasereason','organism',
            'country','deploymentpart','sellerrequirement','warrantytime','documenttype','buyrequesttype','um'
            ];
        foreach ($nomencladores as $nomenclador){
            if(Yii::$app->user->can($nomenclador.'/index'))
                return true;
        }
        return false;
    }


}
