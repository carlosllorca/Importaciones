<?php

class LoginFormCest
{
    public function _before(\FunctionalTester $I)
    {
        $I->amOnRoute('/site/login');
    }

    public function renderLoginPage(\FunctionalTester $I)
    {

        $I->see('Sistema para la gestión del ciclo logístico', 'h4');

    }
//
//    // demonstrates `amLoggedInAs` method
//    public function internalLoginById(\FunctionalTester $I)
//    {
//        $I->amLoggedInAs(100);
//        $I->amOnPage('/');
//        $I->see('Logout (admin)');
//    }
//
//    // demonstrates `amLoggedInAs` method
//    public function internalLoginByInstance(\FunctionalTester $I)
//    {
//        $I->amLoggedInAs(\app\models\User::findByUsername('admin'));
//        $I->amOnPage('/');
//        $I->see('Logout (admin)');
//    }
//
//    public function loginWithEmptyCredentials(\FunctionalTester $I)
//    {
//        $I->submitForm('#login-form', []);
//        $I->expectTo('see validations errors');
//        $I->see('Username cannot be blank.');
//        $I->see('Password cannot be blank.');
//    }
//
    public function loginWithWrongCredentials(\FunctionalTester $I)
    {
        $I->submitForm('#login-form', [
            'LoginForm[username]' => 'admin',
            'LoginForm[password]' => 'wrong0000000',
        ]);
        $I->expectTo('see validations errors');
        $I->see('Nombre de Usuario Contraseña Nombre de usuario o contraseña incorrectos.');
    }

    public function loginSuccessfully(\FunctionalTester $I)
    {
        $I->amOnPage('/site/login');
        $I->submitForm('#login-form', [
            'LoginForm[username]' => 'admin',
            'LoginForm[password]' => '12345678',
        ]);
       // $I->see('Logout (admin)');
        $I->dontSeeElement('form#login-form');
    }
}