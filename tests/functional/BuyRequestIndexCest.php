<?php


use app\models\User;

class BuyRequestIndexCestIndexCest
{
    public function _before(\FunctionalTester $I)
    {
       // $I->amOnRoute('/demand/index');
    }

    /**
     * @param FunctionalTester $I
     */
    public function showIndexByRolLogistica(\FunctionalTester $I)
    {
        $I->amLoggedInAs(User::findOne(23));
        $I->amOnRoute('/buy-request/index');
        // $I->amLoggedInAs(14);
        $I->see('Solicitudes de compra','h4');
    }
    /**
     * @param FunctionalTester $I
     */
    public function showIndexByRolJcompras(\FunctionalTester $I)
    {
        $I->amLoggedInAs(User::findOne(17));
        $I->amOnRoute('/buy-request/index');
        // $I->amLoggedInAs(14);
        $I->see('Solicitudes de compra','h4');
    }
    /**
     * @param FunctionalTester $I
     */
    public function showIndexByRolCinternacional(\FunctionalTester $I)
    {
        $I->amLoggedInAs(User::findOne(20));
        $I->amOnRoute('/buy-request/index');
        // $I->amLoggedInAs(14);
        $I->see('Solicitudes de compra','h4');
    }
    /**
     * @param FunctionalTester $I
     */
    public function showIndexByRolJtecnico(\FunctionalTester $I)
    {
        $I->amLoggedInAs(User::findOne(20));
        $I->amOnRoute('/buy-request/index');
        // $I->amLoggedInAs(14);
        $I->see('Solicitudes de compra','h4');
    }
    /**
     * @param FunctionalTester $I
     */
    public function showIndexByRolTecnico(\FunctionalTester $I)
    {
        $I->amLoggedInAs(User::findOne(20));
        $I->amOnRoute('/buy-request/index');
        // $I->amLoggedInAs(14);
        $I->see('Solicitudes de compra','h4');
    }

}