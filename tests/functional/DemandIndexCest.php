<?php


use app\models\User;

class DemandIndexCest
{
    public function _before(\FunctionalTester $I)
    {
       // $I->amOnRoute('/demand/index');
    }

    /**
     * @param FunctionalTester $I
     */
    public function showDemandIndex(\FunctionalTester $I)
    {
        $I->amLoggedInAs(User::findOne(14));
        $I->amOnRoute('/demand/index');
        // $I->amLoggedInAs(14);
        $I->see('Demandas','h4');
    }
    /**
     * @param FunctionalTester $I
     */
    public function showDemandView(\FunctionalTester $I)
    {
        $I->amLoggedInAs(User::findOne(14));
        $I->amOnRoute('/demand/view?id=30');
        // $I->amLoggedInAs(14);
        $I->see('Detalles de la demanda','h4');
        $I->see('D-2020-001','h5');
    }

}