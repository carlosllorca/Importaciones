<?php

namespace app\models;

use Yii;
use yii\web\IdentityInterface;

/**
 * This is the model class for table "user".
 *
 * @property int $id
 * @property string $username
 * @property string $full_name
 * @property string $email
 * @property string $password
 * @property string $confirm_password
 * @property string $created_at
 * @property string|null $last_login
 * @property boolean $active
 * @property int|null $province_ueb
 *
 * @property BuyRequest[] $buyRequests
 * @property BuyRequestDocument[] $buyRequestDocuments
 * @property Demand[] $demands
 * @property Log[] $logs
 * @property Offert[] $offerts
 * @property Offert[] $offerts0
 * @property ProvinceUeb $provinceUeb
 * @property AuthItem $role
 * @property AuthAssignment $authAssignament
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
    const SCENARIO_CREATE_USER = 'createUser';


    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['username', 'full_name', 'email', 'password', 'created_at'], 'required'],
            [['created_at', 'last_login'], 'safe'],
            [['province_ueb'], 'default', 'value' => null],
            [['province_ueb'], 'integer'],
            [['email'], 'email'],
            [['password','confirm_password'], 'passwordsMatch','on'=>self::SCENARIO_CREATE_USER],
            [['rol'], 'required','on'=>self::SCENARIO_CREATE_USER],
            [['active'], 'boolean'],
            [['username'], 'string', 'max' => 25],
            [['full_name'], 'string', 'max' => 150],
            [['email'], 'string', 'max' => 50],
            [['province_ueb'], 'required',
                'when'=>function($model){
                    return $model->rol==Rbac::$UEB;
                },
                'whenClient' =>
                    "function (attribute, value) {
                     
                    return $('#user-rol').val() === 'ueb';
                }"],
            [['password'], 'string', 'max' => 100,'min'=>8,'tooShort'=>'La contraseña debe tener como mínimo 8 caracteres'],
            [['confirm_password'], 'string', 'max' => 100,'min'=>8,'tooShort'=>'La contraseña debe tener como mínimo 8 caracteres','on'=>self::SCENARIO_CREATE_USER],
            [['province_ueb'], 'exist', 'skipOnError' => true, 'targetClass' => ProvinceUeb::className(), 'targetAttribute' => ['province_ueb' => 'id']],
        ];
    }
    public function passwordsMatch($attribute, $params)
    {
        if ($this->password != $this->confirm_password) {
            $this->addError($attribute, 'Las contraseñas no coinciden.');
        }
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
            'created_at' => 'Creado',
            'last_login' => 'Último acceso',
            'province_ueb' => 'UEB',
            'active' => 'Activo',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequests()
    {
        return $this->hasMany(BuyRequest::className(), ['created_by' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequestDocuments()
    {
        return $this->hasMany(BuyRequestDocument::className(), ['last_updated_by' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDemands()
    {
        return $this->hasMany(Demand::className(), ['created_by' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getLogs()
    {
        return $this->hasMany(Log::className(), ['user_id' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOfferts()
    {
        return $this->hasMany(Offert::className(), ['upload_by' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOfferts0()
    {
        return $this->hasMany(Offert::className(), ['evaluated_by' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProvinceUeb()
    {
        return $this->hasOne(ProvinceUeb::className(), ['id' => 'province_ueb']);
    }
    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAuthAssignament()
    {
        return $this->hasOne(AuthAssignment::className(), ['user_id' => 'username']);

    }
    /**
     * @return \yii\db\ActiveQuery
     */
    public function getRole()
    {
        return $this->authAssignament->itemName;

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

    //no usadas
    public static function findIdentityByAccessToken($token, $type = null)
    {
        return null;
    }
    public function getAuthKey()
    {
        return null;
    }
    public function validateAuthKey($authKey)
    {
        return null;
    }
}
