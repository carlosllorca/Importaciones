<?php


use app\models\User;

class DemandCreateCest
{
    public function _before(\FunctionalTester $I)
    {
       // $I->amOnRoute('/demand/index');
    }


    public function showDemandView(\FunctionalTester $I)
    {
        $I->amLoggedInAs(User::findOne(14));
        $I->amOnRoute('/demand/view?id=30');
        // $I->amLoggedInAs(14);
        $I->see('Detalles de la demanda','h4');
        $I->see('D-2020-001','h5');
    }
    /**
     * @param FunctionalTester $I
     */
    public function showDemandCreate(\FunctionalTester $I)
    {
        $I->amLoggedInAs(User::findOne(14));
        $I->amOnRoute('/demand/create');
        // $I->amLoggedInAs(14);
        $I->see('Nueva demanda','h4');
    }
    /**
     * @param FunctionalTester $I
     */
    public function sendDemandWithoutData(\FunctionalTester $I)
    {
        $I->amLoggedInAs(User::findOne(14));
        $I->amOnRoute('/demand/create');

        $I->submitForm('#demand_form',[]);
        $I->expectTo('see validations errors');
        $I->see('Número de contrato cannot be blank.');
        $I->see('A ejecutar con cannot be blank.');
        $I->see('Listado validado cannot be blank.');
        $I->see('Cliente cannot be blank.');
    }
    /**
     * @param FunctionalTester $I
     */
    public function sendDemandOk(\FunctionalTester $I)
    {
        $I->amLoggedInAs(User::findOne(14));
        $I->amOnRoute('/demand/create');

        $I->submitForm('#demand_form',[
            'Demand[client_contract_number]'=>'test',
            'Demand[payment_method-results]'=>1,
            'Demand[validated_list_id]'=>14,
            'Demand[payment_method_id]'=>1,
            'Demand[organism]'=>1,
            'Demand[client_id]'=>1,

        ]);
        $I->see('Añadir productos','h4');
        $I->dontSeeElement('form#demand_form');
    }
}