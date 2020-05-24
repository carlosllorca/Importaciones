<?php

namespace app\models;

use Yii;
use yii\base\Model;

/**
 * ContactForm is the model behind the contact form.
 */
class ChangePasswordForm extends Model
{
    public $idUser;
    public $password;
    public $confirm_password;


    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        return [
            // name, email, subject and body are required
            [['idUser', 'password', 'confirm_password'], 'required'],
            [['password','confirm_password'], 'string', 'max' => 100,'min'=>8,'tooShort'=>'La contraseña debe tener como mínimo 8 caracteres'],
            [['password','confirm_password'], 'passwordsMatch'],

        ];
    }
    public function passwordsMatch($attribute, $params)
    {
        if ($this->password != $this->confirm_password) {
            $this->addError($attribute, 'Las contraseñas no coinciden.');
        }
    }

    /**
     * @return array customized attribute labels
     */
    public function attributeLabels()
    {
        return [
            'password' => 'Contraseña',
            'confirm_password' => 'Confirmar contraseña',
        ];
    }


}
