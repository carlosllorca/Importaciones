<?php
$params = require __DIR__ . '/params.php';
$db = require __DIR__ . '/test_db.php';

/**
 * Application configuration shared by all test types
 */
return [
    'id' => 'basic-tests',
    'language'=>'es',
    'basePath' => dirname(__DIR__),
    'aliases' => [
        '@bower' => '@vendor/bower-asset',
        '@npm'   => '@vendor/npm-asset',
    ],
    'language' => 'en-US',
    'components' => [
        'db' => $db,
        'mailer' => [
            'useFileTransport' => true,
        ],
        'formatter' => [
            'class' => 'yii\i18n\Formatter',
            'locale' => 'es-ES', //ej. 'es-ES'
            'language'=>'es-ES',
            'thousandSeparator' => '.',
            'decimalSeparator' => ',',
            'dateFormat' => 'dd/MM/Y',
            'datetimeFormat' => 'd/M/Y hh:i:ss a',
            'currencyCode' => '$',

        ],
        'traza'=>[
            'class' => 'app\components\TrazaComponent',
        ],
        'assetManager' => [
            'basePath' => __DIR__ . '/../web/assets',
        ],

        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            'rules' => [
            ],
        ],

        'user' => [
            'identityClass' => 'app\models\User',

            'authTimeout' => 86400,
            'enableAutoLogin' => true,
        ],
        'authManager' => [
            'class' => 'yii\rbac\DbManager',
        ],
        'request' => [
            'cookieValidationKey' => 'test',
            'enableCsrfValidation' => false,
            // but if you absolutely need it set cookie domain to localhost
            /*
            'csrfCookie' => [
                'domain' => 'localhost',
            ],
            */
        ],
    ],
    'params' => $params,
];
