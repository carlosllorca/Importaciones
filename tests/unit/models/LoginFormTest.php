<?php

namespace tests\unit\models;

use app\models\LoginForm;
use yii\db\Exception;

class LoginFormTest extends \Codeception\Test\Unit
{
    private $model;

    protected function _after()
    {
        \Yii::$app->user->logout();
    }

    public function testSinCredenciales()
    {
        $this->model = new LoginForm([
            'username' => 'not_existing_username',
            'password' => 'not_existing_password',
        ]);

        expect_not($this->model->login());
        expect_that(\Yii::$app->user->isGuest);
    }

    public function testContraseñaIncorrecta()
    {
        $this->model = new LoginForm([
            'username' => 'admin',
            'password' => '123',
        ]);

        expect_not($this->model->login());
        expect_that(\Yii::$app->user->isGuest);
        expect($this->model->errors)->hasKey('password');
    }

    public function testAccesoCorrecto()
    {
        $this->model = new LoginForm([
            'username' => 'admin',
            'password' => '12345678',
        ]);

        expect_that($this->model->login());
        expect_not(\Yii::$app->user->isGuest);
        expect($this->model->errors)->hasntKey('password');
    }

    public function testGuardadoTraza()
    {
        $this->model = new LoginForm([
            'username' => 'admin',
            'password' => '12345678',
        ]);
        $this->model->login();
        expect_not(\Yii::$app->traza->saveLog('example','testSample'));
    }

}
